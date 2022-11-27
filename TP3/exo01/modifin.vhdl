library ieee;
use ieee.std_logic_1164.all;

entity modifin is
    generic(
        N: natural
    );

    port(
        X:      in std_logic_vector(N-1 downto 0);
        Y:      in std_logic_vector(N-1 downto 0);
        zero:   in std_logic;
        neg:    in std_logic;

        S:   out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of modifin is
    component mux2v1 is
        generic(
            N:  natural
        );

        port(
            D0: in std_logic_vector(N-1 downto 0);
            D1: in std_logic_vector(N-1 downto 0);
            S:  in std_logic;
            Y:  out std_logic_vector(N-1 downto 0)
        );
    end component;

    component inverseur is
        generic(
            N:  natural
        );

        port(
            X:      in std_logic_vector(N-1 downto 0);
            Xinv:   out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal MUX0OUT:     std_logic_vector(N-1 downto 0);
    signal INVOUT:      std_logic_vector(N-1 downto 0);

begin
    MUX0: mux2v1
        generic map(
            N => N
        )
        port map(
            X,
            Y,
            zero,
            MUX0OUT
        );

    INV: inverseur
        generic map(
            N => N
        )
        port map(
            MUX0OUT,
            INVOUT
        );

    MUXINV: mux2v1
        generic map(
            N => N
        )
        port map(
            MUX0OUT,
            INVOUT,
            neg,
            S
        );
end;