./vcs_testrig_out/simv \
    -ucli \
    -do ./vcs_testrig.tcl \
    +UVM_TESTNAME=core_ibex_testrig_test \
    -l run.log \
    -cm line+tgl+assert+fsm+branch \
    -cm_dir vcs_testrig_out/sim.vdb \
    -cm_hier /home/harry/projects/TestRIG/riscv-implementations/cheriot-ibex/dv/uvm/core_ibex/cover.cfg \
    +enable_uarch_cov=1 \
    +enable_ibex_fcov=1
