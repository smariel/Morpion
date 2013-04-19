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

entity Display is	Port (Clk				: in  STD_LOGIC;
			CE					: in  STD_LOGIC;
			Reset				: in  STD_LOGIC;
			DISP_ENABLE		: IN  STD_LOGIC;
			RW					: IN	STD_LOGIC;
			AddrBus			: IN	STD_LOGIC_VECTOR (5 downto 0);
			DataBus_IN		: IN	STD_LOGIC_VECTOR (7 downto 0);
			VGA_HS			: OUT	STD_LOGIC;
			VGA_VS			: OUT STD_LOGIC;
			VGA_Red			: OUT STD_LOGIC_VECTOR (2 downto 0);
			VGA_Green		: OUT STD_LOGIC_VECTOR (2 downto 0);
			VGA_Blue			: OUT STD_LOGIC_VECTOR (1 downto 0));
end Display;

architecture Behavioral of Display is

	component Disp_BusInt
		Port (Clk				: in  STD_LOGIC;
			CE					: in  STD_LOGIC;
			Reset				: in  STD_LOGIC;
			Addr_Bus			: in  STD_LOGIC_VECTOR (7 DOWNTO 0);
			Data_Bus			: in  STD_LOGIC_VECTOR (7 DOWNTO 0);
			Enable_Img		: in  STD_LOGIC;
			RW					: in	STD_LOGIC;
			Player_Out		: out	STD_LOGIC_VECTOR (7 DOWNTO 0);
			OK_Out			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
			Pos_Out			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
			OK_Load			: out STD_LOGIC;
			Pos_Load			: out STD_LOGIC);
	end component;

begin
	

end Behavioral;

