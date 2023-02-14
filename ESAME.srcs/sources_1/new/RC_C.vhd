----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 13:41:34
-- Design Name: 
-- Module Name: RC_C - RC_C
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

entity RC_C is
--  Port ( );
    port (
        rst, clk : in std_logic;
        counting : in std_logic;
        req      : in std_logic;
        ack      : out std_logic;
        we       : out std_logic;
        evnt     : out std_logic
    );
    

end RC_C;

architecture RC_C of RC_C is
    type state is (WAIT_REQ, WRL, SAVE, FINISH);
    
    signal current_state : state := WAIT_REQ;
    
    signal next_state    : state := WAIT_REQ;

begin
        state_update : process(clk)
        begin
            if rising_edge(clk) then
                if rst = '1' then
                    current_state <= WAIT_REQ;
                else
                    current_state <= next_state;
                end if;
            end if;
        end process;
         automa : process(current_state, req, counting)
        begin
                case current_state is
                    when WAIT_REQ => 
                        evnt <= '0';
                        we   <= '0';
                        if(req = '1')then
                            next_state <= WRL;
                        elsif (req = '0')then
                            next_state <= WAIT_REQ;
                        end if;
                     when WRL =>
                        ack <= '1';
                        if(req = '1')then
                            next_state <= WRL;
                        elsif(req = '0') then
                            next_state <= SAVE;
                        end if;
                      when SAVE =>
                        ack  <= '0';
                        we   <= '1';                                                
                        evnt <= '1';
                        if(counting = '1')then 
                            next_state <= FINISH;
                        else 
                            next_state <= WAIT_REQ;
                        end if;
                       when FINISH =>
                        ack     <= '0';
                        we      <= '0';
                        evnt    <= '0';
                        
                    end case;
        end process;    


end RC_C;
