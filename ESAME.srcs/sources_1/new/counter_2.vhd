----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 12:20:29
-- Design Name: 
-- Module Name: counter_2 - counter_2
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

entity counter_2 is
    Generic(
        N : positive := 4
    );
    Port(
        rst, clk : in std_logic;
        evnt     : in std_logic; -- segnale di conteggio del counter
        count    : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio del counter
    );
end counter_2;

architecture counter_2 of counter_2 is

    signal internal_count : integer range 0 to N-1 := 2;

begin

    
    count <= std_logic_vector(to_unsigned(internal_count, count'length));
    
    process(clk)
        begin
        
            if(rising_edge(clk)) then
                
                if(rst = '1') then
                    internal_count <= 0;
                elsif(evnt = '1') then
                    internal_count <= (internal_count + 1) mod N;
                end if;
                
            end if;
            
    end process;

end counter_2;
