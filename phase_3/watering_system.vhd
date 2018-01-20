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

entity watering is
    Port (
        clock		: in integer range 0 to 2359;
        Data		: in integer;
        Temperature	: in integer;
        command 	: in std_logic_vector(31 downto 0);
        status		: out boolean
    );
end watering;

architecture Behavioral of watering is

begin
identifier : process( clock, Data, Temperature )
begin
	if command = "00000000000000000000000000000000" then
		status <= false;
	elsif command = "11111111111111111111111111111111" then
		status <= true;
	else
	    if Temperature < 0 then
	        status <= true;
	    elsif clock > 600 and clock <= 1200 then
	        if Data <= 25 and Temperature > 35 then
	            status <= true;
	        else
	            status <= false;
	        end if ;
	    elsif clock > 1200 and clock <= 1600 then
	        if Data <= 20 and Temperature > 50 then
	            status <= true;
	        else
	            status <= false;
	        end if ;
	    elsif clock > 1600 and clock <= 1900 then
	        if Data <= 35 and Temperature < 30 then
	            status <= true;
	        else
	            status <= false;
	        end if ;
	    elsif (clock > 1900 and clock <= 2359) or (clock <= 600) then
	        if Data <= 70 then
	            status <= true;
	        end if ;
	    else
	        status <= false;
	    end if ;
	end if;
end process ; -- identifier

end Behavioral;
