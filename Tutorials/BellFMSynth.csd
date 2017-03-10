
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(24, 32, 50, 50), channel("freq"), range(200	, 5000	, 500, 1, 0.001), text("Freq"),  
rslider bounds(86, 32, 61, 50), channel("indexLow"), range(.01	, 5	, 2, 1, 0.001), text("IndexLow"),  
rslider bounds(152, 32, 64, 50), channel("indexHigh"), range(0.010000000000000000208, 5, .5, 1, 0.001), text("IndexHigh"),  
rslider bounds(24, 98, 50, 50), channel("fratio1"), range(1	, 10	, 3.7	, 1, 0.001), text("RatioLow"),  
rslider bounds(88, 96, 60, 50), channel("fratio2"), range(1, 10, 3.7000000000000001776, 1, 0.001), text("RatioHigh"),  
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

kTrig		metro		.4
if kTrig == 1 then
	event 	"i",2,0, 7
endif
endin

instr 2

iFreq 		chnget		"freq"
iIndexLow	chnget		"indexLow"
iIndexHigh	chnget		"indexHigh"
iFRatioLow	chnget		"fratio1"
iFRatioHigh	chnget		"fratio2"

kIndex		expon		iIndexLow, p3, iIndexHigh
kFRatio		expon		iFRatioLow, p3, iFRatioHigh
kEnv		expon		1, p3, 0.01

aMod		poscil		iFreq*kIndex, iFreq*kFRatio
aCarr		poscil		.2*kEnv, iFreq + aMod

			out			aCarr, aCarr
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
;i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
