library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pgcounter_tb is
end;

architecture tb of pgcounter_tb is
    constant filename:  string := "testfile.txt";
    constant addrsize:  natural := 4;
    constant datasize:  natural := 8;

    -- UUT component
    component pgcounter is
        generic(
            addrsize:   natural;
            datasize:   natural
        );
        port(
            addr:   in std_logic_vector(addrsize-1 downto 0);
            jmp:    in std_logic;
            clk:    in std_logic;

            inst:   out std_logic_vector(datasize-1 downto 0)
        );
    end component;

    -- UUT input signals
    signal addr:    std_logic_vector(addrsize-1 downto 0) := (others => 'U');
    signal jmp:     std_logic := '0';
    signal clk:     std_logic := '0';
    -- UUT output signals
    signal inst:    std_logic_vector(datasize-1 downto 0);

    -- NEEDED TO FILL UP MEMORY ------------------------------------------------
    component MA_RAM is
        generic(
            load_file_name : string;
            dta : integer := 8;
            adr : integer := 4
        );
        port(
            address : in std_logic_vector(adr-1 downto 0);
            datain :  in std_logic_vector(dta-1 downto 0);
            wr_ena :  in std_logic;
            dataout : out std_logic_vector(dta-1 downto 0)
        );
    end component;

    signal address : std_logic_vector(addrsize-1 downto 0);
    signal datain :  std_logic_vector(datasize-1 downto 0);
    signal wr_ena :  std_logic := '0';
    signal dataout : std_logic_vector(datasize-1 downto 0);
    ----------------------------------------------------------------------------

    constant clock_period: time := 1 fs;

begin
    RAM: MA_RAM
        generic map(
            load_file_name => filename,
            adr => addrsize,
            dta => datasize
        )
        port map(
            address => address,
            datain => datain,
            wr_ena => wr_ena,
            dataout => dataout
        );
    UUT: pgcounter
        generic map(
            addrsize => addrsize,
            datasize => datasize
        )
        port map(
            addr => addr,
            jmp => jmp,
            clk => clk,
            inst => inst
        );

    clk <= not clk after clock_period;

    CASES: process
    begin
        -- Fill up memory
        wr_ena <= '1';
        for i in 0 to 15 loop
            address <= std_logic_vector(to_unsigned(i, address'length));
            datain <= std_logic_vector(to_unsigned(i+30, datain'length));
            wait for 1 fs;
        end loop;
        datain <= (others => 'U');
        wr_ena <= '0';

        wait for 2 fs;
        addr <= std_logic_vector(to_unsigned(13, addr'length));
        wait for 1 fs;
        jmp <= '1';
        wait for 10 fs;
        jmp <= '0';
        wait for 100 fs;
    end process;
end;