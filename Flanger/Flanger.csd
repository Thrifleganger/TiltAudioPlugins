form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(282, 156, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(40, 26, 72, 67), channel("delayTime"), range(0, 0.02999999999999999889, 0.010000000000000000208, 1, 0.001), text("Delay Time"),  
rslider bounds(122, 26, 64, 67), channel("feedback"), range(0, 1, .5, 1, 0.001), text("Feedback"),  
rslider bounds(196, 26, 60, 64), channel("lfoRate"), range(0.1	, 10	, 3	, 1, 0.001), text("Rate"),  
rslider bounds(264, 26, 64, 64), channel("lfoDepth"), range(0	, 1	, .5	, 1, 0.001), text("Depth"),  
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

giLFO		ftgen		0,0,2^12, 19, 05, 1, 180, 1

instr 1
kGain chnget "gain"

kDelTime	chnget		"delayTime"
kFeedback	chnget		"feedback"
kLFORate	chnget		"lfoRate"
kLFODepth	chnget		"lfoDepth"
kCenter		=			.010
a1 inch 1

kModLFO		lfo			kLFODepth, kLFORate 

aMod		poscil		.005, kLFORate, giLFO
iOff		=			ksmps/sr

aDump		delayr 		1
aFlange		deltapi 	aMod + iOff
			delayw		a1 + aFlange * kFeedback
			
amix		=			a1 + aFlange

outs amix*kGain, amix*kGain
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
