module Adder(a,b,sum);
	input [15:0] a,b;
	output [15:0]sum;
	wire cout;
	wire [15:0] q;
	fa fa1(a[0],b[0],1'b0,sum[0],q[0]);
	fa fa2(a[1],b[1],q[0],sum[1],q[1]);
	fa fa3(a[2],b[2],q[1],sum[2],q[2]);
	fa fa4(a[3],b[3],q[2],sum[3],q[3]);
	fa fa5(a[4],b[4],q[3],sum[4],q[4]);
	fa fa6(a[5],b[5],q[4],sum[5],q[5]);
	fa fa7(a[6],b[6],q[5],sum[6],q[6]);
	fa fa8(a[7],b[7],q[6],sum[7],q[7]);
	fa fa9(a[8],b[8],q[7],sum[8],q[8]);
	fa fa10(a[9],b[9],q[8],sum[9],q[9]);
	fa fa11(a[10],b[10],q[9],sum[10],q[10]);
	fa fa12(a[11],b[11],q[10],sum[11],q[11]);
	fa fa13(a[12],b[12],q[11],sum[12],q[12]);
	fa fa14(a[13],b[13],q[12],sum[13],q[13]);
	fa fa15(a[14],b[14],q[13],sum[14],q[14]);
	fa fa16(a[15],b[15],q[14],sum[15],cout);	
endmodule

module subtractor(a,b,sum);
	input [8:0] a,b;
	output [8:0]sum;
	wire [8:0] ib;
	wire cout;
	invert b1(ib[0],b[0]);
	invert b2(ib[1],b[1]);
	invert b3(ib[2],b[2]);
	invert b4(ib[3],b[3]);
	invert b5(ib[4],b[4]);
	invert b6(ib[5],b[5]);
	invert b7(ib[6],b[6]);
	invert b8(ib[7],b[7]);
	invert b9(ib[8],b[8]);
	invert b10(ib[9],b[9]);
	invert b11(ib[10],b[10]);
	invert b12(ib[11],b[11]);
	invert b13(ib[12],b[12]);
	invert b14(ib[13],b[13]);
	invert b15(ib[14],b[14]);
	invert b16(ib[15],b[15]);


	wire [15:0] q;
	fa fa1(a[0],ib[0],1'b1,sum[0],q[0]);
	fa fa2(a[1],ib[1],q[0],sum[1],q[1]);
	fa fa3(a[2],ib[2],q[1],sum[2],q[2]);
	fa fa4(a[3],ib[3],q[2],sum[3],q[3]);
	fa fa5(a[4],ib[4],q[3],sum[4],q[4]);
	fa fa6(a[5],ib[5],q[4],sum[5],q[5]);
	fa fa7(a[6],ib[6],q[5],sum[6],q[6]);
	fa fa8(a[7],ib[7],q[6],sum[7],q[7]);
	fa fa9(a[8],ib[8],q[7],sum[8],q[8]);
	fa fa10(a[9],ib[9],q[8],sum[9],q[9]);
	fa fa11(a[10],ib[10],q[9],sum[10],q[10]);
	fa fa12(a[11],ib[11],q[10],sum[11],q[11]);
	fa fa13(a[12],ib[12],q[11],sum[12],q[12]);
	fa fa14(a[13],ib[13],q[12],sum[13],q[13]);
	fa fa15(a[14],ib[14],q[13],sum[14],q[14]);


	fa fa16(a[16],ib[16],q[14],sum[15],cout);

endmodule



module booth_substep(input wire signed [15:0]a,Q,input wire signed q0,input wire signed [15:0] m,output reg signed [15:0] f8,output reg signed [15:0] l8,output reg cq0);
	wire [15:0] addam,subam;
	Adder myadd(a,m,addam);
	subtractor mysub(a,m,subam);
	// Still need to fix this part
		always @(*) begin	
		if(Q[0] == q0) begin
			 cq0 = Q[0];
			l8 = Q>>1;
			 l8[7] = a[0];
			 f8 = a>>1;
			if (a[7] == 1)
			f8[7] = 1;
		end

		else if(Q[0] == 1 && q0 ==0) begin
			 cq0 = Q[0];
				l8 = Q>>1;
			 l8[7] = subam[0];
			 f8 = subam>>1;
			if (subam[7] == 1)
			f8[7] = 1;
		end

		else begin
			 cq0 = Q[0];
				l8 = Q>>1;
			 l8[7] = addam[0];
			 f8 = addam>>1;
			if (addam[7] == 1)
			f8[7] = 1;
		end
						
			
			
			 	
		
	
end	
endmodule 





 
module boothmul(input signed[15:0]a,b,output signed [31:0] c);
	wire signed [15:0]Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15;
	wire signed [15:0] m;

	//The next two lines may need to be changed
	wire signed [15:0] A1,A0,A3,A2;
	wire signed [15:0] A4,A5,A6,A7;
	wire signed[15:0] q0;
	wire qout;
	//These need to be changed and added to
	booth_substep step1(8'b00000000,a,1'b0,b,A1,Q1,q0[1]);
	booth_substep step2(A1,Q1,q0[1],b,A2,Q2,q0[2]);
	booth_substep step3(A2,Q2,q0[2],b,A3,Q3,q0[3]);
	booth_substep step4(A3,Q3,q0[3],b,A4,Q4,q0[4]);
	booth_substep step5(A4,Q4,q0[4],b,A5,Q5,q0[5]);
	booth_substep step6(A5,Q5,q0[5],b,A6,Q6,q0[6]);
	booth_substep step7(A6,Q6,q0[6],b,A7,Q7,q0[7]);
	booth_substep step8(A7,Q7,q0[7],b,c[15:8],c[7:0],qout);
	
	 
endmodule
