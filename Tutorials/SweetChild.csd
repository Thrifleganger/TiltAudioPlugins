<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 1
nchnls = 1
0dbfs = 1


instr 1
kGain chnget "gain"

a1 inch 1
a2 inch 2

;outs a1*kGain, a2*kGain
endin

giNoise		ftgen			1, 0, 128, 21, 3, 1

instr 2

aPhasor		init 			0
aPrev		init			0
aPluck		table			aPhasor, giNoise
aPhasor  	wrap 			aPhasor+1, 0, ftlen(giNoise)
aAvg 		=				(aPluck + aPrev) * .5
aPrev		= 				aPluck
			tablew 			aAvg, aPhasor, giNoise

			out				aPluck*1
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
;i1 0 [60*60*24*7] 

i 2 0 2
</CsScore>
</CsoundSynthesizer>
