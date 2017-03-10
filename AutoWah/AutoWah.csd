<Cabbage>
form caption("Auto Wah") size(400, 500), pluginID("def1")

gentable bounds(20, 180, 224, 109), identchannel("table"), tablenumber(10), tablecolour("cyan"), zoom(-1), active(1)
gentable bounds(20, 180, 224, 109), identchannel("table2"), tablenumber(4), tablecolour("cyan"), zoom(-1), active(1), visible(0), amprange(-1,1,4)
rslider bounds(296, 162, 100, 100), channel("mix"), range(0	, 1	, 0.5, 1, 0.01), text("Mix"),  trackercolour(0, 255, 0, 255), textcolour(0, 0, 0, 255), outlinecolour(0, 0, 0, 50), 

rslider bounds(98, 104, 65, 70), channel("lfoShape"), range(0, 5, 1, 1, 1), text("LFO shape"), 
rslider bounds(98, 20, 60, 67), channel("lfoRateSynced"), range(0, 10, 5, 1, 1), text("LFO Rate"), visible(0), identchannel("lfoRateSyncedIdent")   
rslider bounds(98, 20, 60, 67), channel("lfoRateManual"), range(0, 10, .2, .5, 0.001), text("LFO Rate"), identchannel("lfoRateManualIdent")

rslider bounds(20, 106, 68, 66), channel("depth"), range(	-30	, 30	, 20	, 1	, 0.001), text("Depth"),  
rslider bounds(168, 102, 74, 73), channel("skew"), range(-1	, 1	, , 1, 0.001), text("Skew"),  
;hrange bounds(66, 454, 259, 32), channel("lowBand","highBand"), range(20, 20000, 500:1500, 1 , 1), identchannel("bandRange")  
hslider bounds(58, 320, 259, 30), channel("centerFreq"), range(20, 20000, 1000, .5, 1),  
hslider bounds(58, 360, 259, 30), channel("lowBand"), range(20	, 20000	, 500, .5, 1), identchannel("lowBandIdent"),  
hslider bounds(58, 400, 259, 30), channel("highBand"), range(20	, 20000	, 1500, .5, 1), identchannel("highBandIdent"), 
button bounds(190, 64, 60, 25), channel("tempoSync"), text("Sync"), colour:1(233, 91, 91, 255), value(0) 
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

giTS		=				4096
giSine		ftgen			1, 0, 4096, 10, 1
giTri		ftgen			2, 0, 4096, 7, 0, giTS/4, 1, giTS/2, -1, giTS/4, 0
giSquare	ftgen			3, 0, 4096, 7, 0, giTS/2, 0, 1, 1, giTS/2, 1
giLine		ftgen			4, 0, 4096, -7, 0, giTS/6, 0, giTS/6, 0, giTS/6, 0, giTS/6, 0, giTS/6, 0, giTS/6, 0
giDisp		ftgen			10, 0, 4096, 7, -1, giTS/2, -1, 1, 1, giTS/2, 1

instr 1

klfoShape	chnget			"lfoShape"
kRateManual	chnget			"lfoRateManual"
kRateSynced	chnget			"lfoRateSynced"
klfoRange	chnget			"lfoRange"
kDepth		chnget			"depth"
kBandwidth	chnget			"bandwidth"
kSkew		chnget			"skew"
kCenter		chnget			"centerFreq"
kLowBand	chnget			"lowBand"
kHighBand	chnget			"highBand"
kMix		chnget			"mix"
kSync		chnget			"tempoSync"
kTempo		chnget			"HOST_BPM"

; Frequency Range section: Selection of Center frequency and corresponding range
kFreqTrig 	changed			kCenter, kLowBand, kHighBand
kFreqDiff	=				kHighBand - kLowBand
; Make sure that the range remains constant irrespective of center frequency
if (kFreqTrig == 1) then
	kFreqDiff	=				kHighBand - kLowBand
	kLowBand	=				kCenter - kFreqDiff/2
	kHighBand	=				kCenter + kFreqDiff/2
	/*if (kLowBand < 20) then
	 	kLowBand	=				20
		kFreqDiff	=				2*(kCenter - kLowBand)
		kHighBand	=				kCenter + kFreqDiff/2
	elseif kHighBand > 20000 then
		kHighBand	=				20000
		kFreqDiff	=				2*(kHighBand - kCenter)
		kLowBand	=				kCenter - kFreqDiff/2
	endif
	*/
	; Limiting values of Lower and Upper bounds to avoid aliasing
	kLowBand	limit			kLowBand, 20, 20000
	kHighBand	limit			kHighBand, 20, 20000
	
				chnset			sprintfk("range(20, 20000, %d, .5, 1)",kLowBand), "lowBandIdent"
				chnset			sprintfk("range(20, 20000, %d, .5, 1)",kHighBand), "highBandIdent"
endif	


kSyncTrig	changed			kSync
;Delete this::::
kTempo		=				120
klfoRate	=		kRateManual
if (kSyncTrig == 1) then
	reinit SWITCH_RATE_SLIDER	
endif

SWITCH_RATE_SLIDER:
	if(i(kSync) == 0) then
		klfoRate	=		kRateManual
		chnset			"visible(1)", "lfoRateManualIdent"
		chnset			"visible(0)", "lfoRateSyncedIdent"
	elseif (i(kSync) == 1) then
		klfoRate	=		kRateSynced
		chnset			"visible(0)", "lfoRateManualIdent"
		chnset			"visible(1)", "lfoRateSyncedIdent"
	endif	
rireturn
	
#define RATE_CALC(FACTOR) #
klfoRate	=		(60/kTempo) * $FACTOR
#

if kSync == 1 then
	if klfoRate == 0 then
		$RATE_CALC(1/4)
	elseif klfoRate == 1 then
		$RATE_CALC(1/3)
	elseif klfoRate == 2 then
		$RATE_CALC(1/2)
	elseif klfoRate == 3 then
		$RATE_CALC(1/1.5)
	elseif klfoRate == 4 then
		$RATE_CALC(1/1.33333333)
	elseif klfoRate == 5 then
		$RATE_CALC(1)
	elseif klfoRate == 6 then
		$RATE_CALC(1.3333333333)
	elseif klfoRate == 7 then
		$RATE_CALC(1.5)
	elseif klfoRate == 8 then
		$RATE_CALC(2)
	elseif klfoRate == 9 then
		$RATE_CALC(3)
	elseif klfoRate == 10 then
		$RATE_CALC(4)
	endif
endif

if klfoShape == 0 then
	kLFO		poscil			kFreqDiff/2, klfoRate, giSine
elseif klfoShape == 1 then
	kLFO		poscil			kFreqDiff/2, klfoRate, giTri
elseif klfoShape == 2 then
	kLFO		poscil			kFreqDiff/2, klfoRate, giSquare
elseif klfoShape == 3 then
	kLFO		poscil			kFreqDiff/2, klfoRate, giLine
endif


;aLeft		inch 			1
;aRight		inch 			2

aLeft		rand			.1
aRight		=				aLeft

kDepth		=				ampdb(kDepth)
aEffectL	rbjeq 			aLeft, kCenter+kLFO, kDepth, 1, 1, 8
aEffectR	rbjeq 			aRight, kCenter+kLFO, kDepth, 1, 1, 8

kShapeTrig		changed			kSkew, klfoShape
if kShapeTrig == 1 then
	chnset		"visible(0)","table2"
	reinit UPDATE
endif

UPDATE:
if i(klfoShape) == 0 then
				tableicopy		10, 1
				chnset			"tablenumber(10)", "table"
elseif i(klfoShape) == 1 then
	giTri		ftgen			2, 0, 4096, 7, 0, giTS/4-(giTS/4)*i(kSkew), 1, giTS/2+(giTS/2)*i(kSkew),-1, giTS/4-(giTS/4)*i(kSkew),0		
				tableicopy		10, 2
				chnset			"tablenumber(10)", "table"
elseif i(klfoShape) == 2 then
	giSquare	ftgen			3, 0, 4096, 7, -1, giTS/2-(giTS/2)*i(kSkew), -1, 1, 1, giTS/2+(giTS/2)*i(kSkew), 1
				tableicopy		10, 3
				chnset			"tablenumber(10)", "table"
elseif i(klfoShape) == 3 then
				chnset			"visible(1)", "table2"
				chnset			"tablenumber(10)", "table"
endif
rireturn

aMixL		=				(aEffectL * kMix) + (aLeft * (1-kMix))
aMixR		=				(aEffectR * kMix) + (aRight * (1-kMix))

			outs			aMixL, aMixR
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
