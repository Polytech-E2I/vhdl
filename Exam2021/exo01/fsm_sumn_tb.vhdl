library ieee;
use ieee.std_logic_1164.all;

entity fsm_sumn_tb is
end;

architecture tb of fsm_sumn_tb is

    -- UUT component
    component fsm_sumn is
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
    end component;

    -- UUT Input signals
    signal start: std_logic := '0';
    signal supo0: std_logic := '0';
    signal clk:   std_logic := '0';
    signal nrst:  std_logic := '0';

    -- UUT Output signals
    signal out_choix: std_logic;
    signal out_load:  std_logic;
    signal out_stop:  std_logic;

    constant clock_period: time := 2 fs;
begin
    clk <= not clk after clock_period/2;

    UUT: fsm_sumn
        port map(
            start => start,
            supo0 => supo0,
            clk   => clk,
            nrst  => nrst,

            out_choix => out_choix,
            out_load  => out_load,
            out_stop  => out_stop
        );

    nrst <= '1' after 3*clock_period;

    process is
    begin
        wait for 3*clock_period;

        -- Idle => Add
        start <= '1';
        supo0 <= '1';
        wait for clock_period;

        -- Add => Decrement
        wait for clock_period;

        -- Decrement => Add
        supo0 <= '1';
        wait for clock_period;

        -- Add => Decrement
        wait for clock_period;

        -- Decrement => Output
        supo0 <= '0';
        wait for clock_period;

        -- Output => Idle
        supo0 <= '1';
        wait for clock_period;

        -- Idle => Output
        start <= '1';
        supo0 <= '0';
        wait for clock_period;

        -- Output => Output
        supo0 <= '0';
        wait for clock_period;

        -- Output => Idle
        supo0 <= '1';
        wait for clock_period;

        -- Idle => Idle
        start <= '0';
        wait for clock_period;
    end process;
end;