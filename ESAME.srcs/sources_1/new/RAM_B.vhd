----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 12:15:19
-- Design Name: 
-- Module Name: RAM_B - RAM_B
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

use ieee.numeric_std.all;
USE ieee.math_real.log2;
USE ieee.math_real.ceil;


entity async_read_generic_ram is
    Generic(
        register_size : integer := 4;
        n_register    : integer := 4
    );
    port(
        clk, rst : in  std_logic;
        we       : in  std_logic; -- write enable
        addr     : in  std_logic_vector(integer(ceil(log2(real(n_register))))-1 downto 0);
        di       : in  std_logic_vector(register_size-1 downto 0);
        do       : out std_logic_vector(register_size-1 downto 0)
    );
end async_read_generic_ram;

architecture async_read_generic_ram_v1 of async_read_generic_ram is 

type ram_type is array (n_register-1 downto 0) of std_logic_vector(register_size-1 downto 0);
signal RAM : ram_type := (others => (others => '0'));

begin 
process(clk) 
    begin
        if (rising_edge(clk)) then
            
            if (rst = '1') then
                RAM <= (others => (others => '0'));
            elsif (we = '1') then
                RAM(to_integer(unsigned(addr))) <= di;
            end if;
        end if;
    end process;
    do <= RAM(to_integer(unsigned(addr)));
end async_read_generic_ram_v1;