----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
-- Design Name: 
-- Module Name:    Disp_VGAsync - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Disp_VGAsync is
	Port (Clk			: in  STD_LOGIC;
			CE				: in  STD_LOGIC;
			Reset			: in  STD_LOGIC;
			IMG			: OUT STD_LOGIC;
			HS				: OUT STD_LOGIC;
			VS				: OUT STD_LOGIC;
			VRAM_addr	: out STD_LOGIC_VECTOR(18 downto 0));
end Disp_VGAsync;

architecture Behavioral of Disp_VGAsync is

subtype coordX is integer range 0 to 800;
subtype coordY is integer range 0 to 521;
signal comptX : coordX := 0;
signal comptY : coordY := 0;
signal X : std_logic_vector(9 downto 0);
signal Y : std_logic_vector(8 downto 0);
signal img_x : std_logic;
signal img_y : std_logic;


begin
	
	VRAM_addr <= Y & X;
	img <= img_x AND img_y;

	process (Clk, Reset)
	begin 
		if (Reset = '1') then
			comptX <= 0;
			comptY <= 0;
		elsif (Clk'event and Clk='1') then
			if(CE = '1') then
				if comptX < 799 then 
					comptX <= comptX+1;
				else 
					comptX<= 0;
				end if;

				if comptX=0 then 
					if comptY<520 then 
						comptY <= comptY+1;
					else 
						comptY <= 0;
					end if;
				end if;
			end if;
		end if;
	end process;


	-- Génération de HSYNC + coord X
	process (comptX)
	begin
		-- Display
		if(comptX < 640) then
			HS <= '1';
			X <= std_logic_vector(to_unsigned(comptX, 10));
			img_x <= '1';
		else
			img_x <= '0';
			
			-- Front Porsh
			if(comptX < (640 + 16)) then
				HS <= '1';
				X <= (others => '0');
			else
				-- Pulse
				if(comptX < (640 + 16 + 96)) then
					HS <= '0';
					X <= (others => '0');
				-- Back Porsh
				else
					HS <= '1';
					X <= (others => '0');
				end if;
			end if;
		end if;
	end process;


	-- Génération de VSYNC + coord Y
	process (comptY)
	begin
		-- Display
		if(comptY < 480) then
			VS <= '1';
			Y <= std_logic_vector(to_unsigned(comptY, 9));
			img_y <= '1';
		else
			img_y <= '0';
		
			-- Front Porsh
			if(comptY < (480 + 10)) then
				VS <= '1';
			Y <= (others => '0');
			else
				-- Pulse
				if(comptY < (480 + 10 + 2)) then
					VS <= '0';
					Y <= (others => '0');
				-- Back Porsh
				else
					VS <= '1';
					Y <= (others => '0');
				end if;
			end if;
		end if;
	end process;

end Behavioral;

