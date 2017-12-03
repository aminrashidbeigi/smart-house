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
 
ENTITY smart_parking_tb IS
END smart_parking_tb;
 
ARCHITECTURE behavior OF smart_parking_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT smart_parking
    PORT(
         clk : IN  std_logic;
         ready : IN  std_logic;
         digits : IN  std_logic_vector(0 to 16);
         command : IN  std_logic_vector(31 downto 0);
         floor1_hallway : OUT  std_logic;
         floor1_right : OUT  std_logic;
         floor1_left : OUT  std_logic;
         floor2_hallway : OUT  std_logic;
         floor2_right : OUT  std_logic;
         floor2_left : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ready : std_logic := '0';
   signal digits : std_logic_vector(0 to 16) := (others => '0');
   signal command : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal floor1_hallway : std_logic;
   signal floor1_right : std_logic;
   signal floor1_left : std_logic;
   signal floor2_hallway : std_logic;
   signal floor2_right : std_logic;
   signal floor2_left : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: smart_parking PORT MAP (
          clk => clk,
          ready => ready,
          digits => digits,
          command => command,
          floor1_hallway => floor1_hallway,
          floor1_right => floor1_right,
          floor1_left => floor1_left,
          floor2_hallway => floor2_hallway,
          floor2_right => floor2_right,
          floor2_left => floor2_left
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

        wait for clk_period*10;
        
        command <= "00000000000000000000000000000000";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000111";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001100101";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";

        wait for clk_period*10;
        
        command <= "00000000000000000000000001100101";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
          
        wait for clk_period*10;
        
        command <= "00000000000000000000000001100101";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
          
        wait for clk_period*10;
        
        command <= "00000000000000000000000001100101";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
        
        wait for clk_period*10;

        command <= "00000000000000000000000001100101";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
        -- 22222 inserted

          
        wait for clk_period*10;
        
        command <= "00000000000000000000000001010101";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
        -- * added

          
        wait for clk_period*10;
        
        command <= "00000000000000000000000001100101";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
        -- 2 added

          
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000111";
        
        wait for clk_period*10;
        
        command <= "00000000000000000000000001000110";
        -- sharp added

      -- insert stimulus here 

      wait;
   end process;

END;
