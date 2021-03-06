<Cabbage>
form caption("Stereo Delay") size(900, 645), pluginID("def1"), svgpath("SVG")
image bounds(0, 0, 900, 645), file("Assets/StereoDelay.png")

image bounds(450, 170, 89, 40), file("Assets/HostButton.png"), alpha(0), identchannel("hostButtonId")
image bounds(450, 170, 89, 40), file("Assets/HostButtonPressed.png"), alpha(0), identchannel("hostButtonPressedId")

image bounds(373, 272, 65, 33), file("Assets/LinkButton.png"), alpha(1), identchannel("linkButtonId")
image bounds(373, 270, 65, 33), file("Assets/LinkButtonPressed.png"), alpha(0), identchannel("linkButtonPressedId")

image bounds(38, 508, 40, 70), file("Assets/Switch_position_1.png"), alpha(1), identchannel("bypassSwitchOnId")
image bounds(38, 508, 40, 70), file("Assets/Switch_position_2.png"), alpha(0), identchannel("bypassSwitchOffId")

image bounds(412, 72, 78, 47), file("Assets/Switch_side_1.png"), alpha(1), identchannel("switchManualId")
image bounds(412, 72, 78, 47), file("Assets/Switch_side_2.png"), alpha(0), identchannel("switchSyncId")

image bounds(142, 152, 150, 123), file("Assets/TimeManual.png"), alpha(1), identchannel("timeManualLId")
image bounds(134, 122, 158, 148), file("Assets/TimeSync.png"), alpha(0), identchannel("timeSyncLId")

image bounds(608, 152, 150, 123), file("Assets/TimeManual.png"), alpha(1), identchannel("timeManualRId")
image bounds(598, 122, 158, 148), file("Assets/TimeSync.png"), alpha(1), identchannel("timeSyncRId")

image bounds(28, 458, 61, 61), file("Assets/LED_on.png"), alpha(1), identchannel("ledOnId")
image bounds(28, 458, 61, 61), file("Assets/LED_off.png"), alpha(0), identchannel("ledOffId")

rslider bounds(808, 476, 75, 62), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

;Left channel widgets
combobox bounds(162, 83, 83, 27), channel("channel1"), items("Left","Right"), value(1), fontcolour(102, 224, 255)
numberbox bounds(198, 314, 40, 20), channel("delayTimeNumBoxL"), range(30, 3000, 700, 1, 1), identchannel("delayTimeNumBoxIdentL"), fontcolour(102, 224, 255)
rslider bounds(162, 160, 106, 112), channel("delayTimeSyncL"), range(0, 10, 5, 1, 1), identchannel("delayTimeSyncIdentL"), popuptext("0")  
rslider bounds(160, 160, 106, 112), channel("delayTimeManualL"), range(30, 3000, 700, 1, 1), identchannel("delayTimeManualIdentL"), popuptext("0")  
rslider bounds(148, 356, 84, 76), channel("feedbackL"), range(0, 1, 0.9000000000000000222, 1, 0.001)
rslider bounds(174, 478, 84, 76), channel("crossfadeL"), range(0, 1, 0.9000000000000000222, 1, 0.001)
rslider bounds(308, 534, 61, 47), channel("lowpassFreqL"), range(500, 20000, 10000, 1, 0.001),svgfile("slider","rslider_white.svg")  
rslider bounds(310, 474, 58, 46), channel("highpassFreqL"), range(20, 2000, 200, 1, 0.001), svgfile("slider","rslider_white.svg")

;Right channel widgets
combobox bounds(636, 83, 83, 27), channel("channel2"), items("Left","Right"), value(2), fontcolour(102, 224, 255)
numberbox bounds(662, 316, 40, 20), channel("delayTimeNumBoxR"), range(30, 3000, 700, 1, 1), identchannel("delayTimeNumBoxIdentR"), fontcolour(102, 224, 255)
rslider bounds(624, 160, 106, 112), channel("delayTimeSyncR"), range(0, 10, 5, 1, 1), identchannel("delayTimeSyncIdentR"), popuptext("0") 
rslider bounds(624, 160, 106, 112), channel("delayTimeManualR"), range(30, 3000, 700, 1, 1), identchannel("delayTimeManualIdentR"), popuptext("0") 
rslider bounds(672, 358, 84, 76), channel("feedbackR"), range(0, 1, 0.9000000000000000222, 1, 0.001)  
rslider bounds(646, 478, 84, 76), channel("crossfadeR"), range(0, 1, 0.9000000000000000222, 1, 0.001)  
rslider bounds(534, 536, 60, 46), channel("lowpassFreqR"), range(500, 20000, 10000, 1, 0.001), svgfile("slider","rslider_white.svg")  
rslider bounds(534, 478, 60, 44), channel("highpassFreqR"), range(20, 2000, 200, 1, 0.001), svgfile("slider","rslider_white.svg") 

;Synchronization widgets
numberbox bounds(430, 222, 40, 20), channel("bpmNumBox"), range(20, 400, 120, 1, 1), identchannel("bpmNumBoxIdent"), fontcolour(102, 224, 255)
button bounds(418, 80, 64, 25), channel("tempoSync"), text("Sync"), colour:1(233, 91, 91, 255), identchannel("tempoSyncIdent"), alpha(0)
button bounds(458, 178, 73, 25), channel("hostTempo"), text("Host"), colour:1(233, 91, 91, 255), identchannel("hostTempoIdent"), value(1), alpha(0)
button bounds(356, 166, 63, 64), channel("tapDelay"), text("Tap"), identchannel("tapDelayIdent"), corners(50), alpha(0)

; Linking widgets
rslider bounds(454, 268, 59, 63), channel("multiply"), range(0.10000000000000000555, 10, 1, 0.2999999999999999889, 0.001)  
button bounds(380, 274, 50, 22), channel("link"), text("Link"), colour:1(233, 91, 91, 255), identchannel("linkId") , alpha(0) 

; Metering widgets
gentable bounds(38, 114, 22, 230), tablenumber(1), amprange(0, 1, 1), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterInL")
gentable bounds(68, 114, 22, 231), tablenumber(2), amprange(0, 1, 2), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterInR")
gentable bounds(818, 114, 23, 234), tablenumber(3), amprange(0, 1, 3), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterOutL")
gentable bounds(846, 114, 21, 233), tablenumber(4), amprange(0, 1, 4), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterOutR")

image bounds(1, 76, 97, 306), file("Assets/MeterGrill.png")
image bounds(30, 76, 99, 306), file("Assets/MeterGrill.png")
image bounds(812, 74, 88, 311), file("Assets/MeterGrill.png")
image bounds(776, 74, 105, 312), file("Assets/MeterGrill.png")

; Mix stage widgets
button bounds(38, 512, 34, 63), channel("bypass"), text("Push", "Push"), value(1), alpha(0)
rslider bounds(32, 371, 50, 42), channel("inputGain"), range(-60	, 6	, 0	, 3, 0.001), svgfile("slider","SVG/rslider_white.svg")
rslider bounds(818, 372, 50, 43), channel("outputGain"), range(-60, 6, , 3, 0.001), svgfile("slider","SVG/rslider_white.svg")
rslider bounds(404, 494, 104, 94), channel("mix"), range(0, 1, 0.5, 1, 0.001)  
 
;hslider bounds(88, 156, 170, 32), channel("grooveL"), range(0	, 1, 0.5, 1, 0.001), text("Groove"),  
;hslider bounds(478, 158, 170, 32), channel("grooveR"), range(0, 1, 0.5, 1, 0.001), text("Groove"),  
rslider bounds(365, 391, 68, 62), channel("mixL"), range(0, 1, 1, 1, 0.001)  
rslider bounds(476, 388, 63, 67), channel("mixR"), range(0, 1, 1, 1, 0.001)  
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

giMeterInL		ftgen 		1, 0, -1, 2, 0
giMeterInR		ftgen		2, 0, -1, 2, 0
giMeterOutL		ftgen 		3, 0, -1, 2, 0
giMeterOutR		ftgen 		4, 0, -1, 2, 0

;giGrooveTabL	ftgen		5, 0, 2, -2, 120, 120

instr 1
kGain chnget "gain"

; Initialize variables
aDelL, aDelR 	init	 	0
kPrevTime 		init		0
kOn				init		1
kOff			init		0
kTapTempo		init		120
kIndex			init		0


;Test tone
;kEnv  		expseg		1, .5, .01
;aLeft		poscil		.5*kEnv, 440
;aRight 		poscil		.5*kEnv, 440
aLeft 			inch 		1
aRight 			inch 		2


;Left channel values
kTimeManualL 	chnget		"delayTimeManualL"
kTimeSyncL		chnget		"delayTimeSyncL"
kFeedbackL		chnget		"feedbackL"
kLowFreqL		chnget		"lowpassFreqL"
kHighFreqL		chnget		"highpassFreqL"
kCrossfadeL		chnget		"crossfadeL"
kTimeNumBoxL 	chnget		"delayTimeNumBoxL"

;Right channel values
kTimeManualR 	chnget		"delayTimeManualR"
kTimeSyncR		chnget		"delayTimeSyncR"
kFeedbackR		chnget		"feedbackR"
kLowFreqR		chnget		"lowpassFreqR"
kHighFreqR		chnget		"highpassFreqR"
kCrossfadeR		chnget		"crossfadeR"
kTimeNumBoxR 	chnget		"delayTimeNumBoxR"

;Tempo values
kBPMNumBox		chnget		"bpmNumBox"
kSync			chnget		"tempoSync"
kDelType		chnget		"delayType"
kTapDelTrig		chnget		"tapDelay"
kHost			chnget		"hostTempo"

;Misc values
kBypass			chnget		"bypass"
kMultiply		chnget		"multiply"
kLink			chnget		"link"
kGrooveL		chnget		"grooveL"
kGrooveR		chnget		"grooveR"
kMixL			chnget		"mixL"
kMixR			chnget		"mixR"
kInGain			chnget		"inputGain"
kOutGain		chnget		"outputGain"
kMix			chnget		"mix"
kChannel1		chnget		"channel1"
kChannel2		chnget		"channel2"

;Apply appropriate channels:
aLeft		=		kChannel1 == 1 ? aLeft : aRight
aRight		=		kChannel2 == 2 ? aRight : aLeft

;Apply input gain:
aLeft		*=			ampdb(kInGain)
aRight		*=			ampdb(kInGain)


SAlpha0		sprintfk	"alpha(%d)", kOff
SAlpha1		sprintfk	"alpha(%d)", kOn


; Do everything only is it isn't bypassed. endif at the end.
if (kBypass == 1) then
	chnset	SAlpha1, "bypassSwitchOnId"
	chnset	SAlpha0, "bypassSwitchOffId"
	chnset	SAlpha1, "ledOnId"
	chnset	SAlpha0, "ledOffId"
	
; Switching Tempo between host and tap tempo.
if kHost == 1 then
	;Delete this::::
	;kTempo		chnget		"HOST_BPM"
	kTempo		=			120		
	chnset		kTempo, "bpmNumBox"
	chnset		SAlpha0, "hostButtonId"
	chnset		SAlpha1, "hostButtonPressedId"
else
	kTempo		=			kTapTempo
	;If tempo is manually changed:
	kBPMBoxChange	changed		kBPMNumBox
	if kBPMBoxChange == 1 then
		kTempo 		= 	kBPMNumBox
		kTapTempo 	= 	kBPMNumBox
	endif
	chnset		kTempo, "bpmNumBox"	
	chnset		"alpha(1)", "hostButtonId"
	chnset		"alpha(0)", "hostButtonPressedId"
endif

; Selecting Syncd delay time values
kSyncTrig	changed		kSync
kTimeL		=		kTimeManualL
kTimeR		=		kTimeManualR
if (kSyncTrig == 1) then
	reinit SWITCH_TIME_SLIDER	
endif

SWITCH_TIME_SLIDER:
	if(i(kSync) == 0) then
		;printks "TimeManual: %d, timeBox: %d\n", 1, kTimeManualL, kTimeNumBoxL
		kTimeL	=		kTimeManualL
		chnset			"visible(1)", "delayTimeManualIdentL"
		chnset			"visible(0)", "delayTimeSyncIdentL"
		kTimeR	=		kTimeManualR
		chnset			"visible(1)", "delayTimeManualIdentR"
		chnset			"visible(0)", "delayTimeSyncIdentR"
		
		; Changing Images
		chnset			SAlpha1, "switchManualId"
		chnset			SAlpha0, "switchSyncId"
		chnset			SAlpha1, "timeManualLId"
		chnset			SAlpha0, "timeSyncLId"
		chnset			SAlpha1, "timeManualRId"
		chnset			SAlpha0, "timeSyncRId"
	elseif (i(kSync) == 1) then
		if kLink == 1 then
			chnset		kOff, "link"
		endif
		kTimeL	=		kTimeSyncL
		chnset			"visible(0)", "delayTimeManualIdentL"
		chnset			"visible(1)", "delayTimeSyncIdentL"
		kTimeR	=		kTimeSyncR
		chnset			"visible(0)", "delayTimeManualIdentR"
		chnset			"visible(1)", "delayTimeSyncIdentR"
		
		; Changing Images
		chnset			SAlpha0, "switchManualId"
		chnset			SAlpha1, "switchSyncId"
		chnset			SAlpha0, "timeManualLId"
		chnset			SAlpha1, "timeSyncLId"
		chnset			SAlpha0, "timeManualRId"
		chnset			SAlpha1, "timeSyncRId"
	endif	
rireturn

#define TIME_CALC(FACTOR'CHANNEL) #
$CHANNEL	=		(60/kTempo) * $FACTOR * 1000
#

#define CHANNEL_CALC(CHANNEL) #
if kSync == 1 then
	if $CHANNEL == 0 then
		$TIME_CALC(1/4'$CHANNEL)
	elseif $CHANNEL == 1 then
		$TIME_CALC(1/3'$CHANNEL)
	elseif $CHANNEL == 2 then
		$TIME_CALC(1/2'$CHANNEL)
	elseif $CHANNEL == 3 then
		$TIME_CALC(1/1.5'$CHANNEL)
	elseif $CHANNEL == 4 then
		$TIME_CALC(1/1.33333333'$CHANNEL)
	elseif $CHANNEL == 5 then
		$TIME_CALC(1'$CHANNEL)
	elseif $CHANNEL == 6 then
		$TIME_CALC(1.3333333333'$CHANNEL)
	elseif $CHANNEL == 7 then
		$TIME_CALC(1.5'$CHANNEL)
	elseif $CHANNEL == 8 then
		$TIME_CALC(2'$CHANNEL)
	elseif $CHANNEL == 9 then
		$TIME_CALC(3'$CHANNEL)
	elseif $CHANNEL == 10 then
		$TIME_CALC(4'$CHANNEL)
	endif
endif
#

$CHANNEL_CALC(kTimeL)
$CHANNEL_CALC(kTimeR)

; Tap tempo functionality
kTapped 	changed 	kTapDelTrig
if (kTapped == 1) then
	if (kSync == 0) then
		chnset			kOn, "tempoSync"
	endif
	if (kHost == 1) then
		chnset			kOff, "hostTempo"
		chnset			SAlpha0, "hostButtonPressedId"
		chnset			SAlpha1, "hostButtonId"
	endif
	if (kLink == 1) then
		chnset			kOff, "link"
	endif
	kCurrTime	timeinsts
	kTimeDiff 		=		(kCurrTime - kPrevTime)
	if (kTimeDiff < 3) then
		kTapTempo 	=			60/kTimeDiff		
	endif
	kPrevTime	timeinsts	
endif
	
;Linking and multiply
if kLink == 1 then
	
	kMulChanged		changed 	kMultiply	
	if kMulChanged == 1 then
		;kTimeL = kTimeManualL
		;kTimeR = kTimeManualR		
		kTimeR = kMultiply * kTimeManualL
		;chnset		kTimeL, "delayTimeManualL"
		;chnset		kTimeR, "delayTimeManualR"		
	endif
	kMulChanged 	changed		kTimeManualL
	if kMulChanged == 1 then	
		kTimeR = kMultiply * kTimeManualL	
	endif
	kMulChanged 	changed		kTimeManualR
	if kMulChanged == 1 then	
		kTimeL = kTimeManualR / kMultiply 
	endif
endif 
	
;Setting delay time in  number box
if kSync == 0 then		
	kNumBoxChange		changed		kTimeNumBoxL, kTimeNumBoxR
	if kNumBoxChange == 1 then
		chnset		kTimeNumBoxL, "delayTimeManualL"
		kTimeL		= 	kTimeNumBoxL
		kTimeManualL 	= 	kTimeNumBoxL
		
		chnset		kTimeNumBoxR, "delayTimeManualR"
		kTimeR		= 	kTimeNumBoxR
		kTimeManualR 	= 	kTimeNumBoxR
	endif
endif
chnset		kTimeL, "delayTimeNumBoxL"
chnset		kTimeR, "delayTimeNumBoxR"


; Grooving! Need to implement anti clipping mechanism
;kTimeChange	changed		kGrooveL
;if kTimeChange == 1 then
;	tablew  	kGrooveL, k(0), giGrooveTabL
;	tablew		(1 - kGrooveL), k(1), giGrooveTabL
;endif
;
;kGFracL		table 		kIndex, giGrooveTabL
;kTimeL		=			(kTimeL*2) * kGFracL
;kGTrig		metro 		1 / (kTimeL / 1000)
;if kGTrig == 1 then
;	kIndex += 1
;	kIndex		wrap		kIndex, 0, 2
;endif


; Delay and feedback network
aDelL		vdelay		(aLeft + (aDelL * kFeedbackL)), kTimeL, 10000
aDelR		vdelay		(aRight + (aDelR * kFeedbackR)), kTimeR, 10000


aDelL		butlp		aDelL, kLowFreqL
aDelL		buthp		aDelL, kHighFreqL
aDelR		butlp		aDelR, kLowFreqR
aDelR		buthp		aDelR, kHighFreqR

;						Direct Signal			LeftChannelDelay 					RightChannelDelay
aMixL		=			((aLeft * (1 - kMix)) + (aDelL * kMix * (1 - kCrossfadeL)) + (aDelR * kCrossfadeR)) * kGain * ampdb(kOutGain) * kMixL
aMixR		=			((aRight * (1 - kMix)) + (aDelR * kMix * (1 - kCrossfadeR)) + (aDelL * kCrossfadeL)) * kGain * ampdb(kOutGain) * kMixR

			outs 		aMixL, aMixR

; Write Metering data
kMeterInL 	rms 		aLeft
kMeterInL	=			(60-abs(dbamp(kMeterInL)))/60
kMeterInR 	rms 		aRight
kMeterInR	=			(60-abs(dbamp(kMeterInR)))/60
kMeterOutL 	rms 		aMixL
kMeterOutL	=			(60-abs(dbamp(kMeterOutL)))/60
kMeterOutR 	rms 		aMixR
kMeterOutR	=			(60-abs(dbamp(kMeterOutR)))/60

if metro(20) == 1 then
  	tablew  		kMeterInL, k(0), giMeterInL
	tablew  		kMeterInR, k(0), giMeterInR
	tablew 		kMeterOutL, k(0), giMeterOutL
	tablew 		kMeterOutR, k(0), giMeterOutR
  	chnset 		"tablenumber(1)", "vuMeterInL" 		
	chnset 		"tablenumber(2)", "vuMeterInR" 		
	chnset 		"tablenumber(3)", "vuMeterOutL" 		
	chnset 		"tablenumber(4)", "vuMeterOutR" 		
endif



else
	chnset	SAlpha0, "bypassSwitchOnId"
	chnset	SAlpha1, "bypassSwitchOffId"
	chnset	SAlpha0, "ledOnId"
	chnset	SAlpha1, "ledOffId"
	outs	aLeft, aRight
endif

endin
</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
