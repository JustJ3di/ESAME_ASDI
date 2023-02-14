----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 11:30:52
-- Design Name: 
-- Module Name: Unit_A - Unit_A
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

entity Unit_A is
--  Port ( );
    port(
        rst, clk: in std_logic;
        
        req : out std_logic;
        ack : in std_logic;
        
        start : in std_logic;
        
        data : out std_logic_vector(3 downto 0)
    );

end Unit_A;

architecture Unit_A of Unit_A is

    component ROM_A is
    
            port(
                addr : in std_logic_vector(1 downto 0);
                do   : out std_logic_vector(3 downto 0)
            );
    
    end component;


    component generic_counter is
        Generic(
            N : integer := 4
        );
        Port(
            rst, clk    : in std_logic;
            evnt        : in std_logic; -- segnale di conteggio del counter
            count       : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio del counter
            );  
    end component;
    
    component RC_A is
   
        port(
            rst, clk: in std_logic;
            
            start   : in std_logic;
            
            ack     : in std_logic; --ACK DI B
            req     : out std_logic; -- REQ verso B
      
            evnt     : out std_logic;
            counting : in std_logic_vector(1 downto 0)
            
        );
    
    end component;

    signal address : std_logic_vector(1 downto 0);
    signal evnt    : std_logic;
    


begin
    
    CU_A : RC_A
        port map(
            clk      => clk,
            rst      => rst,
            req      => req,
            ack      => ack,
            start    => start,
            counting => address,
            evnt     => evnt
        );
        
      A_ROM: ROM_A
        port map(
            addr => address,
            do   => data
        );
    
      addr_counter: generic_counter
        generic map(4)
        port map(
            rst   => rst,
            clk   => clk,
            evnt  => evnt,
            count => address
        );


end Unit_A;
