----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2017 03:50:19 PM
-- Design Name: 
-- Module Name: smart_parking - Behavioral
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

entity smart_parking is
    port(
        clk: in std_logic;
        ready: in std_logic;
        digits: in integer range 11111 to 99999;
        command: in std_logic_vector(31 downto 0);
        floor1_hallway: out std_logic;
        floor1_right: out std_logic;
        floor1_left: out std_logic;
        floor2_hallway: out std_logic;
        floor2_right: out std_logic;
        floor2_left: out std_logic
    );
end smart_parking;

architecture RTL of smart_parking is

    type ADD_STATE_TYPE is (START, START1, P1, P2, P3, P4, P5, START2, L1, L2, FINISHED);
    signal add_state: ADD_STATE_TYPE;
    signal plate_input: integer := 0;
    signal location_input : integer := 0; 
    signal free_space : integer := 100;
    signal test : integer := 0;
    signal one_bit : std_logic;
    type database is array(0 to 100) of integer range 11111 to 100000;
    signal plate_array, plate_array_temp, location_array, location_array_temp: database := (others => 100000);

begin

    one_bit <= command(0);
    add_state_process : process( one_bit , clk)
    variable digit_ascii1: integer := 48;
    variable digit_ascii2: integer := 57;
    variable sharp: integer := 35;
    variable star: integer := 42;
    variable ascii_converted : integer;
    variable is_placed : boolean := false;
    begin
        ascii_converted := to_integer(unsigned(command(8 downto 1)));
        test <= ascii_converted;
        if (rising_edge(one_bit) and free_space /= 0) or (rising_edge(clk) and add_state = FINISHED) then
            case( add_state ) is
                when START =>
                    if ascii_converted = sharp then
                        add_state <= START1;
                    end if ;  
                when START1 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P1;
                        plate_input <= ascii_converted - 48;
                    else
                        add_state <= START;
                        plate_input <= 0;
                    end if ;  
                when P1 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P2;
                        plate_input <= ( 10 * plate_input ) + ascii_converted - 48;
                    else
                        add_state <= START;
                        plate_input <= 0;
                    end if ;
                when P2 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P3;
                        plate_input <= ( 10 * plate_input ) + ascii_converted - 48;
                        else
                        add_state <= START;
                        plate_input <= 0;
                    end if ;
                when P3 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P4;
                        plate_input <= ( 10 * plate_input ) + ascii_converted - 48;
                    else
                        add_state <= START;
                        plate_input <= 0;
                    end if ;
                when P4 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P5;
                        plate_input <= ( 10 * plate_input ) + ascii_converted - 48;
                    else
                        add_state <= START;
                        plate_input <= 0;
                    end if ;
                when P5 =>
                    if ascii_converted = star then
                        add_state <= START2;
                    else
                        add_state <= START;
                        plate_input <= 0;
                    end if ;
                when START2 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= L1;
                        location_input <= ascii_converted - 48;
                    end if ;  
                when L1 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= L2;
                        location_input <= ( 10 * location_input ) + ascii_converted - 48;
                    elsif ascii_converted = sharp then
                        add_state <= FINISHED;
                    end if ;
                when L2 =>
                    if ascii_converted = sharp then
                        add_state <= FINISHED;
                    end if ;
                when FINISHED =>
                -- insertion sort
                    for i in 0 to 100 loop
                        if i /= 0 then
                            if plate_input > plate_array(i) then
                                plate_array_temp(i) <= plate_array(i);
                                location_array_temp(i) <= location_array(i);
                            elsif plate_input < plate_array(i) and not is_placed then
                                plate_array_temp(i) <= plate_input;
                                location_array_temp(i) <= location_input;
                                is_placed := true;
                            else
                                location_array_temp(i) <= location_array(i-1);
                                plate_array_temp(i) <= plate_array(i-1);    
                            end if;
                        end if;
                    end loop;

                    temp_to_array : for i in 1 to 100 loop
                        location_array(i) <= location_array_temp(i);
                        plate_array(i) <= plate_array_temp(i);
                    end loop ; -- temp_to_array
                    is_placed := false;
                    free_space <= free_space - 1;
                    add_state <= START;
                when others =>
                    add_state <= START;
            end case ;
        end if ;
    end process ; -- add_state_process

end RTL;