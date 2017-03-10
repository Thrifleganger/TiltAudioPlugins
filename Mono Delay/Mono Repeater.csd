; Mono delay - Thrifleganger

<Cabbage>
form caption("Mono Delay") size(820, 532), pluginID("def1"), svgpath("./SVGs")

; Background image
image bounds(0, 0, 820, 532), file("Assets/MonoDelay.png") 
; Buttons, switches LEDs and props
image bounds(362, 76, 89, 40), file("Assets/HostButton.png"), alpha(0), identchannel("hostButtonId")
image bounds(362, 76, 89, 40), file("Assets/HostButtonPressed.png"), alpha(0), identchannel("hostButtonPressedId")

image bounds(24, 406, 40, 70), file("Assets/Switch_position_1.png"), alpha(1), identchannel("bypassSwitchOnId")
image bounds(24, 406, 40, 70), file("Assets/Switch_position_2.png"), alpha(0), identchannel("bypassSwitchOffId")

image bounds(368, 32, 78, 47), file("Assets/Switch_side_1.png"), alpha(1), identchannel("switchManualId")
image bounds(368, 32, 78, 47), file("Assets/Switch_side_2.png"), alpha(0), identchannel("switchSyncId")

image bounds(130, 80, 150, 123), file("Assets/TimeManual.png"), alpha(1), identchannel("timeManualId")
image bounds(122, 51, 158, 148), file("Assets/TimeSync.png"), alpha(0), identchannel("timeSyncId")

image bounds(14, 362, 61, 61), file("Assets/LED_on.png"), alpha(1), identchannel("ledOnId")
image bounds(14, 362, 61, 61), file("Assets/LED_off.png"), alpha(0), identchannel("ledOffId")

; Delay functionality widgets
numberbox bounds(356, 226, 40, 20), channel("delayTimeNumBox"), range(30, 3000, 700, 1, 1), identchannel("delayTimeNumBoxIdent"), fontcolour(102, 224, 255)
numberbox bounds(418, 226, 40, 20), channel("bpmNumBox"), range(20, 400, 120, 1, 1), identchannel("bpmNumBoxIdent"), fontcolour(102, 224, 255)
rslider bounds(148, 88, 106, 112), channel("delayTimeSync"), range(0	,10	, 5	, 1	, 1), visible(0), identchannel("delayTimeSyncIdent"), popuptext(0)
rslider bounds(148, 88, 106, 112), channel("delayTimeManual"), range(30, 3000, 700, 1, 1), identchannel("delayTimeManualIdent"), popuptext("0") 
rslider bounds(548, 98, 110, 104), channel("Feedback"), range(0, 1, 0.9000000000000000222, 1, 0.001) 

;Filter widgets
rslider bounds(546, 338, 117, 106), channel("LowpassFrequency"), range(500, 20000, 10000, 1, 0.001) 
rslider bounds(148, 332, 110, 130), channel("HighpassFrequency"), range(20, 2000, 200, 1, 0.001)

; Tempo and synchronization widgets 
button bounds(372, 44, 64, 25), channel("tempoSync"), text("Sync"), colour:1(233, 91, 91, 255), identchannel("tempoSyncIdent"), alpha(0)
button bounds(368, 82, 73, 25), channel("hostTempo"), text("Host"), colour:1(233, 91, 91, 255), identchannel("hostTempoIdent"), value(1), alpha(0)
combobox bounds(354, 300, 106, 27), channel("delayType"), items("Digital", "Ping Pong", "Reverse"), value(2), fontcolour(102, 224, 255)
button bounds(376, 124, 63, 64), channel("tapDelay"), text("Tap"), identchannel("tapDelayIdent"), corners(50), alpha(0)

; Misc widgets
rslider bounds(354, 375, 104, 94), channel("Mix"), range(0, 1, 0.5, 1, 0.001)
button bounds(28, 414, 34, 63), channel("bypass"), text("Push", "Push"), alpha(0), value(1)
rslider bounds(27, 290, 47, 43), channel("Input"), range(-60	, 6	, 0	, 3, 0.001), svgfile("slider", "SVGs/rslider_white.svg")
rslider bounds(739, 290, 47, 43), channel("Output"), range(-60, 6, , 3, 0.001), svgfile("slider", "SVGs/rslider_white.svg")

; Metering widgets
gentable bounds(46, 54, 22, 213), tablenumber(1), amprange(0, 1, 1), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterIn")
gentable bounds(738, 54, 22, 218), tablenumber(2), amprange(0, 1, 2), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterOutL")
gentable bounds(764, 54, 21, 217), tablenumber(3), amprange(0, 1, 3), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterOutR")

image bounds(9, 18, 95, 284), file("Assets/MeterGrill.png")
image bounds(702, 18, 94, 290), file("Assets/MeterGrill.png")
image bounds(728, 18, 92, 290), file("Assets/MeterGrill.png")

combobox bounds(546, 8, 155, 22), channel("combobox"), populate("*.snaps")
filebutton bounds(706, 8, 60, 22), channel("but1"), text("Save"), populate("*.snaps")
</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

; Gen routines for metering
giMeterIn	ftgen 		1, 0, -1, 2, 0
giMeterOutL	ftgen 		2, 0, -1, 2, 0
giMeterOutR	ftgen 		3, 0, -1, 2, 0

; Reverse functionality taken from Iain McCurdy's Reverse example
opcode	Reverse, a, aKk
	ain,ktime,kFeedback	xin			
	
	;four windowing envelopes. An appropriate one will be chosen based on the reversed chunk duration
	ienv1	ftgenonce	0, 0, 131072, 7, 0, 1024, 1, 131072-(1024*2),  1,  1024, 0	;for longest chunk times
	ienv2	ftgenonce	0, 0, 131072, 7, 0, 4096, 1, 131072-(4096*2),  1,  4096, 0
	ienv3	ftgenonce	0, 0, 131072, 7, 0,16384, 1, 131072-(16384*2), 1, 16384, 0
	ienv4	ftgenonce	0, 0, 131072, 7, 0,32768, 1, 131072-(32768*2), 1, 32768, 0	;for shortest chunk times

	atime	interp		ktime
	aptr		phasor		(2/ktime)		;Create a moving phasor that with be used to tap the delay buffer

	if ktime<0.2 then			
		aenv		table3	aptr,ienv4,1		
	elseif ktime<0.4 then
		aenv		table3	aptr,ienv3,1
	elseif ktime<2 then
		aenv		table3	aptr,ienv2,1
	else					;other longest bracket of delay times
		aenv		table3	aptr,ienv1,1
	endif
	
	aptr		=			aptr*atime		;Scale phasor according to the length of the delay time chosen by the user
 
	; Reading and writing from a delay line
 	abuffer	delayr		4 		
	aReverse	deltap3		aptr			
			delayw		ain + (aReverse * kFeedback)			
	
	xout		aReverse * aenv	
endop

instr 1

; Initialize variables
aDelL, aDelR init	 	0
kPrevTime 	init		0
kOn			init		1
kOff		init		0
kTapTempo	init		120

; Input channel
;aMono 		inch 		1
aMono, aD 		diskin		"Blip.wav", 1, 0, 1

kTimeManual	chnget		"delayTimeManual"
kTimeSync	chnget		"delayTimeSync"
kFeedback	chnget		"Feedback"
kMix		chnget		"Mix"
kLowFreq	chnget		"LowpassFrequency"
kHighFreq	chnget		"HighpassFrequency"
kSync		chnget		"tempoSync"
kDelType	chnget		"delayType"
kTapDelTrig	chnget		"tapDelay"
kHost		chnget		"hostTempo"
kTimeNumBox chnget		"delayTimeNumBox"
kBPMNumBox	chnget		"bpmNumBox"
kBypass		chnget		"bypass"
kInGain		chnget		"Input"
kOutGain	chnget		"Output"

;Apply input gain:
aMono		*=			ampdb(kInGain)

; Opacity control strings
SAlpha0		sprintfk	"alpha(%d)", kOff
SAlpha1		sprintfk	"alpha(%d)", kOn

; Do everything only if the isn't bypassed. endif at the end.
if (kBypass == 1) then
	chnset	SAlpha1, "bypassSwitchOnId"
	chnset	SAlpha0, "bypassSwitchOffId"
	chnset	SAlpha1, "ledOnId"
	chnset	SAlpha0, "ledOffId"
	
; Switching Tempo between host and tap tempo.
if kHost == 1 then
	;Delete this::::
	kTempo		=			120		
	;kTempo		chnget		"HOST_BPM"
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
kTime		=		kTimeManual
if (kSyncTrig == 1) then
	reinit SWITCH_TIME_SLIDER	
endif

SWITCH_TIME_SLIDER:
	; If Manual mode delay time selection: 
	if(i(kSync) == 0) then
		kTime	=		kTimeManual
		chnset			"visible(1)", "delayTimeManualIdent"
		chnset			"visible(0)", "delayTimeSyncIdent"
		
		chnset			SAlpha1, "switchManualId"
		chnset			SAlpha0, "switchSyncId"
		chnset			SAlpha1, "timeManualId"
		chnset			SAlpha0, "timeSyncId"
	; If synced mode delay time selection
	elseif (i(kSync) == 1) then
		kTime	=		kTimeSync
		chnset			"visible(0)", "delayTimeManualIdent"
		chnset			"visible(1)", "delayTimeSyncIdent"
		
		chnset			SAlpha0, "switchManualId"
		chnset			SAlpha1, "switchSyncId"
		chnset			SAlpha0, "timeManualId"
		chnset			SAlpha1, "timeSyncId"
	endif	
rireturn

#define TIME_CALC(FACTOR) #
kTime	=		(60/kTempo) * $FACTOR * 1000
#

if kSync == 1 then
	if kTime == 0 then
		$TIME_CALC(1/4)
	elseif kTime == 1 then
		$TIME_CALC(1/3)
	elseif kTime == 2 then
		$TIME_CALC(1/2)
	elseif kTime == 3 then
		$TIME_CALC(1/1.5)
	elseif kTime == 4 then
		$TIME_CALC(1/1.33333333)
	elseif kTime == 5 then
		$TIME_CALC(1)
	elseif kTime == 6 then
		$TIME_CALC(1.3333333333)
	elseif kTime == 7 then
		$TIME_CALC(1.5)
	elseif kTime == 8 then
		$TIME_CALC(2)
	elseif kTime == 9 then
		$TIME_CALC(3)
	elseif kTime == 10 then
		$TIME_CALC(4)
	endif
endif


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
	kCurrTime	timeinsts
	kTimeDiff 		=		(kCurrTime - kPrevTime)
	if (kTimeDiff < 3) then
		kTapTempo 	=			60/kTimeDiff	
	endif
	kPrevTime	timeinsts	
endif
	
;Setting delay time in  number box

if kSync == 0 then		
	kNumBoxChange	changed		kTimeNumBox
	if kNumBoxChange == 1 then
		chnset		kTimeNumBox, "delayTimeManual"
		kTime		= 	kTimeNumBox
		kTimeManual = 	kTimeNumBox
	endif
endif
chnset		kTime,"delayTimeNumBox"

kTime		portk			kTime, .2
; Delay and feedback network
if kDelType == 1 then
	aDump		delayr		10
	aDelL		deltapi		kTime / 1000
				delayw		(aMono + (aDelL * kFeedback))
	aDump		delayr		10
	aDelR		deltapi		kTime / 1000
				delayw		(aMono + (aDelR * kFeedback))
	;aDelL		vdelay		(aMono + (aDelL * kFeedback)), kTime, 10000
	;aDelR		vdelay		(aMono + (aDelR * kFeedback)), kTime, 10000
elseif kDelType == 2 then
	aDelL		vdelay		(aMono + (aDelR * kFeedback)), kTime, 10000
	aDelR		vdelay		((aDelL * kFeedback)), kTime, 10000
elseif kDelType == 3 then
	aDelL		Reverse		aMono, kTime / 1000, kFeedback
	aDelR		=			aDelL
endif

; Low and High pass filtering
aDelL		butlp		aDelL, kLowFreq
aDelL		buthp		aDelL, kHighFreq
aDelR		butlp		aDelR, kLowFreq
aDelR		buthp		aDelR, kHighFreq
										
; Mix stage										
aMixL		=			((aMono * (1 - kMix)) + (aDelL * kMix)) * ampdb(kOutGain)
aMixR		=			((aMono * (1 - kMix)) + (aDelR * kMix)) * ampdb(kOutGain)

			outs 		aMixL, aMixR

; Write Metering data
kMeterIn 	rms 		aMono
kMeterIn	=			(60-abs(dbamp(kMeterIn)))/60
kMeterOutL 	rms 		aMixL
kMeterOutL	=			(60-abs(dbamp(kMeterOutL)))/60
kMeterOutR 	rms 		aMixR
kMeterOutR	=			(60-abs(dbamp(kMeterOutR)))/60

if metro(20) == 1 then
  	tablew  	kMeterIn, k(0), giMeterIn
	tablew 		kMeterOutL, k(0), giMeterOutL
	tablew 		kMeterOutR, k(0), giMeterOutR
  	chnset 		"tablenumber(1)", "vuMeterIn" 		
	chnset 		"tablenumber(2)", "vuMeterOutL" 		
	chnset 		"tablenumber(3)", "vuMeterOutR" 		
endif


; When effect is bypassed:
else
	chnset	SAlpha0, "bypassSwitchOnId"
	chnset	SAlpha1, "bypassSwitchOffId"
	chnset	SAlpha0, "ledOnId"
	chnset	SAlpha1, "ledOffId"
	outs	aMono, aMono
endif

endin

</CsInstruments>
<CsScore>
f0 z
i1 0 z
</CsScore>
</CsoundSynthesizer>
 