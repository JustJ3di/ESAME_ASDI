----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 11:33:37
-- Design Name: 
-- Module Name: ROM - ROM
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

use ieee.numeric_std.all;
use IEEE.math_real.all;
USE ieee.math_real.log2;
USE ieee.math_real.ceil;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_A is

        port(
            addr : in std_logic_vector(1 downto 0);
            do   : out std_logic_vector(3 downto 0)
        );

end ROM_A;

architecture ROM_A of ROM_A is

type rom_type is array (0 to 3) of std_logic_vector(3 downto 0);
    signal ROM : rom_type := 
    (
    "0011",
    "0010",
    "0011",
    "0001"
    );


begin



process(addr)
    begin
        do <= ROM(to_integer(unsigned(addr)));
    end process;



end ROM_A;
