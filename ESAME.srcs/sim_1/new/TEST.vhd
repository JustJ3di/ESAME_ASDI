----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 14:24:44
-- Design Name: 
-- Module Name: TEST - Behavioral
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

entity TEST is
--  Port ( );
end TEST;

architecture Behavioral of TEST is

    --segnali di A
    signal rst_a, clk_a : std_logic;
        
    signal req_a : std_logic := '0';
    signal ack_a : std_logic := '0';
        
    signal start :  std_logic := '0';
    
    signal data_A_TO_B :  std_logic_vector(3 downto 0) := (others => '0');
    
    --segnali si B
    signal rst_b, clk_b : std_logic;
    signal req_c  : std_logic := '0';
    signal ack_c  : std_logic := '0';        
    signal data_B_TO_C : std_logic_vector(3 downto 0)  := (others => '0');
    
    --segnali di C
    signal rst_c, clk_c : std_logic;

    component Unit_A is
    --  Port ( );
        port(
            rst, clk: in std_logic;
            
            req : out std_logic;
            ack : in std_logic;
            
            start : in std_logic;
            
            data : out std_logic_vector(3 downto 0)
        );
    
    end component;
    
    component Unit_C is
    --  Port ( );
        port(
            clk, rst : in std_logic;
            
            req_b    : in std_logic;
            ack_b    : out std_logic;
            
            dato    : in std_logic_vector(3 downto 0)
        );
    end component;
    
    component Unit_B is
        port(
            rst ,clk : in std_logic;
            
            req_a    : in std_logic;
            ack_a    : out std_logic;
            dato_i   : in std_logic_vector(3 downto 0);
            
            req_c    : out std_logic;
            ack_c    : in std_logic;
            dato_o   : out std_logic_vector(3 downto 0)
            
        );
    
    end component;
                
begin

    TA:process
        begin
            clk_a <= '0';
            wait for 10ns;
            clk_a <= '1';
            wait for 10ns;
        end process;
    TB: process
        begin 
            clk_b <= '0';
            wait for 5ns;
            clk_b <= '1';
            wait for 5ns;
        end process;
    TC :process
        begin 
            clk_c <= '0';
            wait for 15ns;
            clk_c <= '1';
            wait for 15ns;
        end process;
    
    TSTART:process
        begin 
            wait for 100ns;
            start <= '1';
            wait;
        end process;
    
    A : Unit_A
    port map (
        clk => clk_a,
        rst => rst_a,
        req => req_a,
        ack     => ack_a,
        start  => start,
        data => data_A_TO_B
    );
    
    B: Unit_B
    port map(
        clk      => clk_b,
        rst      => rst_b,
        req_a    => req_a,
        ack_a    => ack_a,
        dato_i   => data_A_TO_B,
        req_c    => req_c,
        ack_c    => ack_c,
        dato_o   => data_B_TO_C    
    );
    
    C: Unit_C
       port map(
            clk => clk_c,
             
            rst => rst_c,
            
            req_b => req_c,
            ack_b => ack_c,
            
            dato   => data_B_TO_C
       
       );
    
end Behavioral;
