#!/usr/bin/env bash

export PRJ_DIR=$(realpath ../../../)

mkdir -p vcs_testrig_out

pushd vcs_testrig_out

vcs \
  -full64 \
  -sverilog \
  +define+UVM \
  -ntb_opts uvm-1.2 \
  -timescale=1ns/10ps \
  -f ../ibex_testrig_dv.f \
  -l compile.log \
  -q \
  -cm line+cond+tgl+fsm+branch+assert \
  -cm_hier /home/harry/projects/TestRIG/riscv-implementations/cheriot-ibex/dv/uvm/core_ibex/cover.cfg \
  -cm_dir sim.vdb \
  -debug_access+all \
  -CFLAGS "-I${PRJ_DIR}/vendor/SocketPacketUtils" \
  -Xcflags='-Wno-error=implicit-function-declaration' \
  -Xcflags='-Wno-error=int-conversion'

popd
