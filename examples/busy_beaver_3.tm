# 3 state busy beaver
# From https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/turing-machine/four.html

st0	_	st1	1	L
st0	0	st0	_	N
st0	1	stop	1	N

st1	_	st2	_	L
st1	0	st0	_	N
st1	1	st1	1	L

st2	_	st2	1	R
st2	0	st0	_	N
st2	1	st0	1	R