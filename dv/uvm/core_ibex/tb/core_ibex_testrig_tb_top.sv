`define BOOT_ADDR 32'h8000_0000

module core_ibex_testrig_tb_top;
  wire clk;
  wire rst_n;

  clk_rst_if clk_if(.clk(clk), .rst_n(rst_n));
  core_ibex_rvfi_if rvfi_if(.clk(clk));
  core_ibex_dii_intf dii_if(.clk(clk), .rst_n(rst_n), .rvfi_valid(dut.rvfi_valid));

  logic instr_req;
  logic instr_gnt;
  logic instr_rvalid;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      instr_rvalid <= 1'b0;
    end else begin
      instr_rvalid <= instr_req;
    end
  end

  assign instr_gnt = instr_req;

  ibex_top_tracing #(
                     .HeapBase        (32'h8000_0000), // Base of memory.
                     .TSMapBase       (32'h8300_0000), // Same as Sail.
                     .TSMapSize       (4096), // Cover all of memory.
                     .DmHaltAddr      (`BOOT_ADDR + 'h40),
                     .DmExceptionAddr (`BOOT_ADDR + 'h44),
                     .MMRegDinW       (128),
                     .MMRegDoutW      (64)
  ) dut (
    .clk_i                (clk),
    .rst_ni               (rst_n),
    .test_en_i            (1'b0),
    .scan_rst_ni          (1'b1),
    .ram_cfg_i            ('{0, 0}),
    .hart_id_i            ('0),
    .cheri_pmode_i        (1'b1),
    .cheri_tsafe_en_i     (1'b0),
    .boot_addr_i          (`BOOT_ADDR), // align with spike boot address
    .debug_req_i          (1'b0),
    .fetch_enable_i       (4'b1001),
    .instr_req_o          (instr_req),
    .instr_gnt_i          (instr_gnt),
    .instr_rvalid_i       (instr_rvalid),
    .instr_addr_o         (),
    .instr_rdata_i        ('0),
    .instr_rdata_intg_i   ('0),
    .instr_err_i          (1'b0),
    .data_req_o           (),
    .data_gnt_i           ('0),
    .data_rvalid_i        ('0),
    .data_we_o            (),
    .data_be_o            (),
    .data_is_cap_o        (),
    .data_addr_o          (),
    .data_wdata_o         (),
    .data_rdata_i         ('0),
    .data_rdata_intg_i    ('0),
    .data_err_i           (1'b0),
    .tsmap_cs_o           (),
    .tsmap_addr_o         (),
    .tsmap_rdata_i        ('0),
    .tsmap_rdata_intg_i   ('0),
    .mmreg_corein_i       ('0),
    .mmreg_coreout_o      (),
    .irq_software_i       ('0),
    .irq_timer_i          ('0),
    .irq_external_i       ('0),
    .irq_fast_i           (15'h0),
    .irq_nm_i             (1'b0),
    .scramble_key_valid_i (1'b0),
    .scramble_key_i       (128'h0),
    .scramble_nonce_i     (64'h0),
    .core_sleep_o         (),
    .double_fault_seen_o  (),
    .crash_dump_o         (),
    .scramble_req_o       (),
    .data_wdata_intg_o    ()
  );

  assign rvfi_if.reset         = ~rst_n;
  assign rvfi_if.valid         = dut.rvfi_valid;
  assign rvfi_if.order         = dut.rvfi_order;
  assign rvfi_if.insn          = dut.rvfi_insn;
  assign rvfi_if.trap          = dut.rvfi_trap;
  assign rvfi_if.intr          = dut.rvfi_intr;
  assign rvfi_if.mode          = dut.rvfi_mode;
  assign rvfi_if.ixl           = dut.rvfi_ixl;
  assign rvfi_if.rs1_addr      = dut.rvfi_rs1_addr;
  assign rvfi_if.rs2_addr      = dut.rvfi_rs2_addr;
  assign rvfi_if.rs1_rdata     = dut.rvfi_rs1_rdata;
  assign rvfi_if.rs2_rdata     = dut.rvfi_rs2_rdata;
  assign rvfi_if.rd_addr       = dut.rvfi_rd_addr;
  assign rvfi_if.rd_wdata      = dut.rvfi_rd_wdata;
  assign rvfi_if.pc_rdata      = dut.rvfi_pc_rdata;
  assign rvfi_if.pc_wdata      = dut.rvfi_pc_wdata;
  assign rvfi_if.mem_addr      = dut.rvfi_mem_addr;
  assign rvfi_if.mem_rmask     = dut.rvfi_mem_rmask;
  assign rvfi_if.mem_rdata     = dut.rvfi_mem_rdata;
  assign rvfi_if.mem_wdata     = dut.rvfi_mem_wdata;
  assign rvfi_if.ext_mip       = dut.rvfi_ext_mip;
  assign rvfi_if.ext_nmi       = dut.rvfi_ext_nmi;
  assign rvfi_if.ext_debug_req = dut.rvfi_ext_debug_req;
  assign rvfi_if.ext_mcycle    = dut.rvfi_ext_mcycle;

  `define IBEX_DII_INSN_PATH dut.u_ibex_top.u_ibex_core.if_stage_i.gen_prefetch_buffer.prefetch_buffer_i.fifo_i.instr_rdata_dii
  `define IBEX_DII_ACK_PATH dut.u_ibex_top.u_ibex_core.if_stage_i.gen_prefetch_buffer.prefetch_buffer_i.fifo_i.instr_ack

  assign dii_if.instr_ack = `IBEX_DII_ACK_PATH;
  assign `IBEX_DII_INSN_PATH = dii_if.instr_rdata_dii;

  initial begin
    clk_if.set_active();

    fork
      clk_if.apply_reset(.reset_width_clks (100));
    join_none

    uvm_config_db#(virtual clk_rst_if)::set(null, "*", "clk_if", clk_if);
    uvm_config_db#(virtual core_ibex_dii_intf)::set(null, "*", "dii_if", dii_if);
    uvm_config_db#(virtual core_ibex_rvfi_if)::set(null, "*", "rvfi_if", rvfi_if);

    run_test();
  end
endmodule
