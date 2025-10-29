library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    Port (
        clk   : in  STD_LOGIC;
        btn   : in  STD_LOGIC;
        pulse : out STD_LOGIC
    );
end debouncer;

architecture Behavioral of debouncer is
    signal btn_sync : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            btn_sync <= btn_sync(0) & btn;
            if btn_sync = "01" then
                pulse <= '1';
            else
                pulse <= '0';
            end if;
        end if;
    end process;
end Behavioral;
