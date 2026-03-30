`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2026 02:33:25
// Design Name: 
// Module Name: uart_comb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_comb(
input reset, [7:0]data_in, clk , rdy_clr, rx_enb , tx_enb,
output rdy , busy , [7:0]data_out
    );
    
wire tx_clk;
wire rx_clk; 
wire tx_temp;

Baud rate_generator(clk,tx_clk,rx_clk);
trans TX(clk,tx_enb,reset,rx_clk, data_in , tx_temp, busy);
reciever RX(clk, reset,rdy_clr,tx_temp,rx_clk,rdy,data_out); 
endmodule
