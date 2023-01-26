library ieee;
use ieee.std_logic_1164.all;

entity fsm_sumn is
    port(
        -- Entrées de la machine d'état
        start: in std_logic;
        supo0: in std_logic;
        -- Entrée d'horloge
        clk:   in std_logic;
        -- Reset actif à l'état bas
        nrst:  in std_logic;

        -- Sorties de la machine d'état
        out_choix: out std_logic;
        out_load:  out std_logic;
        out_stop:  out std_logic
    );
end;

architecture impl of fsm_sumn is
    type FSM_Machine is (FSM_Idle, FSM_Add, FSM_Decrement, FSM_Output);
    signal current_state: FSM_Machine := FSM_Idle;
    signal next_state:    FSM_Machine := FSM_Idle;

    signal internal_start: std_logic := '0';

begin

    process (clk, nrst) is
    begin
        if( nrst = '0' ) then
            current_state <= FSM_Idle;
            internal_start <= '0';
        else
            internal_start <= start;
        end if;

        -- if( clk'event and clk = '1' ) then
        if( rising_edge(clk) ) then
            case current_state is
                when FSM_Idle =>
                    out_choix <= '0';
                    out_load  <= '0';
                    out_stop  <= '0';

                    if(internal_start = '0') then
                        next_state <= FSM_Idle;
                    elsif(supo0 = '0') then
                        next_state <= FSM_Output;
                    else
                        next_state <= FSM_Add;
                    end if;
                when FSM_Add =>
                    out_choix <= '0';
                    out_load  <= '1';
                    out_stop  <= '0';

                    next_state <= FSM_Decrement;

                when FSM_Decrement =>
                    out_choix <= '1';
                    out_load  <= '1';
                    out_stop  <= '0';

                    if(supo0 = '1') then
                        next_state <= FSM_Add;
                    else
                        next_state <= FSM_Output;
                    end if;

                when FSM_Output =>
                    out_stop <= '1';

                    if(supo0 = '1') then
                        next_state <= FSM_Idle;
                    else
                        next_state <= FSM_Output;
                    end if;
            end case;

            current_state <= next_state;
        end if;
    end process;
end;