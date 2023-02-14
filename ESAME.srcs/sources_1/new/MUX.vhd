----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 13:15:23
-- Design Name: 
-- Module Name: MUX - Behavioral
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

entity mux_2_1 is
    
    port(
        input_0  : in std_logic_vector(1 downto 0);
        input_1  : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(1 downto  0);
        selmux : in std_logic
    );

end mux_2_1;

architecture Behavioral of mux_2_1 is

begin
    output <= input_0 when selmux = '0' else
              input_1 when selmux = '1' else
              (others => '-');
              
end Behavioral;
