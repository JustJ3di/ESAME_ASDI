----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 11:40:11
-- Design Name: 
-- Module Name: RC_A - RC_A
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

entity RC_A is
--  Port ( );
    port(
        rst, clk: in std_logic;
        
        start   : in std_logic;
        
        ack     : in std_logic; --ACK DI B
        req     : out std_logic;
  
        evnt     : out std_logic;
        counting : in std_logic_vector(1 downto 0)
        
    );

end RC_A;

architecture RC_A of RC_A is

    type state is (IDLE, WAIT_ACK, WAL, SND, FINISH);
    
    signal current_state : state := IDLE;
    
    signal next_state    : state := IDLE;


begin

        state_update : process(clk)
        begin
            if rising_edge(clk) then
                if rst = '1' then
                    current_state <= IDLE;
                else
                    current_state <= next_state;
                end if;
            end if;
        end process;

        automa : process(current_state, ack, counting, start)
        begin
                case current_state is
                    when IDLE =>
                        evnt <= '0';
                        req <= '0';
                        if(start = '1') then
                            next_state <= WAIT_ACK;
                        elsif (start = '1') then
                             next_state <= IDLE;
                        end if;
                    when WAIT_ACK =>
                        req  <= '1';
                        evnt <= '0';
                        if (ack = '0') then
                            next_state <= WAIT_ACK;
                        elsif (ack  = '1') then
                            next_state <= WAL;
                        end if;                        
                     when WAL =>
                        req <= '0';
                        if(ack = '1') then 
                            next_state <= WAL;
                        elsif(ack = '0')then
                            next_state <= SND;
                        end if; 
                      when SND =>
                        evnt <= '1';
                        if (counting = "11") then
                            next_state <= FINISH;
                        else
                            next_state <= WAIT_ACK;
                        end if;                       
                       when FINISH =>
                            evnt <= '0';                       
                        
                    end case;
        end process;    
        
    


end RC_A;
