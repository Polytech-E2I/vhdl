library ieee;
use ieee.std_logic_1164.all;

entity dp_sumn is
    generic(
        N: natural
    );

    port(
        in1: in std_logic_vector(N-1 downto 0);
        in2: in std_logic_vector(N-1 downto 0);
        clk: in std_logic;
        nrst:in std_logic;

        done:   out std_logic;
        sumout: out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of dp_sumn is
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

    component sousnbit is
        generic(
            N:          natural
        );
        port(
            Ain, Bin:   in std_logic_vector(N-1 downto 0);
            S:          out std_logic_vector(N-1 downto 0);
            C:          out std_logic
        );
    end component;

    component registre is
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

    component addnbit is
        generic(
            N:          natural
        );
        port(
            Ain, Bin:   in std_logic_vector(N-1 downto 0);
            S:          out std_logic_vector(N-1 downto 0);
            C:          out std_logic
        );
    end component;

    signal MUXIN_OUT:       std_logic_vector(N-1 downto 0) := (others => '0');
    signal SOUS_OUT:        std_logic_vector(N-1 downto 0) := (others => '0');
    signal SOUSCARRY_OUT:   std_logic := '0';
    signal SOUSREG_OUT:     std_logic_vector(N-1 downto 0) := (others => '0');
    signal ADD_OUT:         std_logic_vector(N-1 downto 0) := (others => '0');
    signal ADDREG_OUT:      std_logic_vector(N-1 downto 0) := (others => '0');
    signal MUXOUT_OUT:      std_logic_vector(N-1 downto 0) := (others => '0');

    signal REG_NRST:        std_logic := '0';
    signal NOT_DONE:        std_logic := '0';

begin
    REG_NRST <= nrst and not SOUSCARRY_OUT;
    done <= SOUSCARRY_OUT;
    NOT_DONE <= not SOUSCARRY_OUT;

    MUXIN: mux2v1 generic map(N => N)
        port map(
            D0  => in1,
            D1  => SOUSREG_OUT,
            S   => NOT_DONE,

            Y => MUXIN_OUT
        );
    SOUS: sousnbit generic map(N => N)
        port map(
            Ain => MUXIN_OUT,
            Bin => in2,

            S => SOUS_OUT,
            C => SOUSCARRY_OUT
        );
    SOUSREG: registre generic map(N => N)
        port map(
            D => SOUS_OUT,
            load => '1',
            nrst => REG_NRST,
            clk => clk,

            Q => SOUSREG_OUT
        );
    ADD: addnbit generic map(N => N)
        port map(
            Ain => SOUSREG_OUT,
            Bin => ADDREG_OUT,

            -- C => ???,
            S => ADD_OUT
        );
    ADDREG: registre generic map(N => N)
        port map(
            D => ADD_OUT,
            load => '1',
            nrst => REG_NRST,
            clk => clk,

            Q => ADDREG_OUT
        );
end;