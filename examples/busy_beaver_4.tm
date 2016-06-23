# 4 state busy beaver
# From https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/turing-machine/four.html

st0	_	st1	1	R
st0	0	st0	_	N
st0	1	st1	1	L

st1	_	st0	1	L
st1	0	st0	_	N
st1	1	st2	_	L

st2	_	stop	1	R
st2	0	st0	_	N
st2	1	st3	1	L

st3	_	st3	1	R
st3	0	st0	_	N
st3	1	st0	_	R