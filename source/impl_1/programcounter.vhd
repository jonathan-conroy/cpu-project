library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity programcounter is
port(
	clk : in std_logic;
	reset : in std_logic;
	branch : in std_logic;
	branchAddr : in std_logic_vector(31 downto 0);
	pc : out unsigned(31 downto 0)
);
end;

architecture synth of programcounter is

signal address : unsigned(31 downto 0);

begin

process(clk) begin
	if rising_edge(clk) then
		if reset = '1' then
			address <= "0";
		elsif branch = '1' then
			address <= branchAddr;
		else
			address <= address + to_unsigned(4, 32);
		end if;
	end if;
end process;
pc <= address;
end;