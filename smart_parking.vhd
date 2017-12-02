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

    type ADD_STATE_TYPE: (START, START1, P1, P2, P3, P4, P5, START2, L1, L2, FINISHED);
    signal add_state: ADD_STATE_TYPE;

begin

    add_state_process : process( command(0) )
    variable digit_ascii1: integer := 48;
    variable digit_ascii2: integer := 57;
    variable sharp: integer := 35;
    variable star: integer := 42;
    variable ascii_converted : integer;
    begin
        ascii_converted := to_integer(unsigned(command(8 downto 1)));
        if (rising_edge(command(0))) then
            case( add_state ) is
                when START =>
                    if ascii_converted = sharp then
                        add_state <= START1;
                    end if ;  
                when START1 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P1;
                    end if ;  
                when P1 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P2;
                    end if ;
                when P2 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P3;
                    end if ;
                when P3 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P4;
                    end if ;
                when P4 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= P5;
                    end if ;  
                when P5 =>
                    if ascii_converted = star then
                        add_state <= START2;
                    end if ;
                when START2 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= L1;
                    end if ;  
                when L1 =>
                    if ascii_converted < digit_ascii2 and ascii_converted > digit_ascii1 then
                        add_state <= L2;
                    elsif ascii_converted = sharp then
                        add_state <= FINISHED;
                    end if ;
                when L2 =>
                    if ascii_converted = sharp then
                        add_state <= FINISHED;
                    end if ;
                when others =>
                    add_state <= START;
            end case ;
        end if ;
    end process ; -- add_state_process

end RTL;
