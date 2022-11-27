library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end;

architecture tb of alu_tb is
    constant N: natural := 8;

    -- UUT component
    component alu is
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
    end component;

    -- UUT input signals
    signal X: std_logic_vector(N-1 downto 0) := (others => 'U');
    signal Y: std_logic_vector(N-1 downto 0) := (others => 'U');

    signal zx: std_logic := 'U';
    signal nx: std_logic := 'U';
    signal zy: std_logic := 'U';
    signal ny: std_logic := 'U';
    signal f:  std_logic := 'U';
    signal no: std_logic := 'U';

    signal S: std_logic_vector(N-1 downto 0) := (others => 'U');

begin
    UUT: alu
        generic map(
            N => N
        )
        port map(
            X => X,
            Y => Y,
            zx => zx,
            nx => nx,
            zy => zy,
            ny => ny,
            f => f,
            no => no,
            S => S
        );

    X <= std_logic_vector(to_unsigned(57, X'length));
    Y <= std_logic_vector(to_unsigned(66, Y'length));

    CASES: process
    begin
        zx<='1';nx<='0';zy<='1';ny<='0';f<='1';no<='0'; -- 0
        wait for 1 fs;
        zx<='1';nx<='1';zy<='1';ny<='1';f<='1';no<='1'; -- 1
        wait for 1 fs;
        zx<='1';nx<='1';zy<='1';ny<='0';f<='1';no<='0'; -- -1
        wait for 1 fs;
        zx<='0';nx<='0';zy<='1';ny<='1';f<='0';no<='0'; -- X
        wait for 1 fs;
        zx<='1';nx<='1';zy<='0';ny<='0';f<='0';no<='0'; -- Y
        wait for 1 fs;
        zx<='0';nx<='0';zy<='1';ny<='1';f<='0';no<='1'; -- not X
        wait for 1 fs;
        zx<='1';nx<='1';zy<='0';ny<='0';f<='0';no<='1'; -- not Y
        wait for 1 fs;
        zx<='0';nx<='0';zy<='1';ny<='1';f<='1';no<='1'; -- -X
        wait for 1 fs;
        zx<='1';nx<='1';zy<='0';ny<='0';f<='1';no<='1'; -- -Y
        wait for 1 fs;
        zx<='0';nx<='1';zy<='1';ny<='1';f<='1';no<='1'; -- X+1
        wait for 1 fs;
        zx<='1';nx<='1';zy<='0';ny<='1';f<='1';no<='1'; -- Y+1
        wait for 1 fs;
        zx<='0';nx<='0';zy<='0';ny<='0';f<='1';no<='0'; -- X+Y
        wait for 1 fs;
        zx<='0';nx<='0';zy<='1';ny<='1';f<='1';no<='0'; -- X-1
        wait for 1 fs;
        zx<='1';nx<='1';zy<='0';ny<='0';f<='1';no<='0'; -- Y-1
        wait for 1 fs;
        zx<='0';nx<='1';zy<='0';ny<='0';f<='1';no<='1'; -- X-Y
        wait for 1 fs;
        zx<='0';nx<='0';zy<='0';ny<='1';f<='1';no<='1'; -- Y-X
        wait for 1 fs;
        zx<='0';nx<='0';zy<='0';ny<='0';f<='0';no<='0'; -- X&Y
        wait for 1 fs;
        zx<='0';nx<='1';zy<='0';ny<='1';f<='0';no<='1'; -- X|Y
        wait for 1 fs;
    end process;
end;