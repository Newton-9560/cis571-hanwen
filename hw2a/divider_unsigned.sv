/* INSERT NAME AND PENNKEY HERE */

`timescale 1ns / 1ns

// quotient = dividend / divisor

module divider_unsigned (
    input  wire [31:0] i_dividend,
    input  wire [31:0] i_divisor,
    output wire [31:0] o_remainder,
    output wire [31:0] o_quotient
);

  wire [31:0] divisor_tmp  [32:0];
  wire [31:0] remainder_tmp[32:0];
  wire [31:0] quotient_tmp [32:0];

  assign divisor_tmp[0]   = i_dividend;
  assign remainder_tmp[0] = 0;
  assign quotient_tmp[0]  = 0;

  genvar i;
  for (i = 0; i < 32; i = i + 1) begin
    divu_1iter d (
        .i_dividend (divisor_tmp[i]),
        .i_divisor  (i_divisor),
        .i_quotient (quotient_tmp[i]),
        .i_remainder(remainder_tmp[i]),
        .o_dividend (divisor_tmp[i+1]),
        .o_quotient (quotient_tmp[i+1]),
        .o_remainder(remainder_tmp[i+1])
    );
  end

  assign o_quotient  = quotient_tmp[32];
  assign o_remainder = remainder_tmp[32];


endmodule


module divu_1iter (
    input  wire [31:0] i_dividend,
    input  wire [31:0] i_divisor,
    input  wire [31:0] i_remainder,
    input  wire [31:0] i_quotient,
    output wire [31:0] o_dividend,
    output wire [31:0] o_remainder,
    output wire [31:0] o_quotient
);
  wire [31:0] remainder_tmp;
  assign remainder_tmp = (i_remainder << 1) | ((i_dividend >> 31) & 32'h1);
  // if(remainder_tmp < i_divisor) begin 
  //     assign o_quotient = (i_quotient << 1);
  //     assign o_remainder = remainder_tmp;
  // end 
  // else begin
  //     assign o_quotient = (i_quotient << 1) | 32'h1;
  //     assign o_remainder = remainder_tmp - i_divisor;
  // end

  assign o_quotient = (remainder_tmp < i_divisor) ? (i_quotient << 1) : (i_quotient << 1) | 32'h1;
  assign o_remainder = (remainder_tmp < i_divisor) ? remainder_tmp : remainder_tmp - i_divisor;

  assign o_dividend = i_dividend << 1;

endmodule
