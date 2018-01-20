----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2018 05:20:54 PM
-- Design Name: 
-- Module Name: smart_house - Behavioral
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

entity smart_house is
    Port (
        clk: in std_logic;
        ready: in std_logic;
        digits: in integer range 11111 to 99999;
        command_smart_parking: in std_logic_vector(31 downto 0);

        clock: in integer range 0 to 2359;
        Data: in integer;
        Temperature	: in integer;
        command_watering_system : in std_logic_vector(31 downto 0);

        door: in std_logic;
        window: in std_logic;
        command_security_system : in std_logic_vector(31 downto 0);

        floor1_hallway: out std_logic;
        floor1_right: out std_logic;
        floor1_left: out std_logic;
        floor2_hallway: out std_logic;
        floor2_right: out std_logic;
        floor2_left: out std_logic;

        status: out std_logic;

        alarm: out std_logic
    );
end smart_house;

architecture Behavioral of smart_house is

component smart_parking is
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
end component;

component watering_system is
    Port (
        clk         : in std_logic;
        clock		: in integer range 0 to 2359;
        Data		: in integer;
        Temperature	: in integer;
        command 	: in std_logic_vector(31 downto 0);
        status		: out std_logic
    );
end component;

component security_system is port (
    clk     : in std_logic;
    door    : in std_logic;
    window : in std_logic;
    command : in std_logic_vector(31 downto 0);
    alarm   : out std_logic
);
end component;

begin
    smart_parking_module: smart_parking port map (clk, ready, digits, command_smart_parking, floor1_hallway, floor1_right, floor1_left, floor2_hallway, floor2_right, floor2_left);
    watering_system_module: watering_system port map (clk, clock, Data, Temperature, command_watering_system, status);
    security_system_module: security_system port map (clk, door, window, command_security_system, alarm);
    
end Behavioral;
