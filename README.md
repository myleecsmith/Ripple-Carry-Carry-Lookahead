## Ripple-Carry-Carry-Lookahead
# Ripple carry and carry lookahead are both architectures of the adder file

* includes a full adder(FA) for the ripple carry
* includes cla2, cgen2 for the carry lookahead
* includes a test bench for each component

The carry lookahead is created by two instantiations of cla2 which feed into cgen2 which produces the outputs. CLA only adds 4 bits but does include a carry_out.

Ripple carry is created by linked together multiple instantiations of FA in a for generate loop. 
