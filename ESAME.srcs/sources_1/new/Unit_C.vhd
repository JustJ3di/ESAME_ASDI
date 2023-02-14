----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 13:32:58
-- Design Name: 
-- Module Name: Unit_C - Unit_C
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

entity Unit_C is
--  Port ( );
    port(
        clk, rst : in std_logic;
        
        req_b    : in std_logic;
        ack_b    : out std_logic;
        
        dato    : in std_logic_vector(3 downto 0)
    );
end Unit_C;

architecture Unit_C of Unit_C is

      component async_read_generic_ram is
            Generic(
                register_size : integer := 4;
                n_register    : integer := 2
            );
            port(
                clk, rst : in  std_logic;
                we       : in  std_logic; -- write enable
                addr     : in  std_logic_vector(integer(ceil(log2(real(n_register))))-1 downto 0);
                di       : in  std_logic_vector(register_size-1 downto 0);
                do       : out std_logic_vector(register_size-1 downto 0)
            );
        end component;
    component generic_counter is
            Generic(
                N : positive := 2
            );
            Port(
                rst, clk : in std_logic;
                evnt     : in std_logic; -- segnale di conteggio del counter
                count    : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio del counter
            );
    end component;
    
    
    component RC_C is
--  Port ( );
        port (
            rst, clk : in std_logic;
            counting : in std_logic;
            req      : in std_logic;
            ack      : out std_logic;
            we       : out std_logic;
            evnt     : out std_logic
        );
   end component;

    signal address : std_logic;
    signal evnt    : std_logic;
    signal we      : std_logic;
    


begin
    
    UCC:RC_C
        port map(
            rst      => rst,
            clk      => clk,
            req      => req_b,
            ack      => ack_b,
            we       => we,
            evnt     => evnt,
            counting => address
        
        );
        
   addr : generic_counter
    generic map(2)
        port map(
            rst => rst,
            clk => clk,
            evnt => evnt,
            count(0) => address
        
        );

    RAM: async_read_generic_ram
        Generic map(
                4,
                2
            )
        port map(
                clk => clk,
                rst => rst,
                we  => we,
                addr(0) => address,
                di => dato,
                do => open
            );

end Unit_C;
