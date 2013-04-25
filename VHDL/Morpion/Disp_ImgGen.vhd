----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:51:47 04/25/2013 
-- Design Name: 
-- Module Name:    Disp_ImgGen - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Disp_ImgGen is
	port (Clk				: IN  STD_LOGIC;
			Ce					: IN  STD_LOGIC;
			Reset				: IN  STD_LOGIC;
			Pos_load			: IN  STD_LOGIC;
			Ok_load			: IN  STD_LOGIC;
			Pos_val			: IN  STD_LOGIC_VECTOR(7 downto 0);
			Ok_val			: IN  STD_LOGIC_VECTOR(7 downto 0);
			Player_val		: IN  STD_LOGIC;
			VRAM_AddrW		: OUT STD_LOGIC_VECTOR(18 downto 0);
			VRAM_DataW		: OUT STD_LOGIC_VECTOR(7 downto 0);
			VRAM_EnableW	: OUT STD_LOGIC);
end Disp_ImgGen;

architecture Behavioral of Disp_ImgGen is

component Disp_ImgGen_GridManager
	Port(	Clk			: IN  STD_LOGIC;
			Rst 			: IN  STD_LOGIC;
         CE 			: IN  STD_LOGIC;
			Ok_Load		: IN  STD_LOGIC;
			Player		: IN  STD_LOGIC;
			OK				: IN  STD_LOGIC_VECTOR(7 downto 0);
			Grid_State	: OUT STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player	: OUT STD_LOGIC_VECTOR(8 downto 0));
end component;

signal Grid_state : std_logic_vector(8 downto 0);
signal Grid_Player : std_logic_vector(8 downto 0);

begin
	VRAM_DataW <= "00000111" WHEN Player_val = '0' ELSE
						"00111000";
	VRAM_addrW <= "0000000100000000010";
	VRAM_enableW <= OK_load;
	
	
	GridManager : Disp_ImgGen_GridManager 
	port map(
		Clk			=> Clk,
		Rst 			=> Reset,
		CE 			=> Ce,
		Ok_Load		=> Ok_load,
		Player		=> Player_val,
		OK				=> OK_val,
		Grid_State	=> Grid_state,
		Grid_Player	=> Grid_Player);
	

end Behavioral;

