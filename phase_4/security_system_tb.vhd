--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:32:39 12/03/2017
-- Design Name:   
-- Module Name:   D:/Uni/Terms/5/FPGA - Dr Sahebzamani/Homeworks/2/bcdISE/bcd/smart_parking_tb.vhd
-- Project Name:  bcd
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: smart_parking
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY security_system_tb IS
END security_system_tb;
 
ARCHITECTURE behavior OF security_system_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT security_system
    PORT(
        clk     : in std_logic;
        door    : in std_logic;
        window : in std_logic;
        command : in std_logic_vector(31 downto 0);
        alarm   : out std_logic
    );
    END COMPONENT;
    

   --Inputs
   signal clk, door, window : std_logic := '0';
   signal command : std_logic_vector(31 downto 0) := (others => '0');

  --Outputs
   signal alarm : std_logic;
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: security_system PORT MAP (
          clk => clk,
          door => door,
          window => window,
          command => command,
          alarm => alarm
        );

   -- Clock process definitions
   clk_process :process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
 

    
   -- Stimulus process
   stim_proc: process
   begin    
      -- hold reset state for 100 ns.
        wait for 100 ns;  

        wait for clk_period*2;
        
        command <= "00000000000000000000000000000000";
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001000111"; -- #
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000010000010"; -- A
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001010101"; -- *
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001100010"; -- 1

        wait for clk_period*2;
        
        command <= "00000000000000000000000001100101"; -- 2
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001100110"; -- 3
          
        wait for clk_period*2;
        
        command <= "00000000000000000000000001101001"; -- 4
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001010100"; -- *
          
        wait for clk_period*2;
        
        command <= "00000000000000000000000001101001"; -- 4
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001100110"; -- 3
        
        wait for clk_period*2;

        command <= "00000000000000000000000001100101"; -- 2
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001100010"; -- 1
          
        wait for clk_period*2;
        
        command <= "00000000000000000000000001000111"; -- #

        wait for clk_period*2;
        wait for clk_period*2;
        wait for clk_period*2;
        wait for clk_period*2;
        
        command <= "00000000000000000000000001000110"; -- #

          
        wait for clk_period*2;
        
        command <= "00000000000000000000000010000011"; -- A
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001010100"; -- *

          
        wait for clk_period*2;
        
        command <= "00000000000000000000000001100011"; -- 1
        
        wait for clk_period*2;
        
        command <= "00000000000000000000000001000110"; -- #
        -- sharp added


      wait;
   end process;

END;
