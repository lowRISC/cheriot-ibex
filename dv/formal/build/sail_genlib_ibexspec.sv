
typedef struct {
    logic [7:0] bits;
} t_Pmpcfg_ent;

`ifndef SAIL_LIBRARY_GENERATED
`define SAIL_LIBRARY_GENERATED

typedef struct packed {
    logic [7:0] size;
    logic [127:0] bits;
} sail_bits;

localparam SAIL_BITS_WIDTH = 128;
localparam SAIL_INDEX_WIDTH = 8;

function automatic logic [7:0] sail_bits_size(sail_bits bv); return bv.size; endfunction
function automatic logic [127:0] sail_bits_value(sail_bits bv); return bv.bits; endfunction

typedef logic [127:0] sail_int;

function automatic sail_unit sail_print_bits(sail_unit prefix, sail_bits bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_string_of_bits(sail_bits bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_print_int(sail_unit prefix, logic [127:0] i);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_dec_str(logic [127:0] i);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_hex_str(logic [127:0] i);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_hex_str_upper(logic [127:0] i);
    return SAIL_UNIT;
endfunction

logic [127:0] sail_cycle_count_var;

function automatic logic [127:0] sail_get_cycle_count(sail_unit u);
    return sail_cycle_count_var;
endfunction

function automatic sail_unit sail_cycle_count(sail_unit u);
    sail_cycle_count_var = sail_cycle_count_var + 1;
    return SAIL_UNIT;
endfunction

function automatic logic [0:0] sail_clz_1(logic [0:0] bv);
    return ~bv[0];
endfunction

function automatic logic [1:0] sail_clz_2(logic [1:0] bv);
    if (bv[1:1] == 0) begin
        return 2'd1 + 2'(sail_clz_1(bv[0:0]));
    end else begin
        return 2'(sail_clz_1(bv[1:1]));
    end;
endfunction

function automatic logic [2:0] sail_clz_3(logic [2:0] bv);
    if (bv[2:1] == 0) begin
        return 3'd2 + 3'(sail_clz_1(bv[0:0]));
    end else begin
        return 3'(sail_clz_2(bv[2:1]));
    end;
endfunction

function automatic logic [5:0] sail_clz_6(logic [5:0] bv);
    if (bv[5:3] == 0) begin
        return 6'd3 + 6'(sail_clz_3(bv[2:0]));
    end else begin
        return 6'(sail_clz_3(bv[5:3]));
    end;
endfunction

function automatic logic [11:0] sail_clz_12(logic [11:0] bv);
    if (bv[11:6] == 0) begin
        return 12'd6 + 12'(sail_clz_6(bv[5:0]));
    end else begin
        return 12'(sail_clz_6(bv[11:6]));
    end;
endfunction

function automatic logic [4:0] sail_clz_5(logic [4:0] bv);
    if (bv[4:2] == 0) begin
        return 5'd3 + 5'(sail_clz_2(bv[1:0]));
    end else begin
        return 5'(sail_clz_3(bv[4:2]));
    end;
endfunction

function automatic logic [10:0] sail_clz_11(logic [10:0] bv);
    if (bv[10:5] == 0) begin
        return 11'd6 + 11'(sail_clz_5(bv[4:0]));
    end else begin
        return 11'(sail_clz_6(bv[10:5]));
    end;
endfunction

function automatic logic [22:0] sail_clz_23(logic [22:0] bv);
    if (bv[22:11] == 0) begin
        return 23'd12 + 23'(sail_clz_11(bv[10:0]));
    end else begin
        return 23'(sail_clz_12(bv[22:11]));
    end;
endfunction

function automatic sail_unit sail_string_of_bits_36(logic [35:0] bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_string_of_bits_32(logic [31:0] bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_string_of_bits_4(logic [3:0] bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_string_of_bits_2(logic [1:0] bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_dec_str_64(logic [63:0] i);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_string_of_bits_6(logic [5:0] bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_string_of_bits_8(logic [7:0] bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_print_fixed_bits_12(sail_unit prefix, logic [11:0] bv);
    return SAIL_UNIT;
endfunction

function automatic sail_unit sail_string_of_bits_16(logic [15:0] bv);
    return SAIL_UNIT;
endfunction

`endif
