library ieee;
use ieee.std_logic_1164.all;

entity alu is
    generic(
        N: natural
    );

    port(
        X:  in std_logic_vector(N-1 downto 0);
        Y:  in std_logic_vector(N-1 downto 0);

        zx: in std_logic;
        nx: in std_logic;
        zy: in std_logic;
        ny: in std_logic;
        f:  in std_logic;
        no: in std_logic;

        S:  out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of alu is
    component modifin is
        generic(
            N: natural
        );

        port(
            X:      in std_logic_vector(N-1 downto 0);
            Y:      in std_logic_vector(N-1 downto 0);
            zero:   in std_logic;
            neg:    in std_logic;

            S:      out std_logic_vector(N-1 downto 0)
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

    signal CONSTZERO:   std_logic_vector(N-1 downto 0) := (others => '0');

    signal MODIFXOUT: std_logic_vector(N-1 downto 0) := (others => 'U');
    signal MODIFYOUT: std_logic_vector(N-1 downto 0) := (others => 'U');
    signal ADDOUT:    std_logic_vector(N-1 downto 0) := (others => 'U');
    signal ANDOUT:    std_logic_vector(N-1 downto 0) := (others => 'U');

begin
    MODIFX: modifin
        generic map(
            N => N
        )
        port map(
            X,
            CONSTZERO,
            zx,
            nx,
            MODIFXOUT
        );
    MODIFY: modifin
        generic map(
            N => N
        )
        port map(
            Y,
            CONSTZERO,
            zy,
            ny,
            MODIFYOUT
        );
    ADD: addnbit
        generic map(
            N => N
        )
        port map(
            MODIFXOUT,
            MODIFYOUT,
            ADDOUT
        );

    MODIFEND: modifin
        generic map(
            N => N
        )
        port map(
            ANDOUT,
            ADDOUT,
            f,
            no,
            S
        );

    ANDOUT <= MODIFXOUT and MODIFYOUT;
end;