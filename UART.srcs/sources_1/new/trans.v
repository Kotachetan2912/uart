`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2026 20:06:22
// Design Name: 
// Module Name: trans
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


module trans(
input clk,tx_enb,reset,enb,
input [7:0] data_in,
output reg tx,
output busy
    );
parameter idle = 2'b00;
parameter start = 2'b01;
parameter data = 2'b10;
parameter stop = 2'b11;

reg [7:0]inp;
reg [2:0] index;
reg[1:0] state = idle;

always @(posedge clk)
begin if(reset)
tx = 1'b1;
end

always @(posedge clk) begin
case(state) idle:
    begin
    if(tx_enb) begin 
    state <= start;
    inp <= data_in;
    index <= 3'd0;
    end
        else state <= idle;
    end
start :
begin if(enb) begin
tx <= 1'b0;
state <= data;
end 
    else  state <= start;
end

data :
begin if(enb)
begin if(index == 3'd7)
state <= stop;
index <= 3'd0;
end else 
index <= index +1;
tx <= inp[index];
end

stop :
begin
if(enb) begin
tx =1'b1;
state <= idle;
end
end
default: begin
tx <= 1'b1;
state <= idle;
end
endcase
end
endmodule
