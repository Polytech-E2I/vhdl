library ieee;
use ieee.std_logic_1164.all;

entity instdecodeur_tb is
end;

architecture tb of instdecodeur_tb is

    -- UUT component
    component instdecodeur is
        port(
            Xin:    in  std_logic_vector(15 downto 0);
            W:      out std_logic_vector(15 downto 0);
            ci:     out std_logic;
            sm:     out std_logic;
            opc:    out std_logic_vector(5 downto 0);
            dst:    out std_logic_vector(2 downto 0);
            cnd:    out std_logic_vector(2 downto 0)
        );
    end component;

    -- UUT input signals
    signal Xin:     std_logic_vector(15 downto 0) := (others => 'U');
    -- UUT output signals
    signal W:       std_logic_vector(15 downto 0);
    signal ci:      std_logic;
    signal sm:      std_logic;
    signal opc:     std_logic_vector(5 downto 0);
    signal dst:     std_logic_vector(2 downto 0);
    signal cnd:     std_logic_vector(2 downto 0);

begin
    UUT: instdecodeur
        port map(
            Xin => Xin,
            W => W,
            ci => ci,
            sm => sm,
            opc => opc,
            dst => dst,
            cnd => cnd
        );

    Xin <=
        "0100111011011010",
        "1110111011110001" after 2 fs,
        "UUUUUUUUUUUUUUUU" after 4 fs;

end;