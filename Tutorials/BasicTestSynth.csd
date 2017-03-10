<Cabbage>
form caption("Untitled") size(400, 300), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
rslider bounds(30, 24, 50, 50), channel("gain"), range(0, 1, 0)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

;instrument will be triggered by keyboard widget
instr 1
kGain chnget "gain"
kEnv madsr .1, .2, .6, .4
aOut vco2 p5, p4
iNote notnum
print iNote 
outs aOut*kEnv*kGain, aOut*kEnv*kGain
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
