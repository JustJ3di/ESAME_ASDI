----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2023 12:23:30
-- Design Name: 
-- Module Name: RC_B - RC_B
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

entity RC_B is
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
    
end RC_B;

architecture RC_B of RC_B is

    type state is (WREQA, WAIT_REQ_LOW, SAVE, AFINISH, WAIT_ACK_C, WAL, SEND, B_END);
    
    signal current_state : state := WREQA;
    
    signal next_state    : state := WREQA;


begin
        state_update : process(clk)
        begin
            if rising_edge(clk) then
                if rst = '1' then
                    current_state <= WREQA;
                else
                    current_state <= next_state;
                end if;
            end if;
        end process;
    
        automa : process(current_state, req_a, ack_c, counting1, counting2)
        begin
                case current_state is
                    when WREQA =>
                        sel <= '0';
                        evnt1 <= '0';
                        we    <= '0';
                        ack_a <= '0';
                        if(req_a = '1') then
                            next_state <= WAIT_REQ_LOW;
                        elsif (req_a = '0') then
                             next_state <= WREQA;
                        end if;
                     when WAIT_REQ_LOW =>
                        ack_a <= '1';
                        if (req_a = '1')then
                            next_state <= WAIT_REQ_LOW;                                              
                        elsif (req_a = '0') then
                            next_state <= SAVE;
                        end if;
                     
                     when SAVE => 
                        evnt1 <= '1';
                        we    <= '1';
                        ack_a <= '0';
                        if(counting1 = "11") then
                            next_state <= AFINISH;
                        else 
                            next_state <= WREQA;
                        end if;
                      
                      when AFINISH =>   
                         evnt1      <= '0';
                         we         <= '0';
                         ack_a      <= '0';
                         sel        <= '1';  -- cambio address
                         next_state <= WAIT_ACK_C;
                        
                      when WAIT_ACK_C =>
                           evnt2 <= '0';
                           req_c <= '1';
                           if(ack_c ='1') then
                                next_state <= WAL;
                           elsif(ack_c = '0') then
                                next_state <= WAIT_ACK_C;
                           end if;
                           
                       when WAL =>
                            req_c <= '0';
                            if(ack_c = '1')then
                                next_state <= WAL;
                            elsif(ack_c = '0')then
                                next_state  <= SEND;                            
                            end if;
                                                   
                       when SEND =>
                            evnt2 <= '1';
                            if(counting2 = "11") then
                                next_state <= B_END;
                            else
                                next_state <= WAIT_ACK_C;
                            end if;  
                        
                        when B_END => 
                            evnt2 <='0';                                                                                                      
                    end case;
        end process;    
        
        
end RC_B;
