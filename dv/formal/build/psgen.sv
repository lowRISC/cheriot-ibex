assign memory_pre = 1;

assign memory_idle_active = `LSU.ls_fsm_cs == `LSU.IDLE && `CR.lsu_req && ~`CR.lsu_cheri_err;

assign memory_idle_active_inv = data_mem_assume.outstanding_reqs == data_gnt_i &&
~`LSU.handle_misaligned_q &&
`CR.lsu_resp_valid == outstanding_mem &&
(`LSU.cap_rx_fsm_q == CRX_IDLE || (`LSU.cap_rx_fsm_q == CRX_WAIT_RESP2 && data_rvalid_i));

assign memory_wait_rvalid_mis = `LSU.ls_fsm_cs == `LSU.WAIT_RVALID_MIS;

assign memory_wait_rvalid_mis_inv = ($stable(`LSU.ls_fsm_cs) -> $stable(data_addr_o)) &&
has_one_resp_waiting_q && ~`LSU.lsu_cheri_err_i &&
`LSU.cap_rx_fsm_q == CRX_IDLE && ~ex_is_mem_cap_instr;

assign memory_wait_gnt = `LSU.ls_fsm_cs == `LSU.WAIT_GNT;

assign memory_wait_gnt_inv = $stable(data_addr_o) && ~has_resp_waiting_q &&
~`LSU.lsu_cheri_err_i &&`LSU.cap_rx_fsm_q == CRX_IDLE && ~ex_is_mem_cap_instr;

assign memory_wait_rvalid_mis_gnts_done = `LSU.ls_fsm_cs == `LSU.WAIT_RVALID_MIS_GNTS_DONE;

assign memory_wait_rvalid_mis_gnts_done_inv = $stable(data_addr_o) &&has_two_resp_waiting_q &&
~`LSU.lsu_cheri_err_i &&`LSU.cap_rx_fsm_q == CRX_IDLE &&
~ex_is_mem_cap_instr &&~`LSU.handle_misaligned_q;

assign memory_wait_gnt2 = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT2 && has_one_resp_waiting_q;

assign memory_wait_gnt2_inv = ($stable(`LSU.ls_fsm_cs) -> $stable(data_addr_o)) &&
has_one_resp_waiting_q &&
~`LSU.lsu_cheri_err_i && `LSU.cap_rx_fsm_q == CRX_WAIT_RESP1 &&
ex_is_mem_cap_instr &&~`LSU.handle_misaligned_q;

assign memory_wait_gnt2_direct = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT2 && ~has_resp_waiting_q;

assign memory_wait_gnt2_direct_inv = ($stable(`LSU.ls_fsm_cs) -> $stable(data_addr_o)) &&
~has_resp_waiting_q &&
~`LSU.lsu_cheri_err_i && `LSU.cap_rx_fsm_q == CRX_WAIT_RESP2 &&
ex_is_mem_cap_instr &&~`LSU.handle_misaligned_q;

assign memory_wait_resp = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_RESP;

assign memory_wait_resp_inv = $stable(data_addr_o) &&
has_two_resp_waiting_q && ~`LSU.lsu_cheri_err_i &&
`LSU.cap_rx_fsm_q == CRX_WAIT_RESP1 && ex_is_mem_cap_instr &&~`LSU.handle_misaligned_q;

assign memory_idle = `LSU.ls_fsm_cs == `LSU.IDLE && data_mem_assume.outstanding_reqs == data_gnt_i;

assign memory_idle_inv = ~`LSU.handle_misaligned_q &&`CR.lsu_resp_valid == outstanding_mem &&
(`LSU.cap_rx_fsm_q == CRX_IDLE || (`LSU.cap_rx_fsm_q == CRX_WAIT_RESP2 && data_rvalid_i));

assign memory_wait = has_resp_waiting_q && ~`CR.lsu_resp_valid &&
`LSU.ls_fsm_cs == `LSU.IDLE && ~instr_will_progress;

assign memory_wait_inv = outstanding_mem && has_one_resp_waiting_q && ~`LSU.lsu_req_i &&
wbexc_exists &&(wbexc_is_mem_cap_instr -> (`LSU.cap_rx_fsm_q == CRX_WAIT_RESP2)) &&
(~wbexc_is_mem_cap_instr -> (`LSU.cap_rx_fsm_q == CRX_IDLE)) &&
~`LSU.handle_misaligned_q && ~`LSU.cheri_err_q;

assign memory_step = `LSU.lsu_req_done_o & ~`LSU.lsu_cheri_err_i;

assign memory_step_inv = `LSU.ls_fsm_ns == `LSU.IDLE &&
(`CR.instr_type_wb != WB_INSTR_OTHER || `CR.cheri_load_id || `CR.cheri_store_id) &&
has_one_resp_waiting_d &&
(ex_is_mem_cap_instr -> (`LSU.cap_rx_fsm_d == CRX_WAIT_RESP2)) &&
(~ex_is_mem_cap_instr -> (`LSU.cap_rx_fsm_d == CRX_IDLE)) &&~`LSU.handle_misaligned_d;

assign memory_wait_gnt1 = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT1;

assign memory_wait_gnt1_inv = $stable(data_addr_o) &&
~has_resp_waiting_q && ~`LSU.lsu_cheri_err_i &&
`LSU.cap_rx_fsm_q == CRX_WAIT_RESP1 && ex_is_mem_cap_instr &&~`LSU.handle_misaligned_q;

assign memory_end = `CR.lsu_resp_valid && `LSU.ls_fsm_cs == `LSU.IDLE && data_rvalid_i;

assign memory_end_inv = outstanding_mem && has_one_resp_waiting_q &&
wbexc_exists &&(wbexc_is_mem_cap_instr -> (`LSU.cap_rx_fsm_q == CRX_WAIT_RESP2)) &&
(~wbexc_is_mem_cap_instr -> (`LSU.cap_rx_fsm_q == CRX_IDLE)) &&
~`LSU.handle_misaligned_q && ~`LSU.cheri_err_q;

assign memory_wait_gnt_mis = `LSU.ls_fsm_cs == `LSU.WAIT_GNT_MIS;

assign memory_wait_gnt_mis_inv = $stable(data_addr_o) && ~has_resp_waiting_q &&
~`LSU.lsu_cheri_err_i &&`LSU.cap_rx_fsm_q == CRX_IDLE && ~ex_is_mem_cap_instr;

assign memory_initial = $rose(rst_ni);

assign bind_pre = `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill;

assign bind_stall = `ID.stall_ld_hz | `ID.stall_cheri_trvk;

assign bind_stall_inv = ~ex_has_branched_d;

assign bind_oma = `IDG.outstanding_memory_access & ~(`ID.stall_ld_hz | `ID.stall_cheri_trvk);

assign bind_oma_inv = ex_has_branched_d == `CR.branch_decision && post_pc == ex_branch_dst;

assign bind_progress = instr_will_progress;

assign bind_progress_inv = ex_has_branched_d == `CR.branch_decision && post_pc == ex_branch_dst;

assign bind_initial = `CR.instr_new_id;

assign jind_pre = `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill;

assign jind_stall = `ID.stall_ld_hz | `ID.stall_cheri_trvk;

assign jind_stall_inv = ~ex_has_branched_d;

assign jind_oma = `IDG.outstanding_memory_access & ~(`ID.stall_ld_hz | `ID.stall_cheri_trvk);

assign jind_oma_inv = ex_has_branched_d && post_pc[31:1] == `CR.branch_target_ex[31:1];

assign jind_progress = instr_will_progress;

assign jind_progress_inv = ex_has_branched_d && post_pc[31:1] == `CR.branch_target_ex[31:1];

assign jind_initial = `CR.instr_new_id;

assign capfsm_pre = ex_is_mem_cap_instr &&
(`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err));

assign capfsm_wait_gnt2 = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT2 &&
`LSU.cap_rx_fsm_d == CRX_WAIT_RESP1;

assign capfsm_wait_gnt2_inv = ~`CR.lsu_cheri_err;

assign capfsm_wait_gnt2_done = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT2 &&
`LSU.cap_rx_fsm_d == CRX_WAIT_RESP2;

assign capfsm_wait_gnt2_done_inv = ~`CR.lsu_cheri_err;

assign capfsm_wait_resp = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_RESP;

assign capfsm_wait_resp_inv = ~`CR.lsu_cheri_err && `LSU.cap_rx_fsm_q == CRX_WAIT_RESP1;

assign capfsm_step = `LSU.lsu_req_done_o && ~`CR.lsu_cheri_err;

assign capfsm_step_inv = `LSU.cap_rx_fsm_d == CRX_WAIT_RESP2;

assign capfsm_idle_active = `LSU.ls_fsm_cs == `LSU.IDLE && `CR.lsu_req && ~`CR.lsu_cheri_err;

assign capfsm_idle_active_inv = `LSU.cap_rx_fsm_q == CRX_IDLE ||
(`LSU.cap_rx_fsm_q == CRX_WAIT_RESP2 && data_rvalid_i);

assign capfsm_wait_gnt1 = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT1;

assign capfsm_wait_gnt1_inv = `LSU.cap_rx_fsm_q == CRX_WAIT_RESP1 && ~`CR.lsu_cheri_err;

assign capfsm_initial = `LSU.ls_fsm_cs == `LSU.IDLE && `CR.lsu_req && ~`CR.lsu_cheri_err;

assign memspec_pre = ex_is_mem_instr &&
(`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err));

assign memspec_wait_gnt2 = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT2;

assign memspec_wait_gnt2_inv = mem_req_snd_d && snd_mem_cmp &&
~`CR.lsu_cheri_err && (spec_mem_read_snd | spec_mem_write_snd);

assign memspec_wait_resp = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_RESP;

assign memspec_wait_resp_inv = ~data_req_o && ~`CR.lsu_cheri_err &&
mem_gnt_snd_q && (spec_mem_read_snd | spec_mem_write_snd);

assign memspec_idle_active = `LSU.ls_fsm_cs == `LSU.IDLE && `CR.lsu_req && ~`CR.lsu_cheri_err;

assign memspec_idle_active_inv = mem_req_fst_d &&
fst_mem_cmp && ~mem_gnt_fst_q && ~`CR.lsu_cheri_err;

assign memspec_wait_rvalid_mis = `LSU.ls_fsm_cs == `LSU.WAIT_RVALID_MIS;

assign memspec_wait_rvalid_mis_inv = mem_req_snd_d && snd_mem_cmp &&
~`CR.lsu_cheri_err && (spec_mem_read_snd | spec_mem_write_snd);

assign memspec_wait_gnt_split = `LSU.ls_fsm_cs == `LSU.WAIT_GNT && `LSU.split_misaligned_access;

assign memspec_wait_gnt_split_inv = mem_req_snd_d && snd_mem_cmp &&
~`CR.lsu_cheri_err && (spec_mem_read_snd | spec_mem_write_snd);

assign memspec_wait_gnt = `LSU.ls_fsm_cs == `LSU.WAIT_GNT && ~`LSU.split_misaligned_access;

assign memspec_wait_gnt_inv = mem_req_fst_d && fst_mem_cmp && ~mem_gnt_fst_q &&
~`CR.lsu_cheri_err && ~spec_mem_read_snd && ~spec_mem_write_snd;

assign memspec_wait_gnt_mis = `LSU.ls_fsm_cs == `LSU.WAIT_GNT_MIS;

assign memspec_wait_gnt_mis_inv = mem_req_fst_d && fst_mem_cmp &&
~mem_gnt_fst_q && ~`CR.lsu_cheri_err && (spec_mem_read_snd | spec_mem_write_snd);

assign memspec_wait_rvalid_mis_gnts_done = `LSU.ls_fsm_cs == `LSU.WAIT_RVALID_MIS_GNTS_DONE;

assign memspec_wait_rvalid_mis_gnts_done_inv = ~data_req_o &&
~`CR.lsu_cheri_err && mem_gnt_snd_q && (spec_mem_read_snd | spec_mem_write_snd);

assign memspec_wait_gnt1 = `LSU.ls_fsm_cs == `LSU.CTX_WAIT_GNT1;

assign memspec_wait_gnt1_inv = mem_req_fst_d && fst_mem_cmp && ~mem_gnt_fst_q &&
~`CR.lsu_cheri_err && (spec_mem_read_snd | spec_mem_write_snd);

assign memspec_step = `LSU.lsu_req_done_o && ~`CR.lsu_cheri_err;

assign memspec_step_inv = 1;

assign memspec_initial = `LSU.ls_fsm_cs == `LSU.IDLE && `CR.lsu_req && ~`CR.lsu_cheri_err;

`ifndef REMOVE_SLICE_0
Ibex_NotDataIndTiming: assert property (~`CSR.data_ind_timing_o);

Ibex_PrivMorUMpp: assert property (
    (`CSR.mstatus_q.mpp == PRIV_LVL_U) || (`CSR.mstatus_q.mpp == PRIV_LVL_M)
);

Ibex_PrivMorUCur: assert property (
    (`CSR.priv_lvl_q == PRIV_LVL_U) || (`CSR.priv_lvl_q == PRIV_LVL_M)
);

Ibex_NoFinishingIRQ: assert property (wbexc_finishing |-> ~wbexc_handling_irq);

Ibex_PCBit0: assert property (~`CR.pc_id[0]);

Ibex_MEPCCBit0: assert property (~`CSR.mepc_q[0]);

Ibex_MtvecBit1: assert property (~pre_mtvec.address[1]);

Ibex_EBreakIntoDebug: assert property (~`IDC.ebreak_into_debug);

Ibex_NoEnterDebugMode: assert property (~`IDC.enter_debug_mode);

Ibex_IfBusErr: assert property (`IF.if_id_pipe_reg_we |-> ~`IF.if_instr_bus_err);

Ibex_MemGnt: assert property (mem_gnt_snd_q |-> mem_gnt_fst_q);

Ibex_MTCCNotSealed: assert property (`CSR.mtvec_cap.valid -> `CSR.mtvec_cap.otype == 3'b0);

Ibex_MTCCPermitExecute: assert property (
    `CSR.mtvec_cap.valid -> `CSR.mtvec_cap.cperms[4:3] == 2'b01
);

Ibex_WfiKill: assert property (wbexc_exists & wbexc_is_wfi |-> ex_kill);

Ibex_ErrKill: assert property (wbexc_exists & wbexc_err |-> ex_kill);

Ibex_ReqRequiresInstr: assert property (data_req_o |-> idex_has_compressed_instr);

Ibex_ReqRequiresNotIllegal: assert property (
    data_req_o |-> ~`CR.illegal_insn_id & ~`CR.illegal_c_insn_id
);

Ibex_AluInstrMatch: assert property (`CR.instr_rdata_id == `CR.instr_rdata_alu_id);

Ibex_IdExNotReq: assert property (~ex_is_mem_instr -> ~data_req_o);

Ibex_IdExNotMemMuteIncr: assert property (
    `CR.instr_valid_id & ~ex_is_mem_instr -> ~`ID.lsu_addr_incr_req_i & ~`ID.lsu_req_done_i
);

Ibex_ExecNoSpecialReq: assert property (
    `ID.instr_executing & ~instr_will_progress |-> ~`IDC.special_req
);

Ibex_StallIdFSM1: assert property (
    `ID.instr_executing && `ID.id_fsm_d != 0 |-> ~instr_will_progress
);

Ibex_ClockEn: assert property (instr_will_progress |-> ibex_top_i.clock_en);

Ibex_EnWbProgress: assert property (`WB.en_wb_i |-> instr_will_progress);

Ibex_ErrFast: assert property (
    wbexc_exists & wbexc_err |-> $past(instr_will_progress) | $past(instr_will_progress, 2)
);

Ibex_DoneFin: assert property (`WBG.wb_done & `WBG.wb_valid_q & ~wbexc_err |-> wbexc_finishing);

Ibex_ValidExists: assert property (`WBG.wb_valid_q |-> wbexc_exists);

Ibex_WbexcErrMonotonic: assert property (
    wbexc_exists & wbexc_err & ~instr_will_progress & ~wbexc_finishing |=> wbexc_err
);

Ibex_NonCompressedMatch: assert property (
    wbexc_finishing && wbexc_instr[1:0] == 2'b11 |-> wbexc_instr == wbexc_decompressed_instr
);

Ibex_CompressedMatch: assert property (
    idex_has_compressed_instr |-> idex_compressed_instr[15:0] == `CR.instr_rdata_c_id
);

Ibex_PostFlushNoInstr: assert property (`IDC.ctrl_fsm_cs == `IDC.FLUSH |=> ~`CR.instr_valid_id);

Ibex_DecompressionIllegalIdEx: assert property (
    idex_has_compressed_instr |-> decompressed_instr_illegal == `CR.illegal_c_insn_id
);

Ibex_DecompressionMatchIdEx: assert property (
    idex_has_compressed_instr & ~`CR.illegal_insn_id & ~`CR.illegal_c_insn_id
    |->
    decompressed_instr == `CR.instr_rdata_id
);

Ibex_DecompressionIllegalWbexc: assert property (
    wbexc_exists |-> decompressed_instr_illegal_2 == wbexc_compressed_illegal
);

Ibex_DecompressionMatchWbexc: assert property (
    wbexc_exists & ~wbexc_illegal & ~wbexc_compressed_illegal
    |->
    decompressed_instr_2 == wbexc_decompressed_instr
);

Ibex_HasCompressed: assert property (`CR.instr_valid_id |-> idex_has_compressed_instr);

Ibex_LSUInstrStable: assert property (`LSU.ls_fsm_cs != 0 |-> $stable(`CR.instr_rdata_id));

Ibex_NoneIdleIsDecode: assert property (`LSU.ls_fsm_cs != 0 |-> `IDC.ctrl_fsm_cs == 5);

Ibex_LSUFinishWaitRvalidMisGntsDone: assert property (
    `LSU.ls_fsm_cs == 4 && data_rvalid_i |-> instr_will_progress
);

Ibex_LSUFinishWaitRvalidMis: assert property (
    `LSU.ls_fsm_cs == 2 && data_rvalid_i && data_gnt_i |-> instr_will_progress
);

Ibex_LSUFinishWaitGnt: assert property (`LSU.ls_fsm_cs == 3 && data_gnt_i |-> instr_will_progress);

Ibex_LSUFinishFast: assert property (
    `LSU.ls_fsm_cs == 0 && data_gnt_i && `LSU.ls_fsm_ns == 0 |-> instr_will_progress
);

Ibex_WBOutstandingNoReq: assert property (outstanding_mem & ~`LSU.lsu_resp_valid_o |-> ~data_req_o);

Ibex_NotIdleReqDec: assert property (`LSU.ls_fsm_cs != `LSU.IDLE |-> `ID.lsu_req_dec | `CE.is_cap);

Ibex_NotIdleNoExErr: assert property (`LSU.ls_fsm_cs != `LSU.IDLE |-> ~ex_err);

Ibex_ProgressNoWbStall: assert property (instr_will_progress |-> ~`IDC.stall_wb_i);

Ibex_NoStoreWb: assert property (`WBG.wb_instr_type_q == WB_INSTR_STORE |-> ~`WB.rf_we_wb_o);

Ibex_WbInstrDefined: assert property (`WBG.wb_instr_type_q != 2'b11);

Ibex_SpecPastReg: assert property (
    wbexc_exists & wbexc_post_wX_en |-> spec_past_regs[wbexc_post_wX_addr] == wbexc_post_wX
);

Ibex_SpecPastWbexc_Priv: assert property (wbexc_exists |-> spec_past_priv == wbexc_post_priv);

Ibex_SpecPastWbexc_Mstatus: assert property (
    wbexc_exists |-> spec_past_mstatus == wbexc_post_mstatus
);

Ibex_SpecPastWbexc_Mie: assert property (wbexc_exists |-> spec_past_mie == wbexc_post_mie);

Ibex_SpecPastWbexc_Mcause: assert property (wbexc_exists |-> spec_past_mcause == wbexc_post_mcause);

Ibex_SpecPastWbexc_Mtval: assert property (wbexc_exists |-> spec_past_mtval == wbexc_post_mtval);

Ibex_SpecPastWbexc_Mscratch: assert property (
    wbexc_exists |-> spec_past_mscratch == wbexc_post_mscratch
);

Ibex_SpecPastWbexc_Mcounteren: assert property (
    wbexc_exists |-> spec_past_mcounteren == wbexc_post_mcounteren
);

Ibex_SpecPastWbexc_Pc: assert property (wbexc_exists |-> spec_past_pc == wbexc_post_pc);

Ibex_SpecPastWbexc_Mtvec: assert property (wbexc_exists |-> spec_past_mtvec == wbexc_post_mtvec);

Ibex_SpecPastWbexc_Mepc: assert property (wbexc_exists |-> spec_past_mepc == wbexc_post_mepc);

Ibex_SpecPastWbexc_MscratchC: assert property (
    wbexc_exists |-> spec_past_mscratchc == wbexc_post_mscratchc
);

Ibex_SpecPastWbexc_Pcc: assert property (wbexc_exists |-> spec_past_pcc == wbexc_post_pcc);

Ibex_SpecPastWbexc_Mtdc: assert property (wbexc_exists |-> spec_past_mtdc == wbexc_post_mtdc);

Ibex_RfWriteWb: assert property (`CR.rf_write_wb & wbexc_finishing |-> `WB.rf_we_wb_o);

Ibex_CtrlWbexc: assert property (
    wbexc_exists |-> `IDC.ctrl_fsm_cs == `IDC.DECODE || `IDC.ctrl_fsm_cs == `IDC.FLUSH
);

Ibex_ProgressDecode: assert property (instr_will_progress |-> `IDC.ctrl_fsm_cs == `IDC.DECODE);

Ibex_BranchedProg: assert property (ex_has_branched_d & ~instr_will_progress |=> ex_has_branched_d);

Ibex_IDCFsmAny: assert property (
    `IDC.ctrl_fsm_cs inside {
        `IDC.RESET, `IDC.BOOT_SET, `IDC.WAIT_SLEEP, `IDC.SLEEP,
        `IDC.FIRST_FETCH, `IDC.DECODE, `IDC.IRQ_TAKEN, `IDC.FLUSH
    }
);

Ibex_IDCFsmNotBoot: assert property (##3 ~(`IDC.ctrl_fsm_cs inside {`IDC.RESET, `IDC.BOOT_SET}));

Ibex_MemInstrEx: assert property (`LSU.ls_fsm_cs != `LSU.IDLE |-> ex_is_mem_instr);

Ibex_MemInstrWbLoad: assert property (`WB.outstanding_load_wb_o |-> wbexc_is_load_instr);

Ibex_MemInstrWbStore: assert property (`WB.outstanding_store_wb_o |-> wbexc_is_store_instr);

Ibex_MemClockEn: assert property (`LSU.ls_fsm_cs != `LSU.IDLE |-> ibex_top_i.core_busy_q);

Ibex_MemInstrWbWrite: assert property (
    wbexc_exists & wbexc_is_store_instr & ~wbexc_err
    |->
    ~`WBG.rf_we_wb_q & ~`WBG.cheri_rf_we_q & ~`WBG.wb_cheri_load_q &
    (`WBG.wb_instr_type_q != WB_INSTR_LOAD)
);

Ibex_LsuCheriErrEx: assert property (`LSU.ls_fsm_cs != `LSU.IDLE |-> ~`LSU.cheri_err_q);

Ibex_TRVKOpValid: assert property (
    ((`TRVK.cpu_op_valid_q[0] & (|`TRVK.trsv_addr_q[0])) -> ~`RF.reg_rdy_vec[`TRVK.trsv_addr_q[0]])
    &
    ((`TRVK.cpu_op_valid_q[1] & (|`TRVK.trsv_addr_q[1])) -> ~`RF.reg_rdy_vec[`TRVK.trsv_addr_q[1]])
    &
    
    ((`TRVK.cpu_op_valid_q[2] & (|`TRVK.trsv_addr_q[2])) -> ~`RF.reg_rdy_vec[`TRVK.trsv_addr_q[2]])
);

Ibex_TRVKOutstandingCLC: assert property (
    `TRVK.cpu_op_active && (|`WBG.rf_waddr_wb_q) |-> ~`RF.reg_rdy_vec[`WBG.rf_waddr_wb_q]
);

Ibex_TRVKSecondOutstanding: assert property (
    `WB.outstanding_load_wb_o |->(
        (`TRVK.cpu_op_valid_q[0] & (|`TRVK.trsv_addr_q[0]))
        ->
        (~`WBG.rf_waddr_wb_q != (|`TRVK.trsv_addr_q[0]))
    ) &(
        (`TRVK.cpu_op_valid_q[1] & (|`TRVK.trsv_addr_q[1]))
        ->
        (~`WBG.rf_waddr_wb_q != (|`TRVK.trsv_addr_q[1]))
    ) &(
        (`TRVK.cpu_op_valid_q[2] & (|`TRVK.trsv_addr_q[2]))
        ->
        (~`WBG.rf_waddr_wb_q != (|`TRVK.trsv_addr_q[2]))
    )
);

Ibex_CPUOpActiveNoErr: assert property (
    wbexc_exists & ~wbexc_err |-> `IS_LOADCAPIMM == `TRVK.cpu_op_active
);

Ibex_CPUOpActiveErr: assert property (
    wbexc_exists & wbexc_err & `TRVK.cpu_op_active |-> `IS_LOADCAPIMM ##1 ~`TRVK.cpu_op_active
);

Ibex_TRSVAddr: assert property (
    wbexc_exists & ~wbexc_err & `IS_LOADCAPIMM |-> `TRVK.trsv_addr == `WB.rf_waddr_wb_o
);

Ibex_TRSVAddrLow: assert property (`TRVK.cpu_op_active |-> ~`TRVK.trsv_addr[4]);

Ibex_LsuWeq_Ex: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE && mem_gnt_fst_q |-> ex_is_store_instr == `LSU.data_we_q
);

Ibex_LSUEmpty: assert property (`LSU.ls_fsm_cs != `LSU.IDLE |-> ~wbexc_exists & ~ex_kill);

Ibex_LSUValidInstr: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE |-> ~`ID.instr_fetch_err_i & `ID.instr_valid_i & ~`ID.illegal_insn_o
);

Ibex_NoTBRE: assert property (
    ~`CE.lsu_tbre_sel_i & ~`LSU.req_is_tbre_q & ~`LSU.tbre_req_good & ~`CR.tbre_lsu_req
);

`endif

`ifndef REMOVE_SLICE_1
Ibex_PCCNotSealed: assert property (`CSR.pcc_cap_o.valid -> `CSR.pcc_cap_o.otype == 3'b0);

Ibex_PCCPermitExecute: assert property (`CSR.pcc_cap_o.valid -> `CSR.pcc_cap_o.perms[PERM_EX]);

Ibex_LsuWeq_Wb: assert property (outstanding_mem |-> wbexc_is_store_instr == `LSU.data_we_q);

Ibex_LSUEnd: assert property (`LSU.lsu_req_done_o |-> instr_will_progress);

Ibex_LSUNotTRSV: assert property (`LSU.ls_fsm_cs != `LSU.IDLE |-> ~`ID.stall_cheri_trvk);

`endif

`ifndef REMOVE_SLICE_2
Ibex_Memory_Initial: assert property (memory_initial |-> memory_idle);

Ibex_Memory_Initial_Idle: assert property (memory_idle && memory_initial |-> memory_idle_inv);

Ibex_Memory_WaitGnt1_Step: assert property (
    memory_wait_gnt1_inv && memory_wait_gnt1
    |->
    (memory_step) or ##1 (memory_wait_gnt1 || memory_wait_gnt2 || ~memory_pre)
);

Ibex_Memory_WaitGnt1_WaitGnt1_Inv: assert property (
    $past(memory_wait_gnt1) && memory_wait_gnt1 && $past(memory_wait_gnt1_inv)
    |->
    memory_wait_gnt1_inv
);

Ibex_Memory_WaitGnt1_WaitGnt2_Inv: assert property (
    $past(memory_wait_gnt1) && memory_wait_gnt2 && $past(memory_wait_gnt1_inv)
    |->
    memory_wait_gnt2_inv
);

Ibex_Memory_WaitGnt1_Step_Inv: assert property (
    memory_wait_gnt1 && memory_step && memory_wait_gnt1_inv |-> memory_step_inv
);

Ibex_Memory_End_Step: assert property (
    memory_end_inv && memory_end |-> (memory_idle) or ##1 (0 || ~memory_pre)
);

Ibex_Memory_End_Idle_Inv: assert property (
    memory_end && memory_idle && memory_end_inv |-> memory_idle_inv
);

Ibex_Memory_WaitGntMis_Step: assert property (
    memory_wait_gnt_mis_inv && memory_wait_gnt_mis
    |->
    (0) or ##1 (memory_wait_gnt_mis || memory_wait_rvalid_mis || ~memory_pre)
);

Ibex_Memory_WaitGntMis_WaitGntMis_Inv: assert property (
    $past(memory_wait_gnt_mis) && memory_wait_gnt_mis && $past(memory_wait_gnt_mis_inv)
    |->
    memory_wait_gnt_mis_inv
);

Ibex_Memory_WaitGntMis_WaitRvalidMis_Inv: assert property (
    $past(memory_wait_gnt_mis) && memory_wait_rvalid_mis && $past(memory_wait_gnt_mis_inv)
    |->
    memory_wait_rvalid_mis_inv
);

Ibex_Memory_IdleActive_Step: assert property (
    memory_idle_active_inv && memory_idle_active |-> (memory_step) or ##1 (
        memory_wait_rvalid_mis || memory_wait_gnt_mis || memory_wait_gnt ||
        memory_wait_gnt1 || memory_wait_gnt2 || ~memory_pre
    )
);

Ibex_Memory_IdleActive_WaitRvalidMis_Inv: assert property (
    $past(memory_idle_active) && memory_wait_rvalid_mis && $past(memory_idle_active_inv)
    |->
    memory_wait_rvalid_mis_inv
);

Ibex_Memory_IdleActive_WaitGntMis_Inv: assert property (
    $past(memory_idle_active) && memory_wait_gnt_mis && $past(memory_idle_active_inv)
    |->
    memory_wait_gnt_mis_inv
);

Ibex_Memory_IdleActive_WaitGnt_Inv: assert property (
    $past(memory_idle_active) && memory_wait_gnt && $past(memory_idle_active_inv)
    |->
    memory_wait_gnt_inv
);

Ibex_Memory_IdleActive_WaitGnt1_Inv: assert property (
    $past(memory_idle_active) && memory_wait_gnt1 && $past(memory_idle_active_inv)
    |->
    memory_wait_gnt1_inv
);

Ibex_Memory_IdleActive_WaitGnt2_Inv: assert property (
    $past(memory_idle_active) && memory_wait_gnt2 && $past(memory_idle_active_inv)
    |->
    memory_wait_gnt2_inv
);

Ibex_Memory_IdleActive_Step_Inv: assert property (
    memory_idle_active && memory_step && memory_idle_active_inv |-> memory_step_inv
);

Ibex_Memory_WaitRvalidMis_Step: assert property (
    memory_wait_rvalid_mis_inv && memory_wait_rvalid_mis
    |->
    (memory_step) or ##1
    (memory_wait_rvalid_mis || memory_wait_rvalid_mis_gnts_done || memory_wait_gnt || ~memory_pre)
);

Ibex_Memory_WaitRvalidMis_WaitRvalidMis_Inv: assert property (
    $past(memory_wait_rvalid_mis) && memory_wait_rvalid_mis && $past(memory_wait_rvalid_mis_inv)
    |->
    memory_wait_rvalid_mis_inv
);

Ibex_Memory_WaitRvalidMis_WaitRvalidMisGntsDone_Inv: assert property (
    $past(memory_wait_rvalid_mis) && memory_wait_rvalid_mis_gnts_done &&
    $past(memory_wait_rvalid_mis_inv)
    |->
    memory_wait_rvalid_mis_gnts_done_inv
);

Ibex_Memory_WaitRvalidMis_WaitGnt_Inv: assert property (
    $past(memory_wait_rvalid_mis) && memory_wait_gnt && $past(memory_wait_rvalid_mis_inv)
    |->
    memory_wait_gnt_inv
);

Ibex_Memory_WaitRvalidMis_Step_Inv: assert property (
    memory_wait_rvalid_mis && memory_step && memory_wait_rvalid_mis_inv |-> memory_step_inv
);

Ibex_Memory_WaitGnt_Step: assert property (
    memory_wait_gnt_inv && memory_wait_gnt |-> (memory_step) or ##1 (memory_wait_gnt || ~memory_pre)
);

Ibex_Memory_WaitGnt_WaitGnt_Inv: assert property (
    $past(memory_wait_gnt) && memory_wait_gnt && $past(memory_wait_gnt_inv) |-> memory_wait_gnt_inv
);

Ibex_Memory_WaitGnt_Step_Inv: assert property (
    memory_wait_gnt && memory_step && memory_wait_gnt_inv |-> memory_step_inv
);

Ibex_Memory_WaitRvalidMisGntsDone_Step: assert property (
    memory_wait_rvalid_mis_gnts_done_inv && memory_wait_rvalid_mis_gnts_done
    |->
    (memory_step) or ##1 (memory_wait_rvalid_mis_gnts_done || ~memory_pre)
);

Ibex_Memory_WaitRvalidMisGntsDone_WaitRvalidMisGntsDone_Inv: assert property (
    $past(memory_wait_rvalid_mis_gnts_done) && memory_wait_rvalid_mis_gnts_done &&
    $past(memory_wait_rvalid_mis_gnts_done_inv)
    |->
    memory_wait_rvalid_mis_gnts_done_inv
);

Ibex_Memory_WaitRvalidMisGntsDone_Step_Inv: assert property (
    memory_wait_rvalid_mis_gnts_done && memory_step && memory_wait_rvalid_mis_gnts_done_inv
    |->
    memory_step_inv
);

Ibex_Memory_WaitGnt2_Step: assert property (
    memory_wait_gnt2_inv && memory_wait_gnt2
    |->
    (memory_step) or ##1
    (memory_wait_gnt2 || memory_wait_gnt2_direct || memory_wait_resp || ~memory_pre)
);

Ibex_Memory_WaitGnt2_WaitGnt2_Inv: assert property (
    $past(memory_wait_gnt2) && memory_wait_gnt2 && $past(memory_wait_gnt2_inv)
    |->
    memory_wait_gnt2_inv
);

Ibex_Memory_WaitGnt2_WaitGnt2Direct_Inv: assert property (
    $past(memory_wait_gnt2) && memory_wait_gnt2_direct && $past(memory_wait_gnt2_inv)
    |->
    memory_wait_gnt2_direct_inv
);

Ibex_Memory_WaitGnt2_WaitResp_Inv: assert property (
    $past(memory_wait_gnt2) && memory_wait_resp && $past(memory_wait_gnt2_inv)
    |->
    memory_wait_resp_inv
);

Ibex_Memory_WaitGnt2_Step_Inv: assert property (
    memory_wait_gnt2 && memory_step && memory_wait_gnt2_inv |-> memory_step_inv
);

Ibex_Memory_WaitGnt2Direct_Step: assert property (
    memory_wait_gnt2_direct_inv && memory_wait_gnt2_direct
    |->
    (memory_step) or ##1 (memory_wait_gnt2_direct || ~memory_pre)
);

Ibex_Memory_WaitGnt2Direct_WaitGnt2Direct_Inv: assert property (
    $past(memory_wait_gnt2_direct) && memory_wait_gnt2_direct && $past(memory_wait_gnt2_direct_inv)
    |->
    memory_wait_gnt2_direct_inv
);

Ibex_Memory_WaitGnt2Direct_Step_Inv: assert property (
    memory_wait_gnt2_direct && memory_step && memory_wait_gnt2_direct_inv |-> memory_step_inv
);

Ibex_Memory_WaitResp_Step: assert property (
    memory_wait_resp_inv && memory_wait_resp
    |->
    (memory_step) or ##1 (memory_wait_resp || ~memory_pre)
);

Ibex_Memory_WaitResp_WaitResp_Inv: assert property (
    $past(memory_wait_resp) && memory_wait_resp && $past(memory_wait_resp_inv)
    |->
    memory_wait_resp_inv
);

Ibex_Memory_WaitResp_Step_Inv: assert property (
    memory_wait_resp && memory_step && memory_wait_resp_inv |-> memory_step_inv
);

Ibex_Memory_Idle_Step: assert property (
    memory_idle_inv && memory_idle |-> (memory_idle_active) or ##1 (memory_idle || ~memory_pre)
);

Ibex_Memory_Idle_Idle_Inv: assert property (
    $past(memory_idle) && memory_idle && $past(memory_idle_inv) |-> memory_idle_inv
);

Ibex_Memory_Idle_IdleActive_Inv: assert property (
    memory_idle && memory_idle_active && memory_idle_inv |-> memory_idle_active_inv
);

Ibex_Memory_Wait_Step: assert property (
    memory_wait_inv && memory_wait |-> (0) or ##1 (memory_wait || memory_end || ~memory_pre)
);

Ibex_Memory_Wait_Wait_Inv: assert property (
    $past(memory_wait) && memory_wait && $past(memory_wait_inv) |-> memory_wait_inv
);

Ibex_Memory_Wait_End_Inv: assert property (
    $past(memory_wait) && memory_end && $past(memory_wait_inv) |-> memory_end_inv
);

Ibex_Memory_Step_Step: assert property (
    memory_step_inv && memory_step |-> (0) or ##1 (memory_wait || memory_end || ~memory_pre)
);

Ibex_Memory_Step_Wait_Inv: assert property (
    $past(memory_step) && memory_wait && $past(memory_step_inv) |-> memory_wait_inv
);

Ibex_Memory_Step_End_Inv: assert property (
    $past(memory_step) && memory_end && $past(memory_step_inv) |-> memory_end_inv
);

`endif

`ifndef REMOVE_SLICE_3
Ibex_Memory_WaitRvalidMisGntsDone_Rev: assert property (
    memory_wait_rvalid_mis_gnts_done
    |->
    (0) or
    (
        ($past(memory_wait_rvalid_mis_gnts_done) || $past(memory_wait_rvalid_mis)) &&
        $past(memory_pre)
    )
);

Ibex_Memory_WaitGnt2_Rev: assert property (
    memory_wait_gnt2 |-> (0) or (
        ($past(memory_wait_gnt1) || $past(memory_idle_active) || $past(memory_wait_gnt2)) &&
        $past(memory_pre)
    )
);

Ibex_Memory_WaitGnt2Direct_Rev: assert property (
    memory_wait_gnt2_direct
    |->
    (0) or (($past(memory_wait_gnt2) || $past(memory_wait_gnt2_direct)) && $past(memory_pre))
);

Ibex_Memory_WaitResp_Rev: assert property (
    memory_wait_resp
    |->
    (0) or (($past(memory_wait_gnt2) || $past(memory_wait_resp)) && $past(memory_pre))
);

Ibex_Memory_Idle_Rev: assert property (
    memory_idle |-> (memory_end || memory_initial) or ($past(memory_idle) && $past(memory_pre))
);

Ibex_Memory_IdleActive_Rev: assert property (
    memory_idle_active |-> (memory_idle) or (0 && $past(memory_pre))
);

Ibex_Memory_WaitRvalidMis_Rev: assert property (
    memory_wait_rvalid_mis |-> (0) or (
        ($past(memory_wait_gnt_mis) || $past(memory_idle_active) || $past(memory_wait_rvalid_mis))
        &&
        $past(memory_pre)
    )
);

Ibex_Memory_WaitGnt_Rev: assert property (
    memory_wait_gnt |-> (0) or (
        ($past(memory_idle_active) || $past(memory_wait_rvalid_mis) || $past(memory_wait_gnt)) &&
        $past(memory_pre)
    )
);

Ibex_Memory_Step_Rev: assert property (
    memory_step |-> (
        memory_wait_gnt1 || memory_wait_gnt ||
        memory_wait_rvalid_mis_gnts_done || memory_wait_gnt2 ||
        memory_wait_gnt2_direct || memory_wait_resp || memory_idle_active || memory_wait_rvalid_mis
    ) or (0 && $past(memory_pre))
);

Ibex_Memory_Wait_Rev: assert property (
    memory_wait |-> (0) or (($past(memory_step) || $past(memory_wait)) && $past(memory_pre))
);

Ibex_Memory_WaitGntMis_Rev: assert property (
    memory_wait_gnt_mis
    |->
    (0) or (($past(memory_wait_gnt_mis) || $past(memory_idle_active)) && $past(memory_pre))
);

Ibex_Memory_WaitGnt1_Rev: assert property (
    memory_wait_gnt1
    |->
    (0) or (($past(memory_idle_active) || $past(memory_wait_gnt1)) && $past(memory_pre))
);

Ibex_Memory_End_Rev: assert property (
    memory_end |-> (0) or (($past(memory_step) || $past(memory_wait)) && $past(memory_pre))
);

`endif

`ifndef REMOVE_SLICE_4
Ibex_Memory_WaitGntMis: assert property (memory_wait_gnt_mis |-> memory_wait_gnt_mis_inv);

Ibex_Memory_WaitGnt1: assert property (memory_wait_gnt1 |-> memory_wait_gnt1_inv);

Ibex_Memory_End: assert property (memory_end |-> memory_end_inv);

Ibex_Memory_WaitResp: assert property (memory_wait_resp |-> memory_wait_resp_inv);

Ibex_Memory_Idle: assert property (memory_idle |-> memory_idle_inv);

Ibex_Memory_IdleActive: assert property (memory_idle_active |-> memory_idle_active_inv);

Ibex_Memory_WaitRvalidMis: assert property (memory_wait_rvalid_mis |-> memory_wait_rvalid_mis_inv);

Ibex_Memory_WaitGnt: assert property (memory_wait_gnt |-> memory_wait_gnt_inv);

Ibex_Memory_WaitRvalidMisGntsDone: assert property (
    memory_wait_rvalid_mis_gnts_done |-> memory_wait_rvalid_mis_gnts_done_inv
);

Ibex_Memory_WaitGnt2: assert property (memory_wait_gnt2 |-> memory_wait_gnt2_inv);

Ibex_Memory_WaitGnt2Direct: assert property (
    memory_wait_gnt2_direct |-> memory_wait_gnt2_direct_inv
);

Ibex_Memory_Step: assert property (memory_step |-> memory_step_inv);

Ibex_Memory_Wait: assert property (memory_wait |-> memory_wait_inv);

`endif

`ifndef REMOVE_SLICE_5
Ibex_NoMemAccessNoRValid: assert property (`LSU.lsu_resp_valid_o -> outstanding_mem);

Ibex_StallNoChangeA: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE && ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(`ID.rf_rdata_a_fwd) & $stable(`CE.rf_rcap_a)
);

Ibex_StallNoChangeB: assert property (
    data_we_o && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(`ID.rf_rdata_b_fwd) & $stable(`CE.rf_rcap_a)
);

Ibex_BecameDecodeIsInstrStart: assert property (
    `IDC.ctrl_fsm_cs == `IDC.DECODE && !$stable(`IDC.ctrl_fsm_cs)
    |->
    ~`ID.instr_valid_i | `CR.instr_new_id
);

Ibex_BecameDecodeIsEmptyWbexc: assert property (
    `IDC.ctrl_fsm_cs == `IDC.DECODE && !$stable(`IDC.ctrl_fsm_cs) |-> ~wbexc_exists
);

Ibex_FetchErrIsErr: assert property (
    wbexc_fetch_err & wbexc_exists |-> wbexc_err & `IDC.instr_fetch_err
);

Ibex_MemOpRequiresValid: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE || `CR.lsu_req |-> `ID.instr_valid_i
);

Ibex_MultEndState: assert property (instr_will_progress |=> `MULTG.mult_state_q == `MULTG.ALBL);

Ibex_DataWeOutstanding: assert property (
    outstanding_mem |-> `ID.outstanding_store_wb_i == `LSU.data_we_q
);

Ibex_TRVKMutex: assert property (
    (`RF.we_a_i & `RF.trvk_en_i & (|`RF.we_a_dec)) -> (`RF.trvk_dec != `RF.we_a_dec)
);

Ibex_DTI_SingleWbSource: assert property ($onehot0(`WB.rf_wdata_wb_mux_we));

`endif

`ifndef REMOVE_SLICE_6
Ibex_DTI_Ex_Csr: assert property (`CE.cheri_exec_id_i && ex_in_sats |-> ex_out_csr_sats);

Ibex_DTI_Ex_Lsu: assert property (`CE.cheri_exec_id_i && ex_in_sats |-> ex_out_lsu_sats);

Ibex_DTI_Ex_Result: assert property (`CE.cheri_exec_id_i && ex_in_sats |-> ex_out_result_sats);

Ibex_DTI_Ex_Pcc: assert property (
    `CE.cheri_exec_id_i && ex_in_sats |-> `CE.branch_req_o |-> ex_out_pcc_sats
);

Ibex_DTI_Csr_mtvec: assert property (csr_in |=> csr_mtvec_sats);

Ibex_DTI_Csr_mepc: assert property (csr_in |=> csr_mepc_sats);

Ibex_DTI_Csr_mtdc: assert property (csr_in |=> csr_mtdc_sats);

Ibex_DTI_Csr_mscratchc: assert property (csr_in |=> csr_mscratchc_sats);

Ibex_DTI_Csr_depc: assert property (csr_in |=> csr_depc_sats);

Ibex_DTI_Csr_dscratch0: assert property (csr_in |=> csr_dscratch0_sats);

Ibex_DTI_Csr_dscratch1: assert property (csr_in |=> csr_dscratch1_sats);

Ibex_DTI_Csr_PccIn: assert property (csr_in |=> csr_out_pcc_sats);

Ibex_DTI_Csr_Out: assert property (csr_int |-> csr_out_rdata_sats && csr_out_pcc_sats);

Ibex_DTI_Wb_Int: assert property (wb_in && wb_int |=> wb_int);

Ibex_DTI_Wb_LsuIn: assert property (wb_in_lsu);

Ibex_DTI_Wb_Ext: assert property (wb_int && wb_in_lsu |-> wb_out);

Ibex_DTI_Rf_A: assert property (rf_all |-> rf_out_a);

Ibex_DTI_Rf_B: assert property (rf_all |-> rf_out_b);

Ibex_DTI_Rf_Int1: assert property (rf_all |-> rf_in |=> rf_group1);

Ibex_DTI_Rf_Int2: assert property (rf_all |-> rf_in |=> rf_group2);

`endif

`ifndef REMOVE_SLICE_7
Ibex_DTI_Ex: assert property (
    ex_out_csr_sats && ex_out_lsu_sats && ex_out_result_sats &&
    (`CE.branch_req_o -> ex_out_pcc_sats)
);

Ibex_DTI_Ex_Inner: assert property (ex_inner_sats);

Ibex_DTI_Csr: assert property (csr_int);

Ibex_DTI_Csr_Pcc: assert property (csr_out_pcc_sats);

Ibex_DTI_Wb: assert property (wb_int);

Ibex_DTI_Rf: assert property (rf_all);

`endif

`ifndef REMOVE_SLICE_8
Ibex_MemErrKind: assert property (
    finishing_executed && wbexc_is_mem_instr && ~wbexc_illegal && wbexc_err
    |->
    `IDC.store_err_q | `IDC.load_err_q
);

Ibex_MemErrStructure: assert property (
    finishing_executed && wbexc_is_mem_instr && ~wbexc_illegal && wbexc_err
    |->
    $past(instr_will_progress, 2) | $past(data_rvalid_i)
);

Ibex_MemNoErrStructure: assert property (
    finishing_executed && wbexc_is_mem_instr && ~wbexc_illegal && ~wbexc_err |-> data_rvalid_i
);

Ibex_WbexcMemErrKindLoad: assert property (`IDC.load_err_q |-> wbexc_exists & wbexc_is_load_instr);

Ibex_WbexcMemErrKindStore: assert property (
    `IDC.store_err_q |-> wbexc_exists & wbexc_is_store_instr
);

Ibex_WbexcNotMemMuteLSU: assert property (
    ~wbexc_is_mem_instr
    ->
    ~`CR.rf_we_lsu & ~`CR.lsu_resp_valid & ~`CR.lsu_load_err & ~`CR.lsu_store_err
);

Ibex_WbexcNotMemMuteMemErr: assert property (
    ~wbexc_is_mem_instr -> ~`IDC.load_err_q & ~`IDC.store_err_q
);

Ibex_StallIdFSM2: assert property (
    `ID.instr_executing && ~instr_will_progress |=> `ID.instr_executing
);

Ibex_NewIdFSM: assert property (`CR.instr_new_id |-> `ID.id_fsm_q == 0);

Ibex_PreNextPcMatch: assert property (
    instr_will_progress & ~ex_has_branched_d & ~`IDC.instr_fetch_err -> pre_nextpc == `CR.pc_if
);

Ibex_StallNoChangeLsuWData: assert property (
    (
        data_we_o && `LSU.ls_fsm_cs != `LSU.IDLE &&
        ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
        |->
        $stable(`LSU.lsu_wdata_i)
    )
);

Ibex_SpecStableLoad: assert property (
    ex_is_load_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_read)
);

Ibex_SpecStableLoadSnd: assert property (
    ex_is_load_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_read_snd)
);

Ibex_SpecStableLoadAddr: assert property (
    ex_is_load_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_read_fst_addr)
);

Ibex_SpecStableLoadSndAddr: assert property (
    ex_is_load_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_read_snd_addr)
);

Ibex_SpecStableStore: assert property (
    ex_is_store_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_write)
);

Ibex_SpecStableStoreSnd: assert property (
    ex_is_store_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_write_snd)
);

Ibex_SpecStableStoreAddr: assert property (
    ex_is_store_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_write_fst_addr)
);

Ibex_SpecStableStoreSndAddr: assert property (
    ex_is_store_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_write_snd_addr)
);

Ibex_SpecStableStoreData: assert property (
    ex_is_store_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_write_fst_wdata)
);

Ibex_SpecStableStoreSndData: assert property (
    ex_is_store_instr && `LSU.ls_fsm_cs != `LSU.IDLE &&
    ($past(`LSU.ls_fsm_cs) != `LSU.IDLE || $past(`LSU.lsu_req_i))
    |->
    $stable(spec_mem_write_snd_wdata)
);

Ibex_LoadNotSpecWrite: assert property (ex_is_load_instr |-> ~spec_mem_write);

Ibex_StoreNotSpecRead: assert property (ex_is_store_instr |-> ~spec_mem_read);

Ibex_FirstCycleNoGnt: assert property (`ID.instr_first_cycle |-> ~mem_gnt_fst_q);

Ibex_MemStartFirstCycle: assert property (
    `LSU.ls_fsm_cs == `LSU.IDLE && `CR.lsu_req |-> `ID.instr_first_cycle
);

Ibex_DivInstrStable: assert property (
    `MULT.md_state_q != `MULT.MD_IDLE
    |->
    $stable(`CR.instr_rdata_id) && `CR.instr_valid_id &&
    (~`ID.stall_multdiv -> `MULT.md_state_q == `MULT.MD_FINISH) &&
    `MULTG.mult_state_q == `MULTG.ALBL &&
    `MULT.div_en_internal && (~wbexc_exists | wbexc_finishing)
);

Ibex_InstrReqCount: assert property (
    (instr_mem_assume.outstanding_reqs_q == 2) ==
    (`IFP.rdata_outstanding_q[1] && `IFP.rdata_outstanding_q[0]) &&
    (instr_mem_assume.outstanding_reqs_q == 1) ==
    (~`IFP.rdata_outstanding_q[1] && `IFP.rdata_outstanding_q[0]) &&
    
    (instr_mem_assume.outstanding_reqs_q == 0) ==
    (~`IFP.rdata_outstanding_q[1] && ~`IFP.rdata_outstanding_q[0])
);

Ibex_FetchErrRoot: assert property (
    `ID.instr_valid_i && (`IDC.ctrl_fsm_cs == `IDC.FLUSH -> ~$past(`IDC.csr_pipe_flush))
    |->
    spec_fetch_err == `ID.instr_fetch_err_i
);

`endif

`ifndef REMOVE_SLICE_9
Ibex_MepcEn: assert property (
    `CSR.mepc_en |-> instr_will_progress | wbexc_finishing | wbexc_handling_irq
);

Ibex_DivNoKill: assert property (`MULT.md_state_q != `MULT.MD_IDLE |-> ~ex_kill);

Ibex_RTypeFirstCycle: assert property (
    `CR.instr_valid_id & ex_is_rtype |-> `ID.instr_first_cycle_id_o
);

Ibex_DataMemGntMaxDelay: assert property (data_req_o |-> ##[0:`TIME_LIMIT] data_gnt_i);

Ibex_DataMemRvalidMaxDelay: assert property (data_gnt_i |=> ##[0:`TIME_LIMIT] data_rvalid_i);

Ibex_InstrMemGntMaxDelay: assert property (instr_req_o |-> ##[0:`TIME_LIMIT] instr_gnt_i);

Ibex_InstrMemRvalidMaxDelay: assert property (instr_gnt_i |=> ##[0:`TIME_LIMIT] instr_rvalid_i);

Ibex_NormalMainResMatch: assert property (
    `ID.instr_valid_i && ~ex_kill && main_mode == MAIN_IDEX |-> spec_api_i.main_result == MAINRES_OK
);

Ibex_FetchErrMainResMatch: assert property (
    `ID.instr_valid_i && ~ex_kill && main_mode == MAIN_IFERR
    |->
    spec_api_i.main_result == MAINRES_OK
);

Ibex_IRQMainResMatch: assert property (
    wbexc_handling_irq && main_mode == MAIN_IRQ |-> spec_api_i.main_result == MAINRES_OK
);

Ibex_NoStallBranch: assert property (
    `ID.instr_valid_i & `ID.stall_id & ~`ID.branch_set_raw &
    ~`ID.jump_set_raw & ~`IDC.cheri_branch_req_i
    |->
    ~ex_has_branched_d
);

Ibex_FirstCycleHold: assert property (
    `ID.instr_valid_i & ~`ID.instr_executing |-> `ID.id_fsm_q == `ID.FIRST_CYCLE
);

Ibex_ReqNotOutstanding: assert property (
    `LSU.ls_fsm_cs == `LSU.IDLE && `CR.lsu_req |-> ~`LSU.resp_wait
);

`endif

`ifndef REMOVE_SLICE_10
Ibex_SpecEnUnreach: assert property (spec_en |-> ~spec_int_err);

`endif

`ifndef REMOVE_SLICE_11
Base_I_Fast: assert property (
    (`IS_ADDI | `IS_SLTI | `IS_SLTIU | `IS_XORI | `IS_ORI | `IS_ANDI) &&
    finishing_executed & ~wbexc_illegal
    |->
    $past(instr_will_progress)
);

Base_R_Fast: assert property (
    (
        `IS_ADD | `IS_SUB | `IS_SLL | `IS_SLT | `IS_SLTU |
        `IS_XOR | `IS_SRL | `IS_SRA | `IS_OR | `IS_AND
    )
    &&
    finishing_executed & ~wbexc_illegal
    |->
    $past(instr_will_progress)
);

Base_Shift_Fast: assert property (
    `IS_SHIFTIOP && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Base_Lui_Fast: assert property (
    `IS_LUI && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Base_Fence_Fast: assert property (
    `IS_FENCE && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Base_FenceI_Fast: assert property (
    `IS_FENCEI && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_CGet_Fast: assert property (
    `IS_CGET && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_CSeal_Fast: assert property (
    `IS_CSEAL_ANDPERM && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_CAddr_Fast: assert property (
    `IS_CSETADDRx && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_CBounds_Fast: assert property (
    `IS_CSETBOUNDSx && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_CMov_Fast: assert property (
    `IS_CCLRSUBMOV && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_AUIC_Fast: assert property (
    `IS_AUIC && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_CCmp_Fast: assert property (
    `IS_CCMP && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Cheri_CHigh_Fast: assert property (
    `IS_CHIGH && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

CheriJump_CJal_FastErr: assert property (
    `IS_CJAL && finishing_executed & ~wbexc_illegal |-> wbexc_err |-> $past(instr_will_progress, 2)
);

CheriJump_CJal_FastNormal: assert property (
    `IS_CJAL && finishing_executed & ~wbexc_illegal |-> ~wbexc_err |-> $past(instr_will_progress)
);

CheriJump_CJalR_FastErr: assert property (
    `IS_CJALR && finishing_executed & ~wbexc_illegal |-> wbexc_err |-> $past(instr_will_progress, 2)
);

CheriJump_CJalR_FastNormal: assert property (
    `IS_CJALR && finishing_executed & ~wbexc_illegal |-> ~wbexc_err |-> $past(instr_will_progress)
);

CheriCSR_FastErr: assert property (
    `IS_CSPECIALRW && finishing_executed & ~wbexc_illegal
    |->
    wbexc_err |-> $past(instr_will_progress, 2)
);

CheriCSR_FastNormal: assert property (
    `IS_CSPECIALRW && finishing_executed & ~wbexc_illegal
    |->
    ~wbexc_err |-> $past(instr_will_progress)
);

MType_Mul_NoErr: assert property (`IS_MUL && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

MType_MulH_NoErr: assert property (`IS_MULH && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

MType_MulHSH_NoErr: assert property (
    `IS_MULHSH && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

MType_MulHU_NoErr: assert property (
    `IS_MULHU && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

MType_Div_NoErr: assert property (`IS_DIV && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

MType_DivU_NoErr: assert property (`IS_DIVU && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

MType_Rem_NoErr: assert property (`IS_REM && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

MType_RemU_NoErr: assert property (`IS_REMU && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

CSR_Fast: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal
    |->
    $past(instr_will_progress)
);

BType_FinishFirstCycle: assert property (
    instr_will_progress & ex_is_btype & ~ex_err |-> `ID.instr_first_cycle
);

BType_Fast: assert property (
    `IS_BTYPE && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

JAL_FinishFirstCycle: assert property (
    instr_will_progress & `IDC.jump_set_i & ~ex_err |-> `ID.instr_first_cycle
);

JAL_Fast: assert property (
    `IS_JAL && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Special_ECall_Fast: assert property (
    `IS_ECALL && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Special_EBreak_Fast: assert property (
    `IS_EBREAK && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Special_MRet_Fast: assert property (
    `IS_MRET && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Special_WFI_Fast: assert property (
    `IS_WFI && finishing_executed & ~wbexc_illegal |-> $past(instr_will_progress)
);

Mem_FastErr: assert property (
    finishing_executed & ~wbexc_illegal & wbexc_err & wbexc_is_mem_instr
    |->
    $past(instr_will_progress, 2)
);

Mem_MemNotWFI: assert property (wbexc_exists && wbexc_is_mem_instr |-> ~wbexc_is_wfi);

Mem_MemFin: assert property (
    finishing_executed && wbexc_is_mem_instr && ~wbexc_err |-> data_rvalid_i
);

Mem_RespWait: assert property (
    wbexc_exists && wbexc_is_mem_instr && ~wbexc_err && ~data_rvalid_i
    |->
    `LSU.ls_fsm_cs == `LSU.IDLE && ~`LSU.lsu_req_i
);

Mem_CapResp: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE || (outstanding_mem & ~wbexc_err) || data_rvalid_i |->(
        (wbexc_exists && ~wbexc_err && (`IS_LOADCAPIMM | `IS_STORECAPIMM)) ||
        (`LSU.ls_fsm_cs != `LSU.IDLE && ex_is_mem_cap_instr)
    ) == `LSU.resp_is_cap_q
);

Mem_CapLSWErr: assert property (~`LSU.cap_lsw_err_q);

Mem_EarlyLSUCtrlMatch: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE & spec_post_wX_en & mem_gnt_fst_q
    |->
    `LSU.rdata_offset_q == `LSU.data_offset && `LSU.data_type_q == `LSU.lsu_type_i &&
    `LSU.data_sign_ext_q == `LSU.lsu_sign_ext_i && `LSU.data_we_q == `LSU.lsu_we_i
);

Mem_HadSndReqCap: assert property (
    instr_will_progress & ex_is_mem_cap_instr & ~ex_err & ~`LSU.lsu_cheri_err_i
    |=>
    wbexc_mem_had_snd_req
);

Mem_HadSndReqNotCap: assert property (
    instr_will_progress & ex_is_mem_instr & ~ex_is_mem_cap_instr & ~ex_err & ~`LSU.lsu_cheri_err_i
    |=>
    wbexc_mem_had_snd_req == $past(`LSU.split_misaligned_access)
);

Mem_LateLSUCheriErr: assert property (
    wbexc_exists & wbexc_is_load_instr & ~wbexc_err & wbexc_post_wX_en |-> ~`LSU.cheri_err_q
);

Mem_PMPErr: assert property (~`LSU.pmp_err_q);

Mem_NonCapFSM: assert property (
    ~ex_is_mem_cap_instr
    |->
    `LSU.ls_fsm_cs != `LSU.CTX_WAIT_GNT1 &&
    `LSU.ls_fsm_cs != `LSU.CTX_WAIT_GNT2 && `LSU.ls_fsm_cs != `LSU.CTX_WAIT_RESP
);

Mem_MisStates: assert property (
    `LSU.ls_fsm_cs == `LSU.WAIT_GNT_MIS || `LSU.ls_fsm_cs == `LSU.WAIT_RVALID_MIS ||
    `LSU.ls_fsm_cs == `LSU.WAIT_RVALID_MIS_GNTS_DONE
    |->
    `LSU.split_misaligned_access
);

Mem_CapFsm_Initial: assert property (
    ex_is_mem_cap_instr &&
    (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) && capfsm_initial
    |->
    capfsm_idle_active
);

Mem_CapFsm_Initial_IdleActive: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_idle_active && capfsm_initial
    |->
    capfsm_idle_active_inv
);

Mem_CapFsm_IdleActive_Step: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_idle_active_inv && capfsm_idle_active
    |->
    (0) or ##1 (capfsm_wait_gnt1 || capfsm_wait_gnt2 || capfsm_wait_gnt2_done || ~capfsm_pre)
);

Mem_CapFsm_IdleActive_WaitGnt1_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_idle_active) && capfsm_wait_gnt1 && $past(capfsm_idle_active_inv)
    |->
    capfsm_wait_gnt1_inv
);

Mem_CapFsm_IdleActive_WaitGnt2_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_idle_active) && capfsm_wait_gnt2 && $past(capfsm_idle_active_inv)
    |->
    capfsm_wait_gnt2_inv
);

Mem_CapFsm_IdleActive_WaitGnt2Done_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_idle_active) && capfsm_wait_gnt2_done && $past(capfsm_idle_active_inv)
    |->
    capfsm_wait_gnt2_done_inv
);

Mem_CapFsm_WaitGnt1_Step: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_gnt1_inv && capfsm_wait_gnt1
    |->
    (0) or ##1 (capfsm_wait_gnt1 || capfsm_wait_gnt2 || capfsm_wait_gnt2_done || ~capfsm_pre)
);

Mem_CapFsm_WaitGnt1_WaitGnt1_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_gnt1) && capfsm_wait_gnt1 && $past(capfsm_wait_gnt1_inv)
    |->
    capfsm_wait_gnt1_inv
);

Mem_CapFsm_WaitGnt1_WaitGnt2_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_gnt1) && capfsm_wait_gnt2 && $past(capfsm_wait_gnt1_inv)
    |->
    capfsm_wait_gnt2_inv
);

Mem_CapFsm_WaitGnt1_WaitGnt2Done_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_gnt1) && capfsm_wait_gnt2_done && $past(capfsm_wait_gnt1_inv)
    |->
    capfsm_wait_gnt2_done_inv
);

Mem_CapFsm_WaitGnt2_Step: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_gnt2_inv && capfsm_wait_gnt2
    |->
    (capfsm_step) or ##1
    (capfsm_wait_gnt2 || capfsm_wait_gnt2_done || capfsm_wait_resp || ~capfsm_pre)
);

Mem_CapFsm_WaitGnt2_WaitGnt2_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_gnt2) && capfsm_wait_gnt2 && $past(capfsm_wait_gnt2_inv)
    |->
    capfsm_wait_gnt2_inv
);

Mem_CapFsm_WaitGnt2_WaitGnt2Done_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_gnt2) && capfsm_wait_gnt2_done && $past(capfsm_wait_gnt2_inv)
    |->
    capfsm_wait_gnt2_done_inv
);

Mem_CapFsm_WaitGnt2_WaitResp_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_gnt2) && capfsm_wait_resp && $past(capfsm_wait_gnt2_inv)
    |->
    capfsm_wait_resp_inv
);

Mem_CapFsm_WaitGnt2_Step_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_gnt2 && capfsm_step && capfsm_wait_gnt2_inv
    |->
    capfsm_step_inv
);

Mem_CapFsm_WaitGnt2Done_Step: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_gnt2_done_inv && capfsm_wait_gnt2_done
    |->
    (capfsm_step) or ##1 (capfsm_wait_gnt2_done || ~capfsm_pre)
);

Mem_CapFsm_WaitGnt2Done_WaitGnt2Done_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_gnt2_done) && capfsm_wait_gnt2_done && $past(capfsm_wait_gnt2_done_inv)
    |->
    capfsm_wait_gnt2_done_inv
);

Mem_CapFsm_WaitGnt2Done_Step_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_gnt2_done && capfsm_step && capfsm_wait_gnt2_done_inv
    |->
    capfsm_step_inv
);

Mem_CapFsm_WaitResp_Step: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_resp_inv && capfsm_wait_resp
    |->
    (capfsm_step) or ##1 (capfsm_wait_resp || ~capfsm_pre)
);

Mem_CapFsm_WaitResp_WaitResp_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(capfsm_wait_resp) && capfsm_wait_resp && $past(capfsm_wait_resp_inv)
    |->
    capfsm_wait_resp_inv
);

Mem_CapFsm_WaitResp_Step_Inv: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_resp && capfsm_step && capfsm_wait_resp_inv
    |->
    capfsm_step_inv
);

Mem_MemSpec_Initial: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_initial
    |->
    memspec_idle_active
);

Mem_MemSpec_Initial_IdleActive: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_idle_active && memspec_initial
    |->
    memspec_idle_active_inv
);

Mem_MemSpec_WaitResp_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_resp_inv && memspec_wait_resp
    |->
    (memspec_step) or ##1 (memspec_wait_resp || ~memspec_pre)
);

Mem_MemSpec_WaitResp_WaitResp_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_resp) && memspec_wait_resp && $past(memspec_wait_resp_inv)
    |->
    memspec_wait_resp_inv
);

Mem_MemSpec_WaitResp_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_resp && memspec_step && memspec_wait_resp_inv
    |->
    memspec_step_inv
);

Mem_MemSpec_IdleActive_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_idle_active_inv && memspec_idle_active
    |->
    (memspec_step) or ##1 (
        memspec_wait_rvalid_mis || memspec_wait_gnt_mis || memspec_wait_gnt ||
        memspec_wait_gnt1 || memspec_wait_gnt2 || ~memspec_pre
    )
);

Mem_MemSpec_IdleActive_WaitRvalidMis_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_idle_active) && memspec_wait_rvalid_mis && $past(memspec_idle_active_inv)
    |->
    memspec_wait_rvalid_mis_inv
);

Mem_MemSpec_IdleActive_WaitGntMis_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_idle_active) && memspec_wait_gnt_mis && $past(memspec_idle_active_inv)
    |->
    memspec_wait_gnt_mis_inv
);

Mem_MemSpec_IdleActive_WaitGnt_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_idle_active) && memspec_wait_gnt && $past(memspec_idle_active_inv)
    |->
    memspec_wait_gnt_inv
);

Mem_MemSpec_IdleActive_WaitGnt1_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_idle_active) && memspec_wait_gnt1 && $past(memspec_idle_active_inv)
    |->
    memspec_wait_gnt1_inv
);

Mem_MemSpec_IdleActive_WaitGnt2_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_idle_active) && memspec_wait_gnt2 && $past(memspec_idle_active_inv)
    |->
    memspec_wait_gnt2_inv
);

Mem_MemSpec_IdleActive_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_idle_active && memspec_step && memspec_idle_active_inv
    |->
    memspec_step_inv
);

Mem_MemSpec_WaitRvalidMis_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis_inv && memspec_wait_rvalid_mis
    |->
    (memspec_step) or ##1 (
        memspec_wait_rvalid_mis || memspec_wait_rvalid_mis_gnts_done ||
        memspec_wait_gnt_split || ~memspec_pre
    )
);

Mem_MemSpec_WaitRvalidMis_WaitRvalidMis_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_rvalid_mis) && memspec_wait_rvalid_mis &&
    $past(memspec_wait_rvalid_mis_inv)
    |->
    memspec_wait_rvalid_mis_inv
);

Mem_MemSpec_WaitRvalidMis_WaitRvalidMisGntsDone_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_rvalid_mis) && memspec_wait_rvalid_mis_gnts_done &&
    $past(memspec_wait_rvalid_mis_inv)
    |->
    memspec_wait_rvalid_mis_gnts_done_inv
);

Mem_MemSpec_WaitRvalidMis_WaitGntSplit_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_rvalid_mis) && memspec_wait_gnt_split && $past(memspec_wait_rvalid_mis_inv)
    |->
    memspec_wait_gnt_split_inv
);

Mem_MemSpec_WaitRvalidMis_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis && memspec_step && memspec_wait_rvalid_mis_inv
    |->
    memspec_step_inv
);

Mem_MemSpec_WaitGntSplit_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_split_inv && memspec_wait_gnt_split
    |->
    (memspec_step) or ##1 (memspec_wait_gnt_split || ~memspec_pre)
);

Mem_MemSpec_WaitGntSplit_WaitGntSplit_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt_split) && memspec_wait_gnt_split && $past(memspec_wait_gnt_split_inv)
    |->
    memspec_wait_gnt_split_inv
);

Mem_MemSpec_WaitGntSplit_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_split && memspec_step && memspec_wait_gnt_split_inv
    |->
    memspec_step_inv
);

Mem_MemSpec_WaitGnt_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_inv && memspec_wait_gnt
    |->
    (memspec_step) or ##1 (memspec_wait_gnt || ~memspec_pre)
);

Mem_MemSpec_WaitGnt_WaitGnt_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt) && memspec_wait_gnt && $past(memspec_wait_gnt_inv)
    |->
    memspec_wait_gnt_inv
);

Mem_MemSpec_WaitGnt_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt && memspec_step && memspec_wait_gnt_inv
    |->
    memspec_step_inv
);

Mem_MemSpec_WaitGnt2_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt2_inv && memspec_wait_gnt2
    |->
    (memspec_step) or ##1 (memspec_wait_gnt2 || memspec_wait_resp || ~memspec_pre)
);

Mem_MemSpec_WaitGnt2_WaitGnt2_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt2) && memspec_wait_gnt2 && $past(memspec_wait_gnt2_inv)
    |->
    memspec_wait_gnt2_inv
);

Mem_MemSpec_WaitGnt2_WaitResp_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt2) && memspec_wait_resp && $past(memspec_wait_gnt2_inv)
    |->
    memspec_wait_resp_inv
);

Mem_MemSpec_WaitGnt2_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt2 && memspec_step && memspec_wait_gnt2_inv
    |->
    memspec_step_inv
);

Mem_MemSpec_WaitGntMis_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_mis_inv && memspec_wait_gnt_mis
    |->
    (0) or ##1 (memspec_wait_gnt_mis || memspec_wait_rvalid_mis || ~memspec_pre)
);

Mem_MemSpec_WaitGntMis_WaitGntMis_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt_mis) && memspec_wait_gnt_mis && $past(memspec_wait_gnt_mis_inv)
    |->
    memspec_wait_gnt_mis_inv
);

Mem_MemSpec_WaitGntMis_WaitRvalidMis_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt_mis) && memspec_wait_rvalid_mis && $past(memspec_wait_gnt_mis_inv)
    |->
    memspec_wait_rvalid_mis_inv
);

Mem_MemSpec_WaitRvalidMisGntsDone_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis_gnts_done_inv && memspec_wait_rvalid_mis_gnts_done
    |->
    (memspec_step) or ##1 (memspec_wait_rvalid_mis_gnts_done || ~memspec_pre)
);

Mem_MemSpec_WaitRvalidMisGntsDone_WaitRvalidMisGntsDone_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_rvalid_mis_gnts_done) && memspec_wait_rvalid_mis_gnts_done &&
    $past(memspec_wait_rvalid_mis_gnts_done_inv)
    |->
    memspec_wait_rvalid_mis_gnts_done_inv
);

Mem_MemSpec_WaitRvalidMisGntsDone_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis_gnts_done && memspec_step && memspec_wait_rvalid_mis_gnts_done_inv
    |->
    memspec_step_inv
);

Mem_MemSpec_WaitGnt1_Step: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt1_inv && memspec_wait_gnt1
    |->
    (memspec_step) or ##1 (memspec_wait_gnt1 || memspec_wait_gnt2 || ~memspec_pre)
);

Mem_MemSpec_WaitGnt1_WaitGnt1_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt1) && memspec_wait_gnt1 && $past(memspec_wait_gnt1_inv)
    |->
    memspec_wait_gnt1_inv
);

Mem_MemSpec_WaitGnt1_WaitGnt2_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    $past(memspec_wait_gnt1) && memspec_wait_gnt2 && $past(memspec_wait_gnt1_inv)
    |->
    memspec_wait_gnt2_inv
);

Mem_MemSpec_WaitGnt1_Step_Inv: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt1 && memspec_step && memspec_wait_gnt1_inv
    |->
    memspec_step_inv
);

IRQ_PC: assert property (wbexc_handling_irq |-> pc_match);

IRQ_CSR: assert property (wbexc_handling_irq |-> csrs_match);

Illegal_Fast: assert property (
    wbexc_illegal & wbexc_finishing & ~wbexc_fetch_err & (`IS_CSR -> wbexc_is_checkable_csr)
    |->
    $past(instr_will_progress)
);

FetchErr_Fast: assert property (wbexc_finishing & wbexc_fetch_err |-> $past(instr_will_progress));

`endif

`ifndef REMOVE_SLICE_12
Base_I_NoErr: assert property (
    (`IS_ADDI | `IS_SLTI | `IS_SLTIU | `IS_XORI | `IS_ORI | `IS_ANDI) &&
    finishing_executed & ~wbexc_illegal
    |->
    ~wbexc_err
);

Base_R_NoErr: assert property (
    (
        `IS_ADD | `IS_SUB | `IS_SLL | `IS_SLT | `IS_SLTU |
        `IS_XOR | `IS_SRL | `IS_SRA | `IS_OR | `IS_AND
    )
    &&
    finishing_executed & ~wbexc_illegal
    |->
    ~wbexc_err
);

Base_Shift_NoErr: assert property (
    `IS_SHIFTIOP && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

Base_Lui_NoErr: assert property (`IS_LUI && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

Base_Fence_NoErr: assert property (`IS_FENCE && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

Base_FenceI_NoErr: assert property (
    `IS_FENCEI && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

Cheri_CGet_NoErr: assert property (`IS_CGET && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

Cheri_CSeal_NoErr: assert property (
    `IS_CSEAL_ANDPERM && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

Cheri_CAddr_NoErr: assert property (
    `IS_CSETADDRx && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

Cheri_CBounds_NoErr: assert property (
    `IS_CSETBOUNDSx && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

Cheri_CMov_NoErr: assert property (
    `IS_CCLRSUBMOV && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

Cheri_AUIC_NoErr: assert property (`IS_AUIC && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

Cheri_CCmp_NoErr: assert property (`IS_CCMP && finishing_executed & ~wbexc_illegal |-> ~wbexc_err);

Cheri_CHigh_NoErr: assert property (
    `IS_CHIGH && finishing_executed & ~wbexc_illegal |-> ~wbexc_err
);

CheriJump_CJal_Addr: assert property (
    `IS_CJAL && finishing_executed & ~wbexc_illegal |-> addr_match
);

CheriJump_CJal_Data: assert property (
    `IS_CJAL && finishing_executed & ~wbexc_illegal |-> data_match
);

CheriJump_CJal_CSR: assert property (
    `IS_CJAL && finishing_executed & ~wbexc_illegal |-> csrs_match
);

CheriJump_CJal_PC: assert property (`IS_CJAL && finishing_executed & ~wbexc_illegal |-> pc_match);

CheriJump_CJalR_Addr: assert property (
    `IS_CJALR && finishing_executed & ~wbexc_illegal |-> addr_match
);

CheriJump_CJalR_Data: assert property (
    `IS_CJALR && finishing_executed & ~wbexc_illegal |-> data_match
);

CheriJump_CJalR_CSR: assert property (
    `IS_CJALR && finishing_executed & ~wbexc_illegal |-> csrs_match
);

CheriJump_CJalR_PC: assert property (`IS_CJALR && finishing_executed & ~wbexc_illegal |-> pc_match);

CheriCSR_Addr: assert property (
    `IS_CSPECIALRW && finishing_executed & ~wbexc_illegal |-> addr_match
);

CheriCSR_Data: assert property (
    `IS_CSPECIALRW && finishing_executed & ~wbexc_illegal |-> data_match
);

CheriCSR_CSR: assert property (
    `IS_CSPECIALRW && finishing_executed & ~wbexc_illegal |-> csrs_match
);

CheriCSR_PC: assert property (`IS_CSPECIALRW && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_Mul_Addr: assert property (`IS_MUL && finishing_executed & ~wbexc_illegal |-> addr_match);

MType_Mul_Data: assert property (`IS_MUL && finishing_executed & ~wbexc_illegal |-> data_match);

MType_Mul_CSR: assert property (`IS_MUL && finishing_executed & ~wbexc_illegal |-> csrs_match);

MType_Mul_PC: assert property (`IS_MUL && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_MulH_Addr: assert property (`IS_MULH && finishing_executed & ~wbexc_illegal |-> addr_match);

MType_MulH_Data: assert property (`IS_MULH && finishing_executed & ~wbexc_illegal |-> data_match);

MType_MulH_CSR: assert property (`IS_MULH && finishing_executed & ~wbexc_illegal |-> csrs_match);

MType_MulH_PC: assert property (`IS_MULH && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_MulHSH_Addr: assert property (
    `IS_MULHSH && finishing_executed & ~wbexc_illegal |-> addr_match
);

MType_MulHSH_Data: assert property (
    `IS_MULHSH && finishing_executed & ~wbexc_illegal |-> data_match
);

MType_MulHSH_CSR: assert property (
    `IS_MULHSH && finishing_executed & ~wbexc_illegal |-> csrs_match
);

MType_MulHSH_PC: assert property (`IS_MULHSH && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_MulHU_Addr: assert property (`IS_MULHU && finishing_executed & ~wbexc_illegal |-> addr_match);

MType_MulHU_Data: assert property (`IS_MULHU && finishing_executed & ~wbexc_illegal |-> data_match);

MType_MulHU_CSR: assert property (`IS_MULHU && finishing_executed & ~wbexc_illegal |-> csrs_match);

MType_MulHU_PC: assert property (`IS_MULHU && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_Div_Addr: assert property (`IS_DIV && finishing_executed & ~wbexc_illegal |-> addr_match);

MType_Div_Data: assert property (`IS_DIV && finishing_executed & ~wbexc_illegal |-> data_match);

MType_Div_CSR: assert property (`IS_DIV && finishing_executed & ~wbexc_illegal |-> csrs_match);

MType_Div_PC: assert property (`IS_DIV && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_DivU_Addr: assert property (`IS_DIVU && finishing_executed & ~wbexc_illegal |-> addr_match);

MType_DivU_Data: assert property (`IS_DIVU && finishing_executed & ~wbexc_illegal |-> data_match);

MType_DivU_CSR: assert property (`IS_DIVU && finishing_executed & ~wbexc_illegal |-> csrs_match);

MType_DivU_PC: assert property (`IS_DIVU && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_Rem_Addr: assert property (`IS_REM && finishing_executed & ~wbexc_illegal |-> addr_match);

MType_Rem_Data: assert property (`IS_REM && finishing_executed & ~wbexc_illegal |-> data_match);

MType_Rem_CSR: assert property (`IS_REM && finishing_executed & ~wbexc_illegal |-> csrs_match);

MType_Rem_PC: assert property (`IS_REM && finishing_executed & ~wbexc_illegal |-> pc_match);

MType_RemU_Addr: assert property (`IS_REMU && finishing_executed & ~wbexc_illegal |-> addr_match);

MType_RemU_Data: assert property (`IS_REMU && finishing_executed & ~wbexc_illegal |-> data_match);

MType_RemU_CSR: assert property (`IS_REMU && finishing_executed & ~wbexc_illegal |-> csrs_match);

MType_RemU_PC: assert property (`IS_REMU && finishing_executed & ~wbexc_illegal |-> pc_match);

CSR_Addr_NotErr: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    addr_match
);

CSR_Data_NotErr: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    data_match
);

CSR_CSR_NotErr: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    csrs_match
);

CSR_PC_NotErr: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    pc_match
);

CSR_Addr_Err: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    addr_match
);

CSR_Data_Err: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    data_match
);

CSR_CSR_Err: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    csrs_match
);

CSR_PC_Err: assert property (
    `IS_CSR & wbexc_is_checkable_csr && finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    pc_match
);

BType_BInd_Initial: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_initial
    |->
    bind_stall || bind_oma || bind_progress
);

BType_BInd_Initial_Stall: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_stall && bind_initial
    |->
    bind_stall_inv
);

BType_BInd_Initial_Oma: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_oma && bind_initial
    |->
    bind_oma_inv
);

BType_BInd_Initial_Progress: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_progress && bind_initial
    |->
    bind_progress_inv
);

BType_BInd_Oma_Step_0: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill &&
    bind_oma_inv && bind_oma && ~`CR.branch_decision
    |->
    (0) or ##1 (bind_oma || bind_progress || ~bind_pre)
);

BType_BInd_Oma_Oma_Inv_0: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && $past(bind_oma) &&
    bind_oma && $past(bind_oma_inv) && ~`CR.branch_decision
    |->
    bind_oma_inv
);

BType_BInd_Oma_Progress_Inv_0: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && $past(bind_oma) &&
    bind_progress && $past(bind_oma_inv) && ~`CR.branch_decision
    |->
    bind_progress_inv
);

BType_BInd_Oma_Step_1: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill &&
    bind_oma_inv && bind_oma && `CR.branch_decision
    |->
    (0) or ##1 (bind_oma || bind_progress || ~bind_pre)
);

BType_BInd_Oma_Oma_Inv_1: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && $past(bind_oma) &&
    bind_oma && $past(bind_oma_inv) && `CR.branch_decision
    |->
    bind_oma_inv
);

BType_BInd_Oma_Progress_Inv_1: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && $past(bind_oma) &&
    bind_progress && $past(bind_oma_inv) && `CR.branch_decision
    |->
    bind_progress_inv
);

BType_BInd_Stall_Step: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_stall_inv && bind_stall
    |->
    (0) or ##1 (bind_stall || bind_oma || bind_progress || ~bind_pre)
);

BType_BInd_Stall_Stall_Inv: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill &&
    $past(bind_stall) && bind_stall && $past(bind_stall_inv)
    |->
    bind_stall_inv
);

BType_BInd_Stall_Oma_Inv: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill &&
    $past(bind_stall) && bind_oma && $past(bind_stall_inv)
    |->
    bind_oma_inv
);

BType_BInd_Stall_Progress_Inv: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill &&
    $past(bind_stall) && bind_progress && $past(bind_stall_inv)
    |->
    bind_progress_inv
);

JAL_JInd_Initial: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_initial
    |->
    jind_stall || jind_oma || jind_progress
);

JAL_JInd_Initial_Stall: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_stall && jind_initial
    |->
    jind_stall_inv
);

JAL_JInd_Initial_Oma: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_oma && jind_initial
    |->
    jind_oma_inv
);

JAL_JInd_Initial_Progress: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_progress && jind_initial
    |->
    jind_progress_inv
);

JAL_JInd_Stall_Step: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_stall_inv && jind_stall
    |->
    (0) or ##1 (jind_stall || jind_oma || jind_progress || ~jind_pre)
);

JAL_JInd_Stall_Stall_Inv: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill &&
    $past(jind_stall) && jind_stall && $past(jind_stall_inv)
    |->
    jind_stall_inv
);

JAL_JInd_Stall_Oma_Inv: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill &&
    $past(jind_stall) && jind_oma && $past(jind_stall_inv)
    |->
    jind_oma_inv
);

JAL_JInd_Stall_Progress_Inv: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill &&
    $past(jind_stall) && jind_progress && $past(jind_stall_inv)
    |->
    jind_progress_inv
);

JAL_JInd_Oma_Step: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_oma_inv && jind_oma
    |->
    (0) or ##1 (jind_oma || jind_progress || ~jind_pre)
);

JAL_JInd_Oma_Oma_Inv: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill &&
    $past(jind_oma) && jind_oma && $past(jind_oma_inv)
    |->
    jind_oma_inv
);

JAL_JInd_Oma_Progress_Inv: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill &&
    $past(jind_oma) && jind_progress && $past(jind_oma_inv)
    |->
    jind_progress_inv
);

Special_ECall_Addr: assert property (
    `IS_ECALL && finishing_executed & ~wbexc_illegal |-> addr_match
);

Special_ECall_Data: assert property (
    `IS_ECALL && finishing_executed & ~wbexc_illegal |-> data_match
);

Special_ECall_CSR: assert property (
    `IS_ECALL && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Special_ECall_PC: assert property (`IS_ECALL && finishing_executed & ~wbexc_illegal |-> pc_match);

Special_EBreak_Addr: assert property (
    `IS_EBREAK && finishing_executed & ~wbexc_illegal |-> addr_match
);

Special_EBreak_Data: assert property (
    `IS_EBREAK && finishing_executed & ~wbexc_illegal |-> data_match
);

Special_EBreak_CSR: assert property (
    `IS_EBREAK && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Special_EBreak_PC: assert property (`IS_EBREAK && finishing_executed & ~wbexc_illegal |-> pc_match);

Special_MRet_Addr: assert property (`IS_MRET && finishing_executed & ~wbexc_illegal |-> addr_match);

Special_MRet_Data: assert property (`IS_MRET && finishing_executed & ~wbexc_illegal |-> data_match);

Special_MRet_CSR: assert property (`IS_MRET && finishing_executed & ~wbexc_illegal |-> csrs_match);

Special_MRet_PC: assert property (`IS_MRET && finishing_executed & ~wbexc_illegal |-> pc_match);

Special_WFI_Addr: assert property (`IS_WFI && finishing_executed & ~wbexc_illegal |-> addr_match);

Special_WFI_Data: assert property (`IS_WFI && finishing_executed & ~wbexc_illegal |-> data_match);

Special_WFI_CSR: assert property (`IS_WFI && finishing_executed & ~wbexc_illegal |-> csrs_match);

Special_WFI_PC: assert property (`IS_WFI && finishing_executed & ~wbexc_illegal |-> pc_match);

Mem_CapFsm_WaitResp: assert property (
    ex_is_mem_cap_instr &&
    (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) && capfsm_wait_resp
    |->
    capfsm_wait_resp_inv
);

Mem_CapFsm_Step: assert property (
    ex_is_mem_cap_instr &&
    (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) && capfsm_step
    |->
    capfsm_step_inv
);

Mem_CapFsm_IdleActive: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_idle_active
    |->
    capfsm_idle_active_inv
);

Mem_CapFsm_WaitGnt1: assert property (
    ex_is_mem_cap_instr &&
    (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) && capfsm_wait_gnt1
    |->
    capfsm_wait_gnt1_inv
);

Mem_CapFsm_WaitGnt2: assert property (
    ex_is_mem_cap_instr &&
    (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) && capfsm_wait_gnt2
    |->
    capfsm_wait_gnt2_inv
);

Mem_CapFsm_WaitGnt2Done: assert property (
    ex_is_mem_cap_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    capfsm_wait_gnt2_done
    |->
    capfsm_wait_gnt2_done_inv
);

Mem_MemSpec_IdleActive_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_idle_active
    |->
    (0 || memspec_initial) or (0 && $past(memspec_pre))
);

Mem_MemSpec_WaitRvalidMis_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis
    |->
    (0) or (
        (
            $past(memspec_idle_active) || $past(memspec_wait_rvalid_mis) ||
            $past(memspec_wait_gnt_mis)
        )
        &&
        $past(memspec_pre)
    )
);

Mem_MemSpec_WaitGntSplit_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_split
    |->
    (0) or
    (($past(memspec_wait_rvalid_mis) || $past(memspec_wait_gnt_split)) && $past(memspec_pre))
);

Mem_MemSpec_WaitGnt_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt
    |->
    (0) or (($past(memspec_idle_active) || $past(memspec_wait_gnt)) && $past(memspec_pre))
);

Mem_MemSpec_WaitGnt2_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt2
    |->
    (0) or (
        ($past(memspec_idle_active) || $past(memspec_wait_gnt2) || $past(memspec_wait_gnt1)) &&
        $past(memspec_pre)
    )
);

Mem_MemSpec_WaitResp_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_resp
    |->
    (0) or (($past(memspec_wait_gnt2) || $past(memspec_wait_resp)) && $past(memspec_pre))
);

Mem_MemSpec_WaitGntMis_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_mis
    |->
    (0) or (($past(memspec_idle_active) || $past(memspec_wait_gnt_mis)) && $past(memspec_pre))
);

Mem_MemSpec_WaitRvalidMisGntsDone_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis_gnts_done
    |->
    (0) or
    (
        ($past(memspec_wait_rvalid_mis) || $past(memspec_wait_rvalid_mis_gnts_done)) &&
        $past(memspec_pre)
    )
);

Mem_MemSpec_WaitGnt1_Rev: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt1
    |->
    (0) or (($past(memspec_idle_active) || $past(memspec_wait_gnt1)) && $past(memspec_pre))
);

Mem_MemSpec_Step_Rev: assert property (
    ex_is_mem_instr &&
    (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) && memspec_step
    |->
    (
        memspec_wait_gnt2 || memspec_wait_resp || memspec_idle_active || memspec_wait_rvalid_mis ||
        memspec_wait_gnt_split || memspec_wait_gnt ||
        memspec_wait_rvalid_mis_gnts_done || memspec_wait_gnt1
    ) or (0 && $past(memspec_pre))
);

Illegal_Addr: assert property (
    wbexc_illegal & wbexc_finishing & ~wbexc_fetch_err & (`IS_CSR -> wbexc_is_checkable_csr)
    |->
    addr_match
);

Illegal_Data: assert property (
    wbexc_illegal & wbexc_finishing & ~wbexc_fetch_err & (`IS_CSR -> wbexc_is_checkable_csr)
    |->
    data_match
);

Illegal_CSR: assert property (
    wbexc_illegal & wbexc_finishing & ~wbexc_fetch_err & (`IS_CSR -> wbexc_is_checkable_csr)
    |->
    csrs_match
);

Illegal_PC: assert property (
    wbexc_illegal & wbexc_finishing & ~wbexc_fetch_err & (`IS_CSR -> wbexc_is_checkable_csr)
    |->
    pc_match
);

FetchErr_Addr: assert property (wbexc_finishing & wbexc_fetch_err |-> addr_match);

FetchErr_Data: assert property (wbexc_finishing & wbexc_fetch_err |-> data_match);

FetchErr_CSR: assert property (wbexc_finishing & wbexc_fetch_err |-> csrs_match);

FetchErr_PC: assert property (wbexc_finishing & wbexc_fetch_err |-> pc_match);

`endif

`ifndef REMOVE_SLICE_13
Base_I_Addr: assert property (
    (`IS_ADDI | `IS_SLTI | `IS_SLTIU | `IS_XORI | `IS_ORI | `IS_ANDI) &&
    finishing_executed & ~wbexc_illegal
    |->
    addr_match
);

Base_I_Data: assert property (
    (`IS_ADDI | `IS_SLTI | `IS_SLTIU | `IS_XORI | `IS_ORI | `IS_ANDI) &&
    finishing_executed & ~wbexc_illegal
    |->
    data_match
);

Base_I_CSR: assert property (
    (`IS_ADDI | `IS_SLTI | `IS_SLTIU | `IS_XORI | `IS_ORI | `IS_ANDI) &&
    finishing_executed & ~wbexc_illegal
    |->
    csrs_match
);

Base_I_PC: assert property (
    (`IS_ADDI | `IS_SLTI | `IS_SLTIU | `IS_XORI | `IS_ORI | `IS_ANDI) &&
    finishing_executed & ~wbexc_illegal
    |->
    pc_match
);

Base_R_Addr: assert property (
    (
        `IS_ADD | `IS_SUB | `IS_SLL | `IS_SLT | `IS_SLTU |
        `IS_XOR | `IS_SRL | `IS_SRA | `IS_OR | `IS_AND
    )
    &&
    finishing_executed & ~wbexc_illegal
    |->
    addr_match
);

Base_R_Data: assert property (
    (
        `IS_ADD | `IS_SUB | `IS_SLL | `IS_SLT | `IS_SLTU |
        `IS_XOR | `IS_SRL | `IS_SRA | `IS_OR | `IS_AND
    )
    &&
    finishing_executed & ~wbexc_illegal
    |->
    data_match
);

Base_R_CSR: assert property (
    (
        `IS_ADD | `IS_SUB | `IS_SLL | `IS_SLT | `IS_SLTU |
        `IS_XOR | `IS_SRL | `IS_SRA | `IS_OR | `IS_AND
    )
    &&
    finishing_executed & ~wbexc_illegal
    |->
    csrs_match
);

Base_R_PC: assert property (
    (
        `IS_ADD | `IS_SUB | `IS_SLL | `IS_SLT | `IS_SLTU |
        `IS_XOR | `IS_SRL | `IS_SRA | `IS_OR | `IS_AND
    )
    &&
    finishing_executed & ~wbexc_illegal
    |->
    pc_match
);

Base_Shift_Addr: assert property (
    `IS_SHIFTIOP && finishing_executed & ~wbexc_illegal |-> addr_match
);

Base_Shift_Data: assert property (
    `IS_SHIFTIOP && finishing_executed & ~wbexc_illegal |-> data_match
);

Base_Shift_CSR: assert property (
    `IS_SHIFTIOP && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Base_Shift_PC: assert property (`IS_SHIFTIOP && finishing_executed & ~wbexc_illegal |-> pc_match);

Base_Lui_Addr: assert property (`IS_LUI && finishing_executed & ~wbexc_illegal |-> addr_match);

Base_Lui_Data: assert property (`IS_LUI && finishing_executed & ~wbexc_illegal |-> data_match);

Base_Lui_CSR: assert property (`IS_LUI && finishing_executed & ~wbexc_illegal |-> csrs_match);

Base_Lui_PC: assert property (`IS_LUI && finishing_executed & ~wbexc_illegal |-> pc_match);

Base_Fence_Addr: assert property (`IS_FENCE && finishing_executed & ~wbexc_illegal |-> addr_match);

Base_Fence_Data: assert property (`IS_FENCE && finishing_executed & ~wbexc_illegal |-> data_match);

Base_Fence_CSR: assert property (`IS_FENCE && finishing_executed & ~wbexc_illegal |-> csrs_match);

Base_Fence_PC: assert property (`IS_FENCE && finishing_executed & ~wbexc_illegal |-> pc_match);

Base_FenceI_Addr: assert property (
    `IS_FENCEI && finishing_executed & ~wbexc_illegal |-> addr_match
);

Base_FenceI_Data: assert property (
    `IS_FENCEI && finishing_executed & ~wbexc_illegal |-> data_match
);

Base_FenceI_CSR: assert property (`IS_FENCEI && finishing_executed & ~wbexc_illegal |-> csrs_match);

Base_FenceI_PC: assert property (`IS_FENCEI && finishing_executed & ~wbexc_illegal |-> pc_match);

Cheri_CGet_Addr: assert property (`IS_CGET && finishing_executed & ~wbexc_illegal |-> addr_match);

Cheri_CGet_Data: assert property (`IS_CGET && finishing_executed & ~wbexc_illegal |-> data_match);

Cheri_CGet_CSR: assert property (`IS_CGET && finishing_executed & ~wbexc_illegal |-> csrs_match);

Cheri_CGet_PC: assert property (`IS_CGET && finishing_executed & ~wbexc_illegal |-> pc_match);

Cheri_CSeal_Addr: assert property (
    `IS_CSEAL_ANDPERM && finishing_executed & ~wbexc_illegal |-> addr_match
);

Cheri_CSeal_Data: assert property (
    `IS_CSEAL_ANDPERM && finishing_executed & ~wbexc_illegal |-> data_match
);

Cheri_CSeal_CSR: assert property (
    `IS_CSEAL_ANDPERM && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Cheri_CSeal_PC: assert property (
    `IS_CSEAL_ANDPERM && finishing_executed & ~wbexc_illegal |-> pc_match
);

Cheri_CAddr_Addr: assert property (
    `IS_CSETADDRx && finishing_executed & ~wbexc_illegal |-> addr_match
);

Cheri_CAddr_Data: assert property (
    `IS_CSETADDRx && finishing_executed & ~wbexc_illegal |-> data_match
);

Cheri_CAddr_CSR: assert property (
    `IS_CSETADDRx && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Cheri_CAddr_PC: assert property (`IS_CSETADDRx && finishing_executed & ~wbexc_illegal |-> pc_match);

Cheri_CBounds_Addr: assert property (
    `IS_CSETBOUNDSx && finishing_executed & ~wbexc_illegal |-> addr_match
);

Cheri_CBounds_Data: assert property (
    `IS_CSETBOUNDSx && finishing_executed & ~wbexc_illegal |-> data_match
);

Cheri_CBounds_CSR: assert property (
    `IS_CSETBOUNDSx && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Cheri_CBounds_PC: assert property (
    `IS_CSETBOUNDSx && finishing_executed & ~wbexc_illegal |-> pc_match
);

Cheri_CMov_Addr: assert property (
    `IS_CCLRSUBMOV && finishing_executed & ~wbexc_illegal |-> addr_match
);

Cheri_CMov_Data: assert property (
    `IS_CCLRSUBMOV && finishing_executed & ~wbexc_illegal |-> data_match
);

Cheri_CMov_CSR: assert property (
    `IS_CCLRSUBMOV && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Cheri_CMov_PC: assert property (`IS_CCLRSUBMOV && finishing_executed & ~wbexc_illegal |-> pc_match);

Cheri_AUIC_Addr: assert property (`IS_AUIC && finishing_executed & ~wbexc_illegal |-> addr_match);

Cheri_AUIC_Data: assert property (`IS_AUIC && finishing_executed & ~wbexc_illegal |-> data_match);

Cheri_AUIC_CSR: assert property (`IS_AUIC && finishing_executed & ~wbexc_illegal |-> csrs_match);

Cheri_AUIC_PC: assert property (`IS_AUIC && finishing_executed & ~wbexc_illegal |-> pc_match);

Cheri_CCmp_Addr: assert property (`IS_CCMP && finishing_executed & ~wbexc_illegal |-> addr_match);

Cheri_CCmp_Data: assert property (`IS_CCMP && finishing_executed & ~wbexc_illegal |-> data_match);

Cheri_CCmp_CSR: assert property (`IS_CCMP && finishing_executed & ~wbexc_illegal |-> csrs_match);

Cheri_CCmp_PC: assert property (`IS_CCMP && finishing_executed & ~wbexc_illegal |-> pc_match);

Cheri_CHigh_Addr: assert property (`IS_CHIGH && finishing_executed & ~wbexc_illegal |-> addr_match);

Cheri_CHigh_Data: assert property (`IS_CHIGH && finishing_executed & ~wbexc_illegal |-> data_match);

Cheri_CHigh_CSR: assert property (`IS_CHIGH && finishing_executed & ~wbexc_illegal |-> csrs_match);

Cheri_CHigh_PC: assert property (`IS_CHIGH && finishing_executed & ~wbexc_illegal |-> pc_match);

BType_BInd_Stall_Rev: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_stall
    |->
    (0 || bind_initial) or ($past(bind_stall) && $past(bind_pre))
);

BType_BInd_Oma_Rev_0: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_oma && ~`CR.branch_decision
    |->
    (0 || bind_initial) or (($past(bind_stall) || $past(bind_oma)) && $past(bind_pre))
);

BType_BInd_Oma_Rev_1: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_oma && `CR.branch_decision
    |->
    (0 || bind_initial) or (($past(bind_stall) || $past(bind_oma)) && $past(bind_pre))
);

BType_BInd_Progress_Rev: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_progress
    |->
    (0 || bind_initial) or (($past(bind_stall) || $past(bind_oma)) && $past(bind_pre))
);

JAL_JInd_Stall_Rev: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_stall
    |->
    (0 || jind_initial) or ($past(jind_stall) && $past(jind_pre))
);

JAL_JInd_Oma_Rev: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_oma
    |->
    (0 || jind_initial) or (($past(jind_stall) || $past(jind_oma)) && $past(jind_pre))
);

JAL_JInd_Progress_Rev: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_progress
    |->
    (0 || jind_initial) or (($past(jind_stall) || $past(jind_oma)) && $past(jind_pre))
);

Mem_MemSpec_WaitResp: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_resp
    |->
    memspec_wait_resp_inv
);

Mem_MemSpec_IdleActive: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_idle_active
    |->
    memspec_idle_active_inv
);

Mem_MemSpec_WaitRvalidMis: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis
    |->
    memspec_wait_rvalid_mis_inv
);

Mem_MemSpec_WaitGntSplit: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_split
    |->
    memspec_wait_gnt_split_inv
);

Mem_MemSpec_WaitGnt: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt
    |->
    memspec_wait_gnt_inv
);

Mem_MemSpec_WaitGnt2: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt2
    |->
    memspec_wait_gnt2_inv
);

Mem_MemSpec_WaitGntMis: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt_mis
    |->
    memspec_wait_gnt_mis_inv
);

Mem_MemSpec_WaitRvalidMisGntsDone: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_rvalid_mis_gnts_done
    |->
    memspec_wait_rvalid_mis_gnts_done_inv
);

Mem_MemSpec_WaitGnt1: assert property (
    ex_is_mem_instr && (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) &&
    memspec_wait_gnt1
    |->
    memspec_wait_gnt1_inv
);

Mem_MemSpec_Step: assert property (
    ex_is_mem_instr &&
    (`LSU.ls_fsm_cs != `LSU.IDLE || (`CR.lsu_req && ~`CR.lsu_cheri_err)) && memspec_step
    |->
    memspec_step_inv
);

`endif

`ifndef REMOVE_SLICE_14
BType_BInd_Stall: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_stall |-> bind_stall_inv
);

BType_BInd_Oma: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_oma |-> bind_oma_inv
);

BType_BInd_Progress: assert property (
    `CR.instr_valid_id & ex_is_btype & ~ex_err & ~ex_kill && bind_progress |-> bind_progress_inv
);

JAL_JInd_Stall: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_stall |-> jind_stall_inv
);

JAL_JInd_Oma: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_oma |-> jind_oma_inv
);

JAL_JInd_Progress: assert property (
    `CR.instr_valid_id & `IDC.jump_set_i & ~ex_err & ~ex_kill && jind_progress |-> jind_progress_inv
);

Mem_LSULateRespFinishing: assert property (late_resp |-> wbexc_finishing || wbexc_err);

Mem_LSUEarlyRequestSplit: assert property (early_resp |-> has_snd_req);

Mem_LSUHold: assert property (
    data_req_o & ~data_gnt_i |=> data_addr_o == $past(data_addr_o) && data_we_o == $past(data_we_o)
);

Mem_LSUHoldWrite: assert property (
    data_req_o & ~data_gnt_i & data_we_o
    |=>
    data_be_o == $past(data_be_o) && data_wdata_o == $past(data_wdata_o)
);

Mem_LSUMaxTwoReqs: assert property (mem_gnt_snd_q |-> ~data_gnt_i);

Mem_LSU2ndReqStep: assert property (
    data_req_o & $past(data_gnt_i) & ~$past(instr_will_progress)
    |->
    data_we_o == $past(data_we_o) && data_addr_o == $past(data_addr_o) + 4
);

Mem_LSUInternalHold: assert property (
    `LSU.data_req_o && ~data_gnt_i && ~`LSU.pmp_err_q |=> $stable(data_addr_o)
);

Mem_NoMem: assert property (~ex_is_mem_instr & instr_will_progress |-> ~mem_gnt_fst_d);

Mem_AltLSUVeryEarly: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE & spec_post_wX_en & ~lsu_had_first_resp
    |->
    alas(spec_post_wX, revoke(alt_lsu_very_early_res, spec_mem_revoke_en & spec_mem_revoke))
);

Mem_ExceptionMaintain: assert property (
    `LSU.lsu_req_i && ~spec_mem_read & ~spec_mem_write |-> instr_will_progress ##1 wbexc_err
);

Mem_FastErrSignalCap: assert property (
    finishing_executed & ~wbexc_illegal & wbexc_err & (`IS_LOADCAPIMM | `IS_STORECAPIMM)
    |->
    ($past(`CE.is_load_cap, 2) | $past(`CE.is_store_cap, 2)) &
    $past(`CE.cheri_lsu_err, 2) & $past(`CE.cheri_exec_id_i, 2)
);

Mem_FastErrSignalNoCap: assert property (
    finishing_executed & ~wbexc_illegal & wbexc_err &
    wbexc_is_mem_instr & ~(`IS_LOADCAPIMM | `IS_STORECAPIMM)
    |->
    $past(`CE.rv32_lsu_req_i, 2) & $past(`CE.rv32_lsu_err, 2)
);

Mem_FinalCapAltLSUVeryEarly: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE && ex_is_clc && ~lsu_had_first_resp
    |->
    onlySealingPerms(revoke(spec_mem_read_cap, `LSU.resp_lc_clrperm_q[3]))==
    onlySealingPerms(alt_lsu_very_early_res)
);

`endif

`ifndef REMOVE_SLICE_15
BType_NoBranch: assert property (
    instr_will_progress & ex_is_btype & ~ex_err
    |->
    ~`CR.branch_decision |-> spec_post_pc == pre_nextpc
);

BType_Branch: assert property (
    instr_will_progress & ex_is_btype & ~ex_err
    |->
    `CR.branch_decision |-> spec_post_pc == `CR.branch_target_ex
);

JAL_Branch: assert property (
    instr_will_progress & `IDC.jump_set_i & ~ex_err
    |->
    spec_post_pc[31:1] == `CR.branch_target_ex[31:1]
);

Mem_PCMaintainEx: assert property (
    `ID.instr_valid_i & ex_is_mem_instr & ~ex_err & ~ex_kill |-> pre_nextpc == post_pc
);

Mem_AltLSUEarly: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE & spec_post_wX_en & lsu_had_first_resp
    |->
    alas(spec_post_wX, revoke(alt_lsu_early_res, spec_mem_revoke_en & spec_mem_revoke))
);

Mem_ClrPerm: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE |-> `CE.cheri_lsu_lc_clrperm == `LSU.resp_lc_clrperm_q
);

Mem_FinalCapAltLSUEarly: assert property (
    `LSU.ls_fsm_cs != `LSU.IDLE && ex_is_clc && lsu_had_first_resp
    |->
    onlySealingPerms(revoke(spec_mem_read_cap, `LSU.resp_lc_clrperm_q[3]))==
    onlySealingPerms(alt_lsu_early_res)
);

`endif

`ifndef REMOVE_SLICE_16
BType_Addr: assert property (`IS_BTYPE && finishing_executed & ~wbexc_illegal |-> addr_match);

BType_Data: assert property (`IS_BTYPE && finishing_executed & ~wbexc_illegal |-> data_match);

BType_CSR: assert property (`IS_BTYPE && finishing_executed & ~wbexc_illegal |-> csrs_match);

BType_PC: assert property (`IS_BTYPE && finishing_executed & ~wbexc_illegal |-> pc_match);

JAL_Addr: assert property (`IS_JAL && finishing_executed & ~wbexc_illegal |-> addr_match);

JAL_Data: assert property (`IS_JAL && finishing_executed & ~wbexc_illegal |-> data_match);

JAL_CSR: assert property (`IS_JAL && finishing_executed & ~wbexc_illegal |-> csrs_match);

JAL_PC: assert property (`IS_JAL && finishing_executed & ~wbexc_illegal |-> pc_match);

Mem_AltLSU: assert property (
    wbexc_exists & wbexc_is_load_instr & ~wbexc_err & wbexc_post_wX_en
    |->
    alas(wbexc_post_wX, revoke(alt_lsu_late_res, wbexc_spec_mem_revoke_en & wbexc_spec_mem_revoke))
);

Mem_CSRMaintain: assert property (wbexc_exists & wbexc_is_mem_instr & ~wbexc_err |-> csrs_match);

Mem_CSRNoChange: assert property (
    wbexc_exists & wbexc_is_mem_instr & ~wbexc_err |-> csrs_didnt_change
);

Mem_PCNoChangeNoBranch: assert property (
    wbexc_exists & wbexc_is_mem_instr & ~wbexc_err & ~ex_has_branched_d
    |->
    (`ID.instr_valid_i ? pre_pc : `CR.pc_if) == wbexc_dut_post_pc
);

Mem_PCNoChangeBranch: assert property (
    wbexc_exists & wbexc_is_mem_instr & ~wbexc_err & ex_has_branched_d
    |->
    pre_pc == wbexc_dut_post_pc
);

Mem_PCMaintainWb: assert property (
    wbexc_exists & wbexc_is_mem_instr & ~wbexc_err |-> wbexc_post_pc == wbexc_dut_post_pc
);

Mem_LoadAddrMaintain: assert property (
    wbexc_exists & wbexc_is_load_instr & ~wbexc_err
    |->
    wbexc_post_wX_en && `WBG.rf_waddr_wb_q == wbexc_post_wX_addr
);

Mem_StoreAddrMaintain: assert property (
    wbexc_exists & wbexc_is_store_instr & ~wbexc_err
    |->
    ~wbexc_post_wX_en & ~`WBG.rf_we_wb_q & ~`WBG.cheri_rf_we_q
);

Mem_ReadOrWrite: assert property (
    `ID.instr_valid_i & ex_is_mem_instr & ~ex_kill & (spec_mem_read | spec_mem_write)
    |->
    ~`IDC.illegal_insn_d
);

Mem_RevokeEnCheckPasses: assert property (
    wbexc_exists & `IS_LOADCAPIMM & ~wbexc_err |->wbexc_spec_mem_revoke_en == (
        wbexc_spec_mem_read_cap.tag &~`LSU.resp_lc_clrperm_q[3] &~(
            wbexc_spec_mem_read_cap.permit_seal | wbexc_spec_mem_read_cap.permit_unseal |
            wbexc_spec_mem_read_cap.perm_user0
        )
    )
);

Mem_RevokeAddrMatch: assert property (
    wbexc_exists & `IS_LOADCAPIMM & wbexc_spec_mem_revoke_en
    |->
    wbexc_spec_mem_revoke_addr == (wbexc_spec_mem_read_cap_bounds.base & ~32'b111)
);

Mem_RevokeRangeCheck: assert property (
    wbexc_exists & `IS_LOADCAPIMM & wbexc_spec_mem_revoke_en & wbexc_spec_mem_revoke
    |->
    (wbexc_spec_mem_revoke_addr - HeapBase) >> 8 < TSMapSize
);

Mem_FinalCapAltLSU: assert property (
    wbexc_exists & ~wbexc_err & `IS_LOADCAPIMM
    |->
    onlySealingPerms(revoke(wbexc_spec_mem_read_cap, `LSU.resp_lc_clrperm_q[3]))==
    onlySealingPerms(alt_lsu_late_res)
);

`endif

`ifndef REMOVE_SLICE_17
Mem_RevokeMatch: assert property (
    `IS_LOADCAPIMM & wbexc_finishing & ~wbexc_err
    |->
    ##3`RF.trvk_en_i &&
    `RF.trvk_clrtag_i == ($past(wbexc_spec_mem_revoke_en, 3) & $past(wbexc_spec_mem_revoke, 3))
);

`endif

`ifndef REMOVE_SLICE_18
Mem_Load_NoWe: assert property (ex_is_load_instr |-> spec_mem_read |-> ~data_we_o);

Mem_Load_En: assert property (ex_is_load_instr |-> data_req_o |-> spec_mem_read);

Mem_Store_We: assert property (ex_is_store_instr |-> spec_mem_write |-> data_we_o);

Mem_Store_En: assert property (ex_is_store_instr |-> data_req_o |-> spec_mem_write);

`endif

`ifndef REMOVE_SLICE_19
Mem_Load_SndEn: assert property (ex_is_load_instr |-> mem_req_snd_d |-> spec_mem_read_snd);

Mem_Store_SndEn: assert property (ex_is_store_instr |-> mem_req_snd_d |-> spec_mem_write_snd);

`endif

`ifndef REMOVE_SLICE_20
Mem_Load_FstAddr: assert property (
    ex_is_load_instr |-> mem_req_fst_d |-> spec_mem_read_fst_addr == data_addr_o
);

Mem_Load_SndAddr: assert property (
    ex_is_load_instr |-> mem_req_snd_d |-> spec_mem_read_snd_addr == data_addr_o
);

Mem_Store_FstAddr: assert property (
    ex_is_store_instr |-> mem_req_fst_d |-> spec_mem_write_fst_addr == data_addr_o
);

Mem_Store_FstWData: assert property (
    ex_is_store_instr |-> mem_req_fst_d
    |->
    (spec_mem_write_fst_wdata & fst_mask) == (data_wdata_o & fst_mask)
);

Mem_Store_SndAddr: assert property (
    ex_is_store_instr |-> mem_req_snd_d |-> spec_mem_write_snd_addr == data_addr_o
);

Mem_Store_SndWData: assert property (
    ex_is_store_instr |-> mem_req_snd_d
    |->
    (spec_mem_write_snd_wdata & snd_mask) == (data_wdata_o & snd_mask)
);

`endif

`ifndef REMOVE_SLICE_21
Mem_Load_End_Fst: assert property (
    ex_is_load_instr && instr_will_progress |-> spec_mem_read |-> mem_gnt_fst_d
);

Mem_Load_End_Snd: assert property (
    ex_is_load_instr && instr_will_progress |-> spec_mem_read_snd |-> mem_gnt_snd_d
);

Mem_Store_End_Fst: assert property (
    ex_is_store_instr && instr_will_progress |-> spec_mem_write |-> mem_gnt_fst_d
);

Mem_Store_End_Snd: assert property (
    ex_is_store_instr && instr_will_progress |-> spec_mem_write_snd |-> mem_gnt_snd_d
);

`endif

`ifndef REMOVE_SLICE_22
Mem_L_Addr_NotErr: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    addr_match
);

Mem_L_Data_NotErr: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    data_match
);

Mem_L_CSR_NotErr: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    csrs_match
);

Mem_L_PC_NotErr: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && ~wbexc_err
    |->
    pc_match
);

Mem_L_Addr_Err: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    addr_match
);

Mem_L_Data_Err: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    data_match
);

Mem_L_CSR_Err: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    csrs_match
);

Mem_L_PC_Err: assert property (
    wbexc_is_load_instr & (`IS_LOADCAPIMM -> wbexc_err) &&
    finishing_executed & ~wbexc_illegal && wbexc_err
    |->
    pc_match
);

Mem_S_Addr_NotErr: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && ~wbexc_err |-> addr_match
);

Mem_S_Data_NotErr: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && ~wbexc_err |-> data_match
);

Mem_S_CSR_NotErr: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && ~wbexc_err |-> csrs_match
);

Mem_S_PC_NotErr: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && ~wbexc_err |-> pc_match
);

Mem_S_Addr_Err: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && wbexc_err |-> addr_match
);

Mem_S_Data_Err: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && wbexc_err |-> data_match
);

Mem_S_CSR_Err: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && wbexc_err |-> csrs_match
);

Mem_S_PC_Err: assert property (
    wbexc_is_store_instr && finishing_executed & ~wbexc_illegal && wbexc_err |-> pc_match
);

Mem_CLC_Addr: assert property (
    `IS_LOADCAPIMM & ~wbexc_err && finishing_executed & ~wbexc_illegal |-> addr_match
);

Mem_CLC_CSR: assert property (
    `IS_LOADCAPIMM & ~wbexc_err && finishing_executed & ~wbexc_illegal |-> csrs_match
);

Mem_CLC_PC: assert property (
    `IS_LOADCAPIMM & ~wbexc_err && finishing_executed & ~wbexc_illegal |-> pc_match
);

Mem_CLC_DataNoTRVK: assert property (
    `IS_LOADCAPIMM & ~wbexc_err && finishing_executed & ~wbexc_illegal
    |->
    `WB.rf_waddr_wb_o == 5'b0 or ~res_data.tag |-> data_match
);

Mem_CLC_DataTRVK: assert property (
    `IS_LOADCAPIMM & ~wbexc_err && finishing_executed & ~wbexc_illegal
    |->
    `WB.rf_waddr_wb_o != 5'b0 and res_data.tag
    |->
    ##3 alas($past(wbexc_post_wX, 3), post_trvk_regs[$past(`WB.rf_waddr_wb_o, 3)])
);

`endif

`ifndef REMOVE_SLICE_23
Top_Addr: assert property (
    wbexc_finishing & (`IS_CSR -> wbexc_is_checkable_csr) & (`IS_LOADCAPIMM -> wbexc_err)
    |->
    addr_match
);

Top_Data: assert property (
    wbexc_finishing & (`IS_CSR -> wbexc_is_checkable_csr) & (`IS_LOADCAPIMM -> wbexc_err)
    |->
    data_match
);

Top_CSR: assert property (
    wbexc_finishing & (`IS_CSR -> wbexc_is_checkable_csr) & (`IS_LOADCAPIMM -> wbexc_err)
    |->
    csrs_match
);

Top_PC: assert property (
    wbexc_finishing & (`IS_CSR -> wbexc_is_checkable_csr) & (`IS_LOADCAPIMM -> wbexc_err)
    |->
    pc_match
);

`endif

`ifndef REMOVE_SLICE_24
RegMatch_1: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 1) & spec_past_has_reg[1] & `RF.reg_rdy_o[1]
    |->
    alas(spec_past_regs[1], pre_regs[1])
);

RegMatch_2: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 2) & spec_past_has_reg[2] & `RF.reg_rdy_o[2]
    |->
    alas(spec_past_regs[2], pre_regs[2])
);

RegMatch_3: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 3) & spec_past_has_reg[3] & `RF.reg_rdy_o[3]
    |->
    alas(spec_past_regs[3], pre_regs[3])
);

RegMatch_4: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 4) & spec_past_has_reg[4] & `RF.reg_rdy_o[4]
    |->
    alas(spec_past_regs[4], pre_regs[4])
);

RegMatch_5: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 5) & spec_past_has_reg[5] & `RF.reg_rdy_o[5]
    |->
    alas(spec_past_regs[5], pre_regs[5])
);

RegMatch_6: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 6) & spec_past_has_reg[6] & `RF.reg_rdy_o[6]
    |->
    alas(spec_past_regs[6], pre_regs[6])
);

RegMatch_7: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 7) & spec_past_has_reg[7] & `RF.reg_rdy_o[7]
    |->
    alas(spec_past_regs[7], pre_regs[7])
);

RegMatch_8: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 8) & spec_past_has_reg[8] & `RF.reg_rdy_o[8]
    |->
    alas(spec_past_regs[8], pre_regs[8])
);

RegMatch_9: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 9) & spec_past_has_reg[9] & `RF.reg_rdy_o[9]
    |->
    alas(spec_past_regs[9], pre_regs[9])
);

RegMatch_10: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 10) & spec_past_has_reg[10] & `RF.reg_rdy_o[10]
    |->
    alas(spec_past_regs[10], pre_regs[10])
);

RegMatch_11: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 11) & spec_past_has_reg[11] & `RF.reg_rdy_o[11]
    |->
    alas(spec_past_regs[11], pre_regs[11])
);

RegMatch_12: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 12) & spec_past_has_reg[12] & `RF.reg_rdy_o[12]
    |->
    alas(spec_past_regs[12], pre_regs[12])
);

RegMatch_13: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 13) & spec_past_has_reg[13] & `RF.reg_rdy_o[13]
    |->
    alas(spec_past_regs[13], pre_regs[13])
);

RegMatch_14: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 14) & spec_past_has_reg[14] & `RF.reg_rdy_o[14]
    |->
    alas(spec_past_regs[14], pre_regs[14])
);

RegMatch_15: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 15) & spec_past_has_reg[15] & `RF.reg_rdy_o[15]
    |->
    alas(spec_past_regs[15], pre_regs[15])
);

RegMatch_16: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 16) & spec_past_has_reg[16] & `RF.reg_rdy_o[16]
    |->
    alas(spec_past_regs[16], pre_regs[16])
);

RegMatch_17: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 17) & spec_past_has_reg[17] & `RF.reg_rdy_o[17]
    |->
    alas(spec_past_regs[17], pre_regs[17])
);

RegMatch_18: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 18) & spec_past_has_reg[18] & `RF.reg_rdy_o[18]
    |->
    alas(spec_past_regs[18], pre_regs[18])
);

RegMatch_19: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 19) & spec_past_has_reg[19] & `RF.reg_rdy_o[19]
    |->
    alas(spec_past_regs[19], pre_regs[19])
);

RegMatch_20: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 20) & spec_past_has_reg[20] & `RF.reg_rdy_o[20]
    |->
    alas(spec_past_regs[20], pre_regs[20])
);

RegMatch_21: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 21) & spec_past_has_reg[21] & `RF.reg_rdy_o[21]
    |->
    alas(spec_past_regs[21], pre_regs[21])
);

RegMatch_22: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 22) & spec_past_has_reg[22] & `RF.reg_rdy_o[22]
    |->
    alas(spec_past_regs[22], pre_regs[22])
);

RegMatch_23: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 23) & spec_past_has_reg[23] & `RF.reg_rdy_o[23]
    |->
    alas(spec_past_regs[23], pre_regs[23])
);

RegMatch_24: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 24) & spec_past_has_reg[24] & `RF.reg_rdy_o[24]
    |->
    alas(spec_past_regs[24], pre_regs[24])
);

RegMatch_25: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 25) & spec_past_has_reg[25] & `RF.reg_rdy_o[25]
    |->
    alas(spec_past_regs[25], pre_regs[25])
);

RegMatch_26: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 26) & spec_past_has_reg[26] & `RF.reg_rdy_o[26]
    |->
    alas(spec_past_regs[26], pre_regs[26])
);

RegMatch_27: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 27) & spec_past_has_reg[27] & `RF.reg_rdy_o[27]
    |->
    alas(spec_past_regs[27], pre_regs[27])
);

RegMatch_28: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 28) & spec_past_has_reg[28] & `RF.reg_rdy_o[28]
    |->
    alas(spec_past_regs[28], pre_regs[28])
);

RegMatch_29: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 29) & spec_past_has_reg[29] & `RF.reg_rdy_o[29]
    |->
    alas(spec_past_regs[29], pre_regs[29])
);

RegMatch_30: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 30) & spec_past_has_reg[30] & `RF.reg_rdy_o[30]
    |->
    alas(spec_past_regs[30], pre_regs[30])
);

RegMatch_31: assert property (
    (~`CR.rf_write_wb || `CR.rf_waddr_wb != 31) & spec_past_has_reg[31] & `RF.reg_rdy_o[31]
    |->
    alas(spec_past_regs[31], pre_regs[31])
);

SpecPastNoWbexc_Priv: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_priv == pre_priv
);

SpecPastNoWbexc_Mstatus: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mstatus == pre_mstatus
);

SpecPastNoWbexc_Mie: assert property (has_spec_past & ~wbexc_exists |-> spec_past_mie == pre_mie);

SpecPastNoWbexc_Mcause: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mcause == pre_mcause
);

SpecPastNoWbexc_Mtval: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mtval == pre_mtval
);

SpecPastNoWbexc_Mscratch: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mscratch == pre_mscratch
);

SpecPastNoWbexc_Mcounteren: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mcounteren == pre_mcounteren
);

SpecPastNoWbexc_NMIMode: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_nmi_mode == pre_nmi_mode
);

SpecPastNoWbexc_MStack: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mstack == pre_mstack
);

SpecPastNoWbexc_MStackCause: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mstack_cause == pre_mstack_cause
);

SpecPastNoWbexc_MStackEpc: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_mstack_epc == pre_mstack_epc
);

SpecPastNoWbexc_Mtvec: assert property (
    has_spec_past & ~wbexc_exists |-> alas(spec_past_mtvec, pre_mtvec)
);

SpecPastNoWbexc_Mepc: assert property (
    has_spec_past & ~wbexc_exists |-> alas(spec_past_mepc, pre_mepc)
);

SpecPastNoWbexc_MscratchC: assert property (
    has_spec_past & ~wbexc_exists |-> alas(spec_past_mscratchc, pre_mscratchc)
);

SpecPastNoWbexc_Pcc: assert property (
    has_spec_past & ~wbexc_exists |-> alas(spec_past_pcc, pre_pcc)
);

SpecPastNoWbexc_Mtdc: assert property (
    has_spec_past & ~wbexc_exists |-> alas(spec_past_mtdc, pre_mtdc)
);

SleepSpecPastPC: assert property (
    has_spec_past & (`IDC.ctrl_fsm_cs == `IDC.WAIT_SLEEP || `IDC.ctrl_fsm_cs == `IDC.SLEEP)
    |->
    spec_past_pc == `CR.pc_if
);

SpecPastInvalidPC: assert property (
    has_spec_past & wbexc_exists & ~ex_kill & ~`ID.instr_valid_i |-> spec_past_pc == `CR.pc_if
);

`endif

`ifndef REMOVE_SLICE_25
SpecPastNoWbexcPC: assert property (
    has_spec_past & ~wbexc_exists |-> spec_past_pc == (`ID.instr_valid_i ? pre_pc : `CR.pc_if)
);

`endif

`ifndef REMOVE_SLICE_26
Wrap_Priv: assert property (spec_en |-> has_spec_past |-> spec_past_priv == pre_priv);

Wrap_Mstatus: assert property (spec_en |-> has_spec_past |-> spec_past_mstatus == pre_mstatus);

Wrap_Mie: assert property (spec_en |-> has_spec_past |-> spec_past_mie == pre_mie);

Wrap_Mcause: assert property (spec_en |-> has_spec_past |-> spec_past_mcause == pre_mcause);

Wrap_Mtval: assert property (spec_en |-> has_spec_past |-> spec_past_mtval == pre_mtval);

Wrap_Mscratch: assert property (spec_en |-> has_spec_past |-> spec_past_mscratch == pre_mscratch);

Wrap_Mcounteren: assert property (
    spec_en |-> has_spec_past |-> spec_past_mcounteren == pre_mcounteren
);

Wrap_Pc: assert property (spec_en |-> has_spec_past |-> spec_past_pc == pre_pc);

Wrap_NMIMode: assert property (spec_en |-> has_spec_past |-> spec_past_nmi_mode == pre_nmi_mode);

Wrap_MStack: assert property (spec_en |-> has_spec_past |-> spec_past_mstack == pre_mstack);

Wrap_MStackCause: assert property (
    spec_en |-> has_spec_past |-> spec_past_mstack_cause == pre_mstack_cause
);

Wrap_MStackEpc: assert property (
    spec_en |-> has_spec_past |-> spec_past_mstack_epc == pre_mstack_epc
);

Wrap_Mtvec: assert property (spec_en |-> has_spec_past |-> alas(spec_past_mtvec, pre_mtvec));

Wrap_Mepc: assert property (spec_en |-> has_spec_past |-> alas(spec_past_mepc, pre_mepc));

Wrap_MscratchC: assert property (
    spec_en |-> has_spec_past |-> alas(spec_past_mscratchc, pre_mscratchc)
);

Wrap_Pcc: assert property (spec_en |-> has_spec_past |-> alas(spec_past_pcc, pre_pcc));

Wrap_Mtdc: assert property (spec_en |-> has_spec_past |-> alas(spec_past_mtdc, pre_mtdc));

Wrap_RegA: assert property (
    spec_en |-> reg_driven[`CR.rf_raddr_a] && spec_past_has_reg[`CR.rf_raddr_a]
    |->
    alas(spec_past_regs[`CR.rf_raddr_a], pre_regs_cut[`CR.rf_raddr_a])
);

Wrap_RegB: assert property (
    spec_en |-> reg_driven[`CR.rf_raddr_b] && spec_past_has_reg[`CR.rf_raddr_b]
    |->
    alas(spec_past_regs[`CR.rf_raddr_b], pre_regs_cut[`CR.rf_raddr_b])
);

Mem_En: assert property (data_req_o |-> spec_mem_en);

Mem_SndEn: assert property (mem_req_snd_d |-> spec_mem_en_snd);

Mem_We: assert property (data_req_o |-> data_we_o == spec_mem_write && data_we_o == ~spec_mem_read);

Mem_FstAddr: assert property (mem_req_fst_d |-> spec_mem_fst_addr == data_addr_o);

Mem_SndAddr: assert property (mem_req_snd_d |-> spec_mem_snd_addr == data_addr_o);

Mem_FstWData: assert property (
    mem_req_fst_d & data_we_o
    |->
    (spec_mem_write_fst_wdata & fst_mask) == (data_wdata_o[31:0] & fst_mask)
);

Mem_SndWData: assert property (
    mem_req_snd_d & data_we_o
    |->
    (spec_mem_write_snd_wdata & snd_mask) == (data_wdata_o[31:0] & snd_mask)
);

Mem_WTag: assert property (mem_req_fst_d & data_we_o |-> spec_mem_write_tag == data_wdata_o[32]);

Mem_FstEnd: assert property (spec_en & spec_mem_en |-> mem_gnt_fst_d);

Mem_SndEnd: assert property (spec_en & spec_mem_en_snd |-> mem_gnt_snd_d);

`endif

