<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")
rslider bounds(50, 50, 100, 100), channel("diff"), range(0, 200, 0, 1, .01), text("Diff"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")
rslider bounds(200, 50, 100, 100), channel("freq"), range(400, 1400, 440, 1, .01), text("Freq"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")
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


;instr 1
;kGain chnget "gain"
;kFreq chnget "freq"
;
;ain 	poscil		.5, kFreq
;ain2	poscil		.5, kFreq + chnget:k("diff")
;
;amix = ain + ain2
;outs amix*kGain, amix*kGain
;endin

instr 1

kGain chnget "gain"

aout poscil .5, 800
outs aout * kGain, aout * kGain

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
