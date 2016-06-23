# Binary Counter

# Reads binary number from tape and increments it.
# From https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/turing-machine/four.html

st0	_	st1	_	R
st0	0	st0	0	L
st0	1	st0	1	L

st1	_	st2	1	L
st1	0	st2	1	R
st1	1	st1	0	R

st2	_ 	stop	_	R
st2 	0 	st2	0	L
st2 	1 	st2	1	L