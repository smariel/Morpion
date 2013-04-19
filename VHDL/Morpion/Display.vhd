----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:04:27 04/19/2013 
-- Design Name: 
-- Module Name:    Display - Behavioral 
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

entity Display is
			CE						: in  STD_LOGIC;
			Reset					: in  STD_LOGIC;
			Enable				: IN  STD_LOGIC;
			RW						: IN	STD_LOGIC;
			AddrBus				: IN	STD_LOGIC_VECTOR (5 downto 0);
			DataBus_fromCPU	: IN	STD_LOGIC_VECTOR (7 downto 0);
			VGA_HS				: OUT	STD_LOGIC;
			VGA_VS				: OUT STD_LOGIC;
			VGA_Red				: OUT STD_LOGIC_VECTOR (2 downto 0);
			VGA_Green			: OUT STD_LOGIC_VECTOR (2 downto 0);
			VGA_Blue				: OUT STD_LOGIC_VECTOR (1 downto 0));
end Display;

architecture Behavioral of Display is

	component Disp_BusInt
				CE						: in  STD_LOGIC;
				Reset					: in  STD_LOGIC;
				AddrBus				: in  STD_LOGIC_VECTOR (5 DOWNTO 0);
				DataBus_fromCPU	: in  STD_LOGIC_VECTOR (7 DOWNTO 0);
				Enable_Img			: in  STD_LOGIC;
				RW						: in	STD_LOGIC;
				Player_Out			: out	STD_LOGIC_VECTOR (7 DOWNTO 0);
				OK_Out				: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				Pos_Out				: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				OK_Load				: out STD_LOGIC;
				Pos_Load				: out STD_LOGIC);
	end component;
	
	component Disp_VGAinterface
		Port (Clk				: in  STD_LOGIC;
				CE					: in  STD_LOGIC;
				Reset				: in  STD_LOGIC;
				VRAM_enableW	: in  STD_LOGIC;
				VRAM_addrW		: in	STD_LOGIC_VECTOR(19 downto 0);
				VRAM_dataIn		: in  STD_LOGIC_VECTOR(7 downto 0);
				HS					: OUT STD_LOGIC;
				VS					: OUT STD_LOGIC;
				VRAM_dataOut	: OUT STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	signal Player_val 	: STD_LOGIC_VECTOR(7 downto 0);
	signal OK_val 			: STD_LOGIC_VECTOR(7 downto 0);
	signal Pos_val			: STD_LOGIC_VECTOR(7 downto 0);
	signal OK_Load			: STD_LOGIC;
	signal Pos_Load		: STD_LOGIC;
	signal VRAM_addrW		: STD_LOGIC_VECTOR(19 downto 0);
	signal VRAM_dataIn	: STD_LOGIC_VECTOR(7 downto 0);
	signal VRAM_pixel		: STD_LOGIC_VECTOR(7 downto 0);
	signal VRAM_enableW	: STD_LOGIC;

begin
	-- pour test sur �cran
	VRAM_dataIn <= "00000111" WHEN Player_val(0) = '1' ELSE
						"00111000" WHEN Player_val(0) = '0' ELSE
						"00000000";
	-- pour test sur �cran
	VRAM_addrW(1 downto 0)		<= "11";
	VRAM_addrW(9 downto 2)		<= Pos_val;
	VRAM_addrW(13 downto 10) 	<= "1111";
	VRAM_addrW(19 downto 14)	<= (others => '0');
	-- pour test sur �cran
	VRAM_enableW <= Pos_load;


	-- D�composition du pixel en couleurs
	VGA_Red		<= VRAM_pixel(2 downto 0);
	VGA_Green	<= VRAM_pixel(5 downto 3);
	VGA_Blue		<= VRAM_pixel(7 downto 6);
	
	Disp_Bus_Interface: DISP_BUSINT port map (
		Clk					=> Clk,
		CE						=> Ce,
		Reset					=> Reset,
		AddrBus				=> AddrBus,
		DataBus_fromCPU	=> DataBus_fromCPU,
		Enable_Img			=> Enable,
		RW						=> RW,
		Player_Out			=> Player_val,
		OK_Out				=> OK_val, 
		Pos_Out				=> Pos_val,
		OK_Load				=> OK_Load,
		Pos_Load				=> Pos_Load);
	
	Disp_VGA_Interface : Disp_VGAinterface port map (
		Clk				=> Clk,
		CE					=> Ce,
		Reset				=> Reset,
		VRAM_enableW	=> VRAM_enableW,
		VRAM_addrW		=> VRAM_addrW,
		VRAM_dataIn		=> VRAM_dataIn,
		HS					=> VGA_HS,
		VS					=> VGA_VS,
		VRAM_dataOut	=> VRAM_pixel);

end Behavioral;
