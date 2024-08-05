import sys
import re

names = sys.argv[1:]

with open("build/ibexspec.sv", "r") as f:
    c = f.read()

for func_name in names:
    m = re.search(r"^(\s*)function automatic .+ " + func_name + r"\(.*\);", c, re.MULTILINE)
    assert m is not None
    end = c.index("endfunction", m.start())
    assert end >= 0

    c = c[0:m.start()] + c[end + 11:]

with open("build/ibexspec.sv", "w") as f:
    f.write(c)
