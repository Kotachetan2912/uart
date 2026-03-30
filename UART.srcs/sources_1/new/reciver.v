`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2026 00:28:02
// Design Name: 
// Module Name: reciver
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


module reciever(
input clk,reset,rdy_clr,rx_enb,rx,
output reg rdy ,
output reg data_out
    );
parameter start_state = 2'b00;
parameter dataout_state = 2'b01;
parameter stop_state = 2'b10;

reg [1:0] state = start_state;
reg [3:0] sample = 0;
reg [3:0] index = 0;
reg[7:0] temp = 0;
always @(posedge clk)
if(reset) begin
rdy = 0;
data_out = 0;
end
always @(posedge clk)
if(rdy_clr)  begin
rdy = 0;
if(rx_enb)
case(state)
    start_state : begin
    if(rx == 0 || sample != 0)
    sample <= sample + 1'b1;
    if(sample == 15) begin
        state <= dataout_state;
        sample <=0;
        index <=0;
        temp<=0;
end
end
dataout_state : begin
sample = sample + 1'b1;
if(sample == 8)
begin
    temp[index] <= rx;
    index <= index +1;
    end
if(sample ==15  && index ==8) begin
state <= stop_state;
end
end
stop_state : begin
if(sample == 15)
begin
state <= start_state;
data_out <= temp;
rdy <= 1'b1;
sample <=0;
end
else sample = sample + 1'b1;
end

default: state <= start_state;
endcase
end

endmodule
