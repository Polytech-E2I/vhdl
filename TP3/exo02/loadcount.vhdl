library ieee;
use ieee.std_logic_1164.all;

entity loadcount is
    generic(
        N: natural
    );

    port(
        X:      in std_logic_vector(N-1 downto 0);
        st:     in std_logic;
        clk:    in std_logic;
        nrst:   in std_logic;

        S: out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of loadcount is
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

    REGEN <= st nand '0'; -- <=> not st

    S <= REGOUT;
end;

architecture alt of loadcount is
    signal tmp0:    std_logic_vector(N-1 downto 1) := (others => '0');
    signal tmp1:    std_logic_vector(N-1 downto 0);
begin
    tmp1 <= tmp0 & '1';

    process(st, nrst, clk)
    begin
        if st = '1' then
            S <= X;
        else
            if (clk'event and clk = '1') then
                S <= S + tmp1;
            end if;
        end if;
    end process;
end;