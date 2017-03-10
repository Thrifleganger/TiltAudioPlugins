<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(90, 36, 67, 80), channel("mix"), range(0, 1, .5, 1, 0.001), text("Mix"),  
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
kMix	chnget	"mix"

a1 inch 1

ifftsize = 1024
ioverlap = ifftsize/8
iwinsize = ifftsize
iwinshape = 2

fftin	pvsanal 	a1, ifftsize, ioverlap, iwinsize, iwinshape
fscale 	pvscale		fftin, octave(-2), 1
aShift	pvsynth		fscale

aDump	delayr		.1
aD1		deltapn		ifftsize
		delayw		a1

aOut	=			(aD1 * (1-kMix)) + (aShift * kMix)
outs aOut*kGain, aOut*kGain

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
