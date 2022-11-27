library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modifin_tb is
end;

architecture tb of modifin_tb is
    constant N: natural := 4;

    -- UUT component
    component modifin is
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
    end component;

    -- UUT input signals
    signal X:           std_logic_vector(N-1 downto 0) := (others => 'U');
    signal CONSTZERO:   std_logic_vector(N-1 downto 0) := (others => '0');
    signal zero:        std_logic := '0';
    signal neg:         std_logic := '0';
    -- UUT output signals
    signal S:           std_logic_vector(N-1 downto 0) := (others => 'U');

    constant clock_period: time := 1 fs;

begin
    UUT: modifin
        generic map(
            N => N
        )
        port map(
            X => X,
            Y => CONSTZERO,
            zero => zero,
            neg => neg,
            S => S
        );

    X <= std_logic_vector(to_unsigned(13, X'length));

    zero <= not zero after clock_period;
    neg  <= not neg  after clock_period * 2;

end;