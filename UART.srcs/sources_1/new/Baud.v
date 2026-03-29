`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2026 19:40:33
// Design Name: 
// Module Name: Baud
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


module Baud(
    input clk,
    output reg tx_enb,rx_enb 
    );
    
parameter clk1 = 50000000; 
parameter baud_rate = 9600;

localparam count = clk1/baud_rate;
reg [12:0] tx_counter;
reg[9:0] rx_counter;

always @(posedge clk)
begin
if(tx_counter == count -1) begin
    tx_counter <=0;
     tx_enb <= 1;
    end
    else 
    tx_counter <= tx_counter + 1'b1;
    tx_enb <= 1'b0;
    end
always @(posedge clk)
begin
if(rx_counter == 325) begin
    rx_counter <=0;
     rx_enb <= 1;
    end
    else 
    rx_counter <= rx_counter + 1'b1;
    rx_enb <= 1'b0;
    end
endmodule
