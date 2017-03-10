<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
hrange	bounds(30, 30, 200, 20), channel("low","high"), range(0, 1000, 40:600, .5, 1)

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1


instr 1
kGain chnget "gain"
kLow	chnget		"low"
kHigh	chnget		"high"


printk2	kLow
printk2 kHigh

a1 inch 1
a2 inch 2

outs a1*kGain, a2*kGain
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
