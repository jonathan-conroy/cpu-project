library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity immextend is
	port(
		op  : in std_logic_vector(1 downto 0);
		imm : in std_logic_vector(23 downto 0);
		immout : out std_logic_vector(31 downto 0)
	);
end;

architecture synth of immextend is
	signal rot : unsigned(4 downto 0) := 5d"0";
	signal vals : unsigned(31 downto 0) := 32d"0";
begin
	vals <= unsigned(24d"0" & imm(7 downto 0));
    rot <= unsigned(imm(11 downto 8) & "0");

	process(all) begin
		if op = "00" then -- Encoding for Data-Processing Instructions
			for i in 0 to 31 loop
				immout(i) <= vals(to_integer((rot + i) mod 32));
			end loop;
		elsif op = "01" then -- Encoding for Memory Instructions
			immout <= 20d"0" & imm(11 downto 0);
		elsif op = "10" then -- Encoding for Branch Instructions
			if imm(23) = '1' then
				immout <= 6b"111111" & imm & 2d"0";
			else
				immout <= 6d"0" & imm & 2d"0";
			end if;
		end if;
	end process;
end;