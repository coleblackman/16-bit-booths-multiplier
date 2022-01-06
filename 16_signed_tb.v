module tb;
wire signed [31:0] z;
reg signed [15:0] a,b;


mul16x16_signed my_booth_16_signed(.A(a),.B(b),.c(z));

initial begin $dumpfile("tb_boothsalgo.vcd"); $dumpvars(0,tb); end

initial
begin
$monitor($time,"       ",a," *",b," = ", z);

a = 16'b1111000000000000;
b = 16'b1111000000000000;

#10

a = 16'b1001010100000000;
b = 16'b10000000000000;

#10

a = 16'b011100000000;
b = 16'b000000000;

#10

b = 16'b100000000;
a = 16'b100000000;

#10  

a = 16'b00111100;
b = 16'b010100000000;

#10

a = 16'b1000000000101010;
b = 16'b100011;

#10

a = 16'b010001;
b = 16'b11100;

#10
a = 16'b1000;
b = 16'b1011111100000000;

end
endmodule
