----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2018 05:38:39 PM
-- Design Name: 
-- Module Name: watering - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity watering_system is
    Port (
		clk: in std_logic;
        clock		: in integer range 0 to 2359;
        Data		: in integer;
        Temperature	: in integer;
        command 	: in std_logic_vector(31 downto 0);
        status		: out std_logic
    );
end watering_system;

architecture Behavioral of watering_system is

begin
identifier : process( clk )
begin
	if command = "00000000000000000000000000000000" then
		status <= '0';
	elsif command = "11111111111111111111111111111111" then
		status <= '1';
	else
	    if Temperature < 0 then
	        status <= '1';
	    elsif clock > 600 and clock <= 1200 then
	        if Data <= 25 and Temperature > 35 then
	            status <= '1';
	        else
	            status <= '0';
	        end if ;
	    elsif clock > 1200 and clock <= 1600 then
	        if Data <= 20 and Temperature > 50 then
	            status <= '1';
	        else
	            status <= '0';
	        end if ;
	    elsif clock > 1600 and clock <= 1900 then
	        if Data <= 35 and Temperature < 30 then
	            status <= '1';
	        else
	            status <= '0';
	        end if ;
	    elsif (clock > 1900 and clock <= 2359) or (clock <= 600) then
	        if Data <= 70 then
	            status <= '1';
	        end if ;
	    else
	        status <= '0';
	    end if ;
	end if;
end process ; -- identifier

end Behavioral;
