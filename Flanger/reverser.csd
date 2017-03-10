form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")



rslider bounds(26, 0, 62, 80), channel("time	"), range(0.001, 4, 3.5, 1, 0.001), text("Time"),  
rslider bounds(104, 0, 62, 80), channel("feedback"), range(0.0010000000000000000208, 1, .6, 1, 0.001), text("Feedback"),  
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

gienv1	ftgen			0, 0, 131072, 7, 0, 1024,           1, 131072-(1024*2),           1,  1024,       0	;for longest chunk times
gienv2	ftgen			0, 0, 131072, 7, 0, 4096,           1, 131072-(4096*2),           1,  4096,       0
gienv3	ftgen			0, 0, 131072, 7, 0,16384,           1, 131072-(16384*2),          1, 16384,       0
gienv4	ftgen			0, 0, 131072, 7, 0,32768,           1, 131072-(32768*2),          1, 32768,       0

instr 1
kGain chnget "gain"
kTime chnget "time"
kFeedback chnget "feedback"

a1 inch 1

kenv	linseg	0, .01, 1
kTime portk kTime, .05

aPtr		phasor			(2/kTime)
;printk 		.1, k(aPtr)
aenv		table3			aPtr,gienv2,1
aPtr	=	aPtr*kTime

;printk 		.1, k(aPtr)
aDump		delayr			4
aTap		deltap3			aPtr
			delayw			a1 + aTap*kFeedback


aMix		=			aTap + a1
aMix		*=			kGain
outs aMix, aMix
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
