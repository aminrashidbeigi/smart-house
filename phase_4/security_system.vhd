----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2018 12:46:33 PM
-- Design Name: 
-- Module Name: phase_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity security_system is port (
    clk     : in std_logic;
    door    : in std_logic;
    window : in std_logic;
    command : in std_logic_vector(31 downto 0);
    alarm   : out std_logic
);
end security_system;

architecture Behavioral of security_system is
    
    type STATE is (	START, ARMED, DISARMED, E1, E2, E3, E4, E5, E6, E7, E8, ARMING, 
    				CREATE_USER, CHANGE_PASS);
  	type USERDB is array(0 to 3, 0 to 50) of integer range -1 to 99;
  	type PASSDB is array(0 to 3) of integer range 0 to 9999;
  	type ONE_DIM is array (0 to 50) of integer range -1 to 99;
  	signal username_db : USERDB := (others => (others => 0));
  	signal password_db : PASSDB := (1234, 0, 0, 0);
    signal cur_state : STATE := START;
    signal armed_flag : std_logic := '0';
	signal one_bit : std_logic := '0';
	signal free : integer := 3;
	signal one_bit_signal : std_logic := '1';
	signal arg2_sig : integer;
begin
	
	one_bit <= command(0);

	process (clk, one_bit)
		variable sharp: integer := 35;
	    variable star: integer := 42;
	    variable ascii_converted : integer;
	    variable username : ONE_DIM := (others => -1);
	    variable arg2 : integer := 0;
	    variable arg3 : integer := 0;
	    variable username_index : integer := 0;
	    variable user_valid : boolean := false;
	    variable user_index : integer := 0;
	    variable timer : integer := 0;
	    
	begin
        ascii_converted := to_integer(unsigned(command(8 downto 1)));
		if rising_edge(clk) then
		  	if(one_bit_signal /= one_bit) then
				case (cur_state) is
					when START =>
						if armed_flag = '0' then
							cur_state <= DISARMED;
						else 
							cur_state <= ARMED;
						end if;

					when DISARMED =>
						arg2 := 0;
						arg3 := 0;
						username := (others => -1);
						if ascii_converted = sharp then
							cur_state <= E1;
						else
							cur_state <= DISARMED;		
						end if;

					when E1 =>
						if ascii_converted /= star then
							username(username_index) := ascii_converted;
							username_index := username_index + 1;
							cur_state <= E1;
						else 
							cur_state <= E2;
						end if;

					when E2 =>
						if ascii_converted /= star and ascii_converted /= sharp then
							arg2 := arg2 * 10 + (ascii_converted - 48);
						elsif ascii_converted = sharp then
							cur_state <= E3;
						else
							cur_state <= E5;
						end if;

					when E3 =>
						user_valid := false;
						for i in 0 to 3 loop
							if user_valid = false then
								user_valid := true;
								for j in 0 to 50 loop
									if user_valid = true then
										if username_db(i,j) /= username(j) then
											user_valid := false;
										end if;
									end if;
								end loop;
							end if;
						end loop;

						if user_valid = true then
							cur_state <= E4;
						else 
							cur_state <= DISARMED;
						end if;

					when E4 =>
						if arg2 = 1 then
							cur_state <= ARMING;
						else
							cur_state <= DISARMED;
						end if;

					when ARMING =>
						if timer /= 30 then
							timer := timer + 1;
						else
							timer := 0;
							alarm <= '1';
							cur_state <= ARMED;
						end if;

					when E5 =>
						user_valid := false;
						user_index := 0;
						for i in 0 to 3 loop
							if user_valid = false then
								user_index := i;
								user_valid := true;
								for j in 0 to 50 loop
									if user_valid = true then
										if username_db(i,j) /= username(j) then
											user_valid := false;
										end if;
									end if;
								end loop;
							end if;
						end loop;					

						if user_valid = true then
							cur_state <= E6;
						else
							cur_state <= E7;
						end if;

					when E6 =>
						if ascii_converted /= sharp then
							arg3 := arg3 * 10 + (ascii_converted - 48);
							cur_state <= E6;
						else
							cur_state <= CHANGE_PASS;
						end if;

					when CHANGE_PASS =>
						password_db(user_index) <= arg3;
						cur_state <= DISARMED;

					when E7 =>
						if arg2 = password_db(0) then
							cur_state <= E8;
						else
							cur_state <= DISARMED;
						end if;

					when E8 =>
						if ascii_converted /= sharp then
							arg3 := arg3 * 10 + (ascii_converted - 48);
							cur_state <= E8;
						elsif ascii_converted = sharp and free /= 0 then
							for i in 0 to 50 loop
								username_db(4 - free, i) <= username(i);
							end loop;
							free <= free - 1;
							cur_state <= DISARMED;
						else 
							cur_state <= DISARMED;
						end if;

					when others =>
						cur_state <= START;
				end case;
		        one_bit_signal <= one_bit; 
			end if;
		end if;	
		arg2_sig <= arg2;
	end process;


end Behavioral;
