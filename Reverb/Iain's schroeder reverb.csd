<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, .3, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(44, 30, 61, 61), channel("reverbTime"), range(0, 10	, 5, 1, 0.001), text("RvbTime"),
rslider bounds(44, 100, 61, 61), channel("cutOffFreq"), range(200, 20000, 10000, 1, 0.001), text("CutOff"), 
 rslider bounds(122, 100, 61, 61), channel("predelay"), range(0, 100, 25, 1, 0.001), text("PreDelay"), 
rslider bounds(122, 30, 61, 61), channel("mix"), range(0, 1, .2, 1, 0.001), text("Mix"),  
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

kRvbTime 	chnget		"reverbTime"
kCutOff		chnget		"cutOffFreq"
kPreDel		chnget		"predelay"
kMix		chnget		"mix"
	
a0 inch 1	

;Predelay
a1		vdelay	a0, kPreDel, 1000

aC1 	comb	a1, kRvbTime, .0297
aC2		comb	a1, kRvbTime, .0371
aC3		comb	a1, kRvbTime, .0441
aC4		comb	a1, kRvbTime, .0437
aC5		comb	a1, kRvbTime, .0331
aC6		comb	a1, kRvbTime, .0277
aOut	sum		aC1, aC2, aC3, aC4, aC5, aC6

aOut	alpass	aOut, .1, .005
aOut	alpass	aOut, .1, .0113
aOut	alpass	aOut, .1, .0197
aOut	alpass	aOut, .1, .0229

aOut	butlp	aOut, kCutOff
aMix	ntrpol	a0, aOut, kMix
		outs	aMix* kGain, aMix * kGain

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
