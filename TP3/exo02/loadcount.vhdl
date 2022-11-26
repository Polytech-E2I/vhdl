library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity loadcount is
    generic(
        N: natural
    );

    port(
        E:      in std_logic_vector(N-1 downto 0);
        st:     in std_logic;
        clk:    in std_logic;
        nrst:   in std_logic;

        S: out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl01 of loadcount is
    component increment is
        generic(
            N:  natural
        );

        port(
            X:      in std_logic_vector(N-1 downto 0);
            Xplus1: out std_logic_vector(N-1 downto 0)
        );
    end component;

    component mux2v1
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

    component registre
        generic(
            N: natural
        );
        port(
            D:      in std_logic_vector(N-1 downto 0);
            load:   in std_logic;
            nrst:   in std_logic;
            clk:    in std_logic;
            Q:      out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal INCROUT: std_logic_vector(N-1 downto 0) := (others => 'U');
    signal MUXOUT:  std_logic_vector(N-1 downto 0) := (others => 'U');
    signal REGOUT:  std_logic_vector(N-1 downto 0) := (others => 'U');
    signal REGEN:   std_logic := 'U';

begin

    MUX: mux2v1
        generic map(
            N =>N
        )
        port map(
            X,
            INCROUT,
            st,
            MUXOUT
        );

    INCR: increment
        generic map(
            N => N
        )
        port map(
            REGOUT,
            INCROUT
        );

    REG: registre
        generic map(
            N => N
        )
        port map(
            MUXOUT,
            REGEN,
            nrst,
            clk,
            REGOUT
        );

    REGEN <= st; --st nand '0'; -- <=> not st

    S <= REGOUT;
end;

architecture impl02 of loadcount is
    component increment is
        generic(
            N:  natural
        );

        port(
            X:      in std_logic_vector(N-1 downto 0);
            Xplus1: out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal X:      std_logic_vector(N-1 downto 0) := (others => '0');
    signal Xplus1: std_logic_vector(N-1 downto 0) := (others => 'U');

begin
    INCR: increment
        generic map(
            N => N
        )
        port map(
            X,
            Xplus1
        );

    process(st, nrst, clk)
    begin
        if nrst = '0' then
            S <= std_logic_vector(to_unsigned(0, S'length));
            X <= std_logic_vector(to_unsigned(0, X'length));
        else
            if st = '1' then
                S <= E;
                X <= E;
            else
                if (clk'event and clk = '1') then
                    S       <= Xplus1;
                    X       <= Xplus1;
                end if;
            end if;
        end if;
    end process;
end;

architecture impl03 of loadcount is
begin

    S <= std_logic_vector(to_unsigned(42, S'length));
end;
