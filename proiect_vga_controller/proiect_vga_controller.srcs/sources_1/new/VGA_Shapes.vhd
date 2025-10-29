library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA_Shapes is
    Port (
        clk       : in  STD_LOGIC;                
        sw        : in  STD_LOGIC_VECTOR(5 downto 0);  
        btn       : in  STD_LOGIC_VECTOR(4 downto 0);  
        h_sync    : out STD_LOGIC;
        v_sync    : out STD_LOGIC;
        led : out STD_LOGIC_VECTOR(5 downto 0);
        red       : out STD_LOGIC_VECTOR(3 downto 0);
        green     : out STD_LOGIC_VECTOR(3 downto 0);
        blue      : out STD_LOGIC_VECTOR(3 downto 0)
    );
end VGA_Shapes;

architecture Behavioral of VGA_Shapes is

    
    signal clk25       : STD_LOGIC := '0';
    signal clk_div     : unsigned(1 downto 0) := (others => '0');

    
    signal h_count     : INTEGER range 0 to 799 := 0;
    signal v_count     : INTEGER range 0 to 524 := 0;
    signal video_on    : STD_LOGIC;

   
    signal x_offset    : INTEGER := 0;
    signal y_offset    : INTEGER := 0;

   
    signal shape_select : STD_LOGIC_VECTOR(1 downto 0);
    signal color_idx    : STD_LOGIC_VECTOR(1 downto 0);

   
    signal left_btn, right_btn, up_btn, down_btn, reset_btn : STD_LOGIC;

    
    signal pixel       : STD_LOGIC;
    signal red_col     : STD_LOGIC_VECTOR(3 downto 0);
    signal green_col   : STD_LOGIC_VECTOR(3 downto 0);
    signal blue_col    : STD_LOGIC_VECTOR(3 downto 0);

begin

    
    process(clk)
    begin
        if rising_edge(clk) then
            clk_div <= clk_div + 1;
            clk25 <= clk_div(1);
        end if;
    end process;

   
    process(clk25)
    begin
        if rising_edge(clk25) then
            if h_count = 799 then
                h_count <= 0;
                if v_count = 524 then
                    v_count <= 0;
                else
                    v_count <= v_count + 1;
                end if;
            else
                h_count <= h_count + 1;
            end if;
        end if;
    end process;

    h_sync <= '0' when (h_count >= 656 and h_count < 752) else '1';
    v_sync <= '0' when (v_count >= 490 and v_count < 492) else '1';
    video_on <= '1' when (h_count < 640 and v_count < 480) else '0';

   
    process(clk25)
    begin
        if rising_edge(clk25) then
            if reset_btn = '1' then
                x_offset <= 0;
                y_offset <= 0;
            elsif sw(0) = '1' then 
                if left_btn = '1' then x_offset <= x_offset - 10; end if;
                if right_btn = '1' then x_offset <= x_offset + 10; end if;
                if up_btn = '1' then y_offset <= y_offset - 10; end if;
                if down_btn = '1' then y_offset <= y_offset + 10; end if;
            end if;
        end if;
    end process;

    
    shape_select <= sw(4 downto 3);  
    color_idx    <= sw(2 downto 1);  

   
    process(h_count, v_count, x_offset, y_offset, shape_select)
    begin
        pixel <= '0';
        case shape_select is
            when "00" => -- patrat
                if (h_count >= 280 + x_offset and h_count < 360 + x_offset) and
                   (v_count >= 200 + y_offset and v_count < 280 + y_offset) then
                    pixel <= '1';
                end if;
            when "01" => -- triunghi
                if (v_count >= 200 + y_offset and v_count < 280 + y_offset) then
                    if (h_count >= 320 - (v_count - 200 - y_offset) + x_offset and
                        h_count <= 320 + (v_count - 200 - y_offset) + x_offset) then
                        pixel <= '1';
                    end if;
                end if;
            when "10" => -- cerc
                if ((h_count - (320 + x_offset))**2 + (v_count - (240 + y_offset))**2) < 1600 then
                pixel <= '1';
            end if;
            when "11" => -- dreptunghi
                if (h_count >= 260 + x_offset and h_count < 380 + x_offset) and
                   (v_count >= 190 + y_offset and v_count < 270 + y_offset) then
                    pixel <= '1';
                end if;
            when others => pixel <= '0';
        end case;
    end process;

    ROM_Color_inst: entity work.ROM_Color
        port map (
            Adr_Color    => color_idx,
            Enable_Color => '1',
            R            => red_col,
            G            => green_col,
            B            => blue_col
        );

    red   <= red_col   when (video_on = '1' and pixel = '1' and sw(5) = '1') else (others => '0');
    green <= green_col when (video_on = '1' and pixel = '1' and sw(5) = '1') else (others => '0');
    blue  <= blue_col  when (video_on = '1' and pixel = '1' and sw(5) = '1') else (others => '0');

    debounce_left: entity work.debouncer port map(clk => clk25, btn => btn(0), pulse => left_btn);
    debounce_right: entity work.debouncer port map(clk => clk25, btn => btn(1), pulse => right_btn);
    debounce_up: entity work.debouncer port map(clk => clk25, btn => btn(2), pulse => up_btn);
    debounce_down: entity work.debouncer port map(clk => clk25, btn => btn(3), pulse => down_btn);
    debounce_reset: entity work.debouncer port map(clk => clk25, btn => btn(4), pulse => reset_btn);
    
    led <= sw(5 downto 0);

    
end Behavioral;