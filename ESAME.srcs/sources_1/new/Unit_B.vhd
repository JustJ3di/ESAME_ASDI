----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 12:12:22
-- Design Name: 
-- Module Name: Unit_B - Unit_B
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

entity Unit_B is
    port(
        rst ,clk : in std_logic;
        
        req_a    : in std_logic;
        ack_a    : out std_logic;
        dato_i   : in std_logic_vector(3 downto 0);
        
        req_c    : out std_logic;
        ack_c    : in std_logic;
        dato_o   : out std_logic_vector(3 downto 0)
        
    );

end Unit_B;

architecture Unit_B of Unit_B is

    component RC_B is
        port(
            rst, clk : in std_logic;
            
            req_a    : in   std_logic;
            ack_a    : out std_logic;
            
            
            req_c    : out std_logic;
            ack_c    : in std_logic;
           
           counting1 : in std_logic_vector(1 downto 0);
           evnt1     : out std_logic;
           we        : out std_logic;
           
           sel       : out std_logic;
           
           counting2 : in std_logic_vector(1 downto 0);
           evnt2     : out std_logic
           
        );
        
    end component;
    
    component mux_2_1 is
        
        port(
            input_0  : in std_logic_vector(1 downto 0);
            input_1  : in std_logic_vector(1 downto 0);
            output : out std_logic_vector(1 downto  0);
            selmux : in std_logic
        );
    
    end component;


    component async_read_generic_ram is
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
    end component;

    component generic_counter is
        Generic(
            N : positive := 4
        );
        Port(
            rst, clk : in std_logic;
            evnt     : in std_logic; -- segnale di conteggio del counter
            count    : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio del counter
        );
    end component;
    
    component counter_2 is
        Generic(
            N : positive := 4
        );
        Port(
            rst, clk : in std_logic;
            evnt     : in std_logic; -- segnale di conteggio del counter
            count    : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio del counter
        );
    end component;
    

    signal address : std_logic_vector(1 downto 0);

    signal evnt1     : std_logic;
    signal counting1 : std_logic_vector(1 downto 0);
    signal counting2 : std_logic_vector(1 downto 0);

    signal evnt2     : std_logic;
    signal we        : std_logic;
   
    signal sel_addr  : std_logic;

begin

    UCB: RC_B
        port map(
            rst => rst,
            clk => clk,
            req_a => req_a,
            ack_a => ack_a,
            
            req_c  => req_c,
            ack_c  => ack_c,
           

            sel         => sel_addr,
            
            we        => we,
           
            counting1 => counting1,
            evnt1     => evnt1,
           
            counting2 => counting2,
            evnt2     => evnt2
        );
     
     mux_addr: mux_2_1
        port map(
            input_0   => counting1,
            input_1   => counting2,
            selmux    => sel_addr,
            output    => address  
        
        );
     
     
     BRAM : async_read_generic_ram
        generic map(4,4)
        port map(
            clk  => clk,
            rst  => rst,
            we   => we,
            addr => address,
            di   => dato_i,
            do   => dato_o
        );
        
     addr1 : generic_counter
        Generic map(
            4
        )
        Port map(
            rst     => rst,
            clk     => clk,
            evnt    => evnt1,
            count   => counting1
        );
        
     addr2 : counter_2
        Generic map(
            4
        )
        Port map(
            rst     => rst,
            clk     => clk,
            evnt    => evnt2,
            count   => counting2
        );
end Unit_B;
