all: lowrisc_ibex_ibex_formal_0.1

lowrisc_ibex_ibex_formal_0.1: lowrisc_ibex_ibex_formal_0.1.scr
	vcs -full64 -top ibex_top -f lowrisc_ibex_ibex_formal_0.1.scr -o $@  -sverilog
run: lowrisc_ibex_ibex_formal_0.1
	./lowrisc_ibex_ibex_formal_0.1 -l vcs.log 
clean:
	$(RM) lowrisc_ibex_ibex_formal_0.1
