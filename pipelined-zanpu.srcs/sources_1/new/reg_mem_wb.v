`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU MEM/WB Register
 *
 * Input:
 * Output:
 */

module reg_mem_wb(
           input wire                        clk,
           input wire                        rst,
           input wire[31:0]                  alu_result_in,
           input wire[31:0]                  read_mem_data_in,
           input wire[31:0]                  jmp_dst_in,
           input wire[31:0]                  extended_imm_in,
           input wire[4:0]                   destination_reg_in,

           input wire[`REG_SRC_LENGTH - 1:0] cu_reg_src_in,
           input wire                        en_reg_write_in,
           input wire                        en_lw_mem_wb_in,

           output reg[31:0]                  alu_result_out,
           output reg[31:0]                  read_mem_data_out,
           output reg[31:0]                  jmp_dst_out,
           output reg[31:0]                  extended_imm_out,
           output reg[4:0]                   destination_reg_out,

           output reg[`REG_SRC_LENGTH - 1:0] cu_reg_src_out,
           output reg                        en_reg_write_out,
           output reg                        en_lw_mem_wb_out
       );


// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

always @ (posedge clk) begin
    if (zeroize) begin
        alu_result_out      <= `INIT_32;
        read_mem_data_out   <= `INIT_32;
        jmp_dst_out         <= `INIT_32;
        extended_imm_out    <= `INIT_32;
        destination_reg_out <= `INIT_32;
        cu_reg_src_out      <= `REG_SRC_DEFAULT;
        en_reg_write_out    <= `REG_WRITE_DIS;
        en_lw_mem_wb_out    <= `EN_LW_DEFAULT;
    end
    else begin
        alu_result_out      <= alu_result_in;
        read_mem_data_out   <= read_mem_data_in;
        jmp_dst_out         <= jmp_dst_in;
        extended_imm_out    <= extended_imm_in;
        destination_reg_out <= destination_reg_in;
        cu_reg_src_out      <= cu_reg_src_in;
        en_reg_write_out    <= en_reg_write_in;
        en_lw_mem_wb_out    <= en_lw_mem_wb_in;
    end
end
endmodule
