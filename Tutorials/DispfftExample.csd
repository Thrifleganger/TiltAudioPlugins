<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
gentable bounds(36, -4, 260, 160), channel("pos","end"), tablecolour("white", "cornflowerblue", "yellow", "lime", "green", "pink", "brown", "purple", "lightblue", "darkgreen", "lightgreen", "mango"), scrubberposition(0, 0),  tablenumber(1), 
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr 1

kcps = 110
ifn  = 1

knh	line p4, p3, p5
asig	buzz 1, kcps, knh, ifn
	outs asig, asig

dispfft	asig, .1, 2048, 0, 1

endin
</CsInstruments>
<CsScore>
;sine wave.
f 1 0 16384 10 1

f0 z

</CsScore>
</CsoundSynthesizer>