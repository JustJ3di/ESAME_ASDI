----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 11:37:56
-- Design Name: 
-- Module Name: counter_1 - counter_1
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

use IEEE.math_real.all;
USE ieee.math_real.log2;
USE ieee.math_real.ceil;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity generic_counter is
    Generic(
        N : integer := 4
    );
    Port(
        rst, clk    : in std_logic;
        evnt        : in std_logic; -- segnale di conteggio del counter
        count       : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio del counter
        );  
end generic_counter;

architecture generic_counter_v1 of generic_counter is

    signal internal_count : std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) := (others => '0');
    
begin
    
    count <= internal_count;
    
    process(clk)
        begin
            if(rising_edge(clk)) then
                
                if(rst = '1') then
                    internal_count <= (others => '0');
                elsif(evnt = '1') then
                    if(unsigned(internal_count) >= N-1) then
                        internal_count <= (others => '0');
                    else
                        internal_count <= std_logic_vector(unsigned(internal_count) + 1);
                    end if;
                end if;
                
            end if;
            
    end process;
    
end generic_counter_v1;