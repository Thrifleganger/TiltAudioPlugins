
form caption("Doubler") size(879, 700), pluginID("def1"), svgpath(.)
image bounds(0, 0, 779, 700), file("Doubler_Final.png "),  

;Power buttons for voices
image bounds(122, 26, 34, 34), file("PowerButtonOn.png"), identchannel("voice1On")  
image bounds(378, 26, 34, 34), file("PowerButtonOn.png"), identchannel("mainVoiceOn") 
image bounds(630, 24, 34, 34), file("PowerButtonOn.png"), identchannel("voice2On")

image bounds(122, 26, 34, 34), file("PowerButton.png"), identchannel("voice1Off"), alpha(0)  
image bounds(378, 26, 34, 34), file("PowerButton.png"), identchannel("mainVoiceOff"), alpha(0)
image bounds(630, 24, 34, 34), file("PowerButton.png"), identchannel("voice2Off"), alpha(0)

;Popup toggle buttons
image bounds(116, 566, 33, 20), file("ToggleButtonPressed.png")  
image bounds(634, 568, 33, 20), file("ToggleButtonPressed.png")

;Channel accept
checkbox bounds(122, 26, 32, 32), channel("voice1"), shape("circle"), value(1), alpha(0) 
checkbox bounds(378, 26, 32, 32), channel("mainVoice"), shape("circle"), value(1), alpha(0)  
checkbox bounds(630, 24, 32, 32), channel("voice2"), shape("circle"), value(1), alpha(0)

;Voice 1
xypad bounds(62, 100, 171, 151), channel("pan1", "gain1"), rangex(0, 1, 0.1), rangey(-60, 0, -2), text("Pan vs Gain"), colour(58, 238, 255), fontcolour(58, 238, 255), textcolour(58, 238, 255)
xypad bounds(60, 266, 172, 148), channel("delay1", "detune1"), rangex(0, 150, 20), rangey(-100, 100, 20), text("Delay vs Pitch"), colour(58, 238, 255), fontcolour(58, 238, 255), textcolour(58, 238, 255)
numberbox bounds(32, 468, 46, 20), channel("gain1"), range(-60, 0, -2, 1, 0.1), active(0),  fontcolour(58, 238, 255, 255)
numberbox bounds(86, 468, 46, 20), channel("pan1"), range(0, 1, 0.1, 1, .1), active(0), fontcolour(58, 238, 255)
numberbox bounds(194, 468, 46, 20), channel("delay1"), range(0, 150, 20, 1, .1), active(0), fontcolour(58, 238, 255)
numberbox bounds(140, 468, 46, 20), channel("detune1"), range(-100, 100, 20, 1, .1), active(0), fontcolour(58, 238, 255)
rslider bounds(186, 564, 54, 43), channel("highPass1"), range(20, 2000, 20, 1, 0.001)  
rslider bounds(186, 618, 58, 44), channel("lowPass1"), range(2000, 20000, 20000, 1, 0.001)
rslider bounds(30, 550, 60, 61), channel("octave1"), range(-3, 3, 0, 1, 1)
rslider bounds(100, 610, 60, 57), channel("feedback1"), range(0, 1, 0, 1, .001)
button bounds(120, 570, 25, 12), channel("pitchTweak1"), alpha(0)
numberbox bounds(38, 632, 46, 20), channel("octave1"), range(-3, 3, 0, 1, 1), active(0),  fontcolour(58, 238, 255, 255)

;Voice 2
xypad bounds(550, 100, 176, 150), channel("pan2", "gain2"), rangex(0, 1, 0.9), rangey(-60, 0, -2), text("Pan vs Gain"), colour(159, 252, 106), fontcolour(159, 252, 106), textcolour(159, 252, 106)
xypad bounds(552, 262, 175, 153), channel("delay2", "detune2"), rangex(0, 150, 40), rangey(-100, 100, -20), text("Delay vs Pitch"), colour(159, 252, 106), fontcolour(159, 252, 106), textcolour(159, 252, 106)
numberbox bounds(544, 470, 46, 20), channel("gain2"), range(-60, 0, -2, 1, .1), active(0), fontcolour(159, 252, 106)
numberbox bounds(598, 470, 46, 20), channel("pan2"), range(0, 1, 0.9, 1, .1), active(0), fontcolour(159, 252, 106)
numberbox bounds(706, 470, 46, 20), channel("delay2"), range(0, 150, 40, 1, .1), active(0), fontcolour(159, 252, 106)
numberbox bounds(652, 470, 46, 20), channel("detune2"), range(-100, 100, -20, 1, .1), active(0), fontcolour(159, 252, 106)
rslider bounds(542, 564, 54, 43), channel("highPass2"), range(20, 2000, 20, 1, 0.001)  
rslider bounds(542, 618, 54, 45), channel("lowPass2"), range(2000, 20000, 20000, 1, 0.001) 
rslider bounds(695, 550, 59, 64), channel("octave2"), range(-3, 3, 0, 1, 1)
rslider bounds(626, 612, 60, 56), channel("feedback2"), range(0, 1, 0, 1, .001)  
button bounds(636, 570, 27, 13), channel("pitchTweak2"), alpha(0)
numberbox bounds(704, 630, 46, 20), channel("octave2"), range(-3, 3, 0, 1, 1), active(0),  fontcolour(159, 252, 106)

;Input signal (Main Voice)
xypad bounds(306, 104, 176, 150), channel("mainPan", "mainGain"), rangex(0, 1, 0.5), rangey(-60, 0, 0), text("Pan vs Gain"), colour(255, 255, 255), fontcolour(255, 255, 255), textcolour(255, 255, 255)
numberbox bounds(302, 276, 46, 20), channel("mainGain"), range(-60, 0, 0, 1, .1), active(0), fontcolour(255, 255, 255)
numberbox bounds(430, 276, 46, 20), channel("mainPan"), range(0, 1, 0.5, 1, .1), active(0), fontcolour(255, 255, 255)

;Pitch box for Voice 1:
groupbox bounds(1, 19, 750, 256), plant("Pitch Tweak - Voice 1"), colour(20, 20, 20), popup(1), identchannel("popup1") {
image bounds(0, 0, 750, 256), file("Doubler_Popup.png")
image bounds(124, 14, 34, 34), file("PowerButtonOn.png"), identchannel("manualPitch1On"),   
image bounds(356, 14, 34, 34), file("PowerButtonOn.png"), identchannel("pitchMod1On") 
image bounds(592, 12, 34, 34), file("PowerButtonOn.png"), identchannel("randomize1On")

image bounds(124, 14, 34, 34), file("PowerButton.png"), identchannel("manualPitch1Off"), alpha(0)  
image bounds(356, 14, 34, 34), file("PowerButton.png"), identchannel("pitchMod1Off"), alpha(0)
image bounds(592, 12, 34, 34), file("PowerButton.png"), identchannel("randomize1Off"), alpha(0)

image bounds(160, 216, 33, 20), file("ToggleButtonPressed.png"), identchannel("formant1On")
image bounds(160, 216, 33, 20), file("ToggleButton.png"), identchannel("formant1Off"), alpha(0)

rslider bounds(68, 106, 50, 50), channel("semitones1"), range(-12, 12, 0, 1, 1),  
rslider bounds(164, 106, 51, 51), channel("cents1"), range(-100, 100, 0, 1, 1),  
rslider bounds(394, 106, 51, 51), channel("modRate1"), range(0.10000000000000000555, 5, 1, 1, 0.001),  
rslider bounds(298, 106, 51, 51), channel("modDepth1"), range(0, 1, 0, 1, 0.001),  
rslider bounds(628, 106, 50, 50), channel("randomRate1"), range(0.10000000000000000555, 5, 1, 1, 0.001),  
rslider bounds(532, 106, 50, 50), channel("randomRange1"), range(0, 100, 10, 1, 0.001),  

checkbox bounds(128, 16, 27, 24), channel("manualPitch1"), shape("circle"),  value(1), alpha(0) 
checkbox bounds(358, 15, 27, 28), channel("autoPitch1"), shape("circle"), radiogroup("1"), alpha(0), value(1) 
checkbox bounds(594, 16, 27, 24), channel("randomPitch1"), shape("circle"), radiogroup("1"), alpha(0)
button bounds(33, 208, 155, 33), channel("but1"), text("Push", "Push"), alpha(0), popuptext("If on preserves vocal formants. If off sounds unnatural like a Voices of chipmunk") 
checkbox bounds(160, 216, 30, 19), channel("formant1"), value(1), alpha(0)
}

;Pitch box for Voice 2
groupbox bounds(1, 19, 750, 256), plant("Pitch Tweak - Voice 2"), colour(20, 20, 20), popup(1), identchannel("popup2") {
image bounds(0, 0, 750, 256), file("Doubler_Popup.png")
image bounds(124, 14, 34, 34), file("PowerButtonOn.png"), identchannel("manualPitch2On"),   
image bounds(356, 14, 34, 34), file("PowerButtonOn.png"), identchannel("pitchMod2On") 
image bounds(592, 12, 34, 34), file("PowerButtonOn.png"), identchannel("randomize2On")

image bounds(124, 14, 34, 34), file("PowerButton.png"), identchannel("manualPitch2Off"), alpha(0)  
image bounds(356, 14, 34, 34), file("PowerButton.png"), identchannel("pitchMod2Off"), alpha(0)
image bounds(592, 12, 34, 34), file("PowerButton.png"), identchannel("randomize2Off"), alpha(0)

image bounds(160, 216, 33, 20), file("ToggleButtonPressed.png"), identchannel("formant2On")
image bounds(160, 216, 33, 20), file("ToggleButton.png"), identchannel("formant2Off"), alpha(0)

rslider bounds(68, 106, 50, 50), channel("semitones2"), range(-12, 12, 0, 1, 1),  
rslider bounds(164, 106, 51, 51), channel("cents2"), range(-100, 100, 0, 1, 1),  
rslider bounds(394, 106, 51, 51), channel("modRate2"), range(0.10000000000000000555, 5, 1, 1, 0.001),  
rslider bounds(298, 106, 51, 51), channel("modDepth2"), range(0, 1, 0, 1, 0.001),  
rslider bounds(628, 106, 50, 50), channel("randomRate2"), range(0.10000000000000000555, 5, 1, 1, 0.001),  
rslider bounds(532, 106, 50, 50), channel("randomRange2"), range(0, 100, 10, 1, 0.001),  

checkbox bounds(128, 16, 27, 24), channel("manualPitch2"), shape("circle"), value(1), alpha(0) 
checkbox bounds(358, 15, 27, 28), channel("autoPitch2"), shape("circle"), radiogroup("2"), alpha(0), value(1) 
checkbox bounds(594, 16, 27, 24), channel("randomPitch2"), shape("circle"), radiogroup("2"), alpha(0)
button bounds(33, 208, 155, 33), channel("but2"), text("Push", "Push"), alpha(0), popuptext("If on preserves vocal formants. If off sounds unnatural like a Voices of chipmunk") 
checkbox bounds(160, 216, 30, 19), channel("formant2"), value(1), alpha(0)
}

;Mix stage 
rslider bounds(348, 384, 83, 88), channel("mix"), range(0, 1, .5, 1, 0.001)
rslider bounds(286, 572, 77, 71), channel("crossfade1"), range(0, 1, , 1, 0.001)  
rslider bounds(432, 572, 68, 70), channel("crossfade2"), range(0, 1, , 1, 0.001),  
rslider bounds(271, 478, 49, 46), channel("inputGain"), range(-60, 6, , 3, 0.001)  
rslider bounds(464, 480, 49, 46), channel("outputGain"), range(-60, 6, , 3, 0.001)

; Metering widgets
gentable bounds(284, 335, 22, 136), tablenumber(1), amprange(0, 1, 1), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterIn")
gentable bounds(466, 335, 22, 136), tablenumber(2), amprange(0, 1, 2), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterOutL")
gentable bounds(492, 335, 22, 136), tablenumber(3), amprange(0, 1, 3), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterOutR")
  
image bounds(246, 312, 96, 182), file("MeterGrill.png")
image bounds(428, 312, 96, 182), file("MeterGrill.png") 
image bounds(454, 312, 96, 182), file("MeterGrill.png")  
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

; Gen routines for metering
giMeterIn	ftgen 		1, 0, -1, 2, 0
giMeterOutL	ftgen 		2, 0, -1, 2, 0
giMeterOutR	ftgen 		3, 0, -1, 2, 0

instr 1

;Initialize Variables
aCopy1, aCopy2 	init		0

;Channel accept
kVoice1		chnget		"voice1"
kVoice2		chnget		"voice2"
kMainVoice	chnget		"mainVoice"

;Voice 1
kGain1		chnget		"gain1"
kPan1		chnget		"pan1"
kDelay1		chnget		"delay1"
kDetune1	chnget		"detune1"
kHighFreq1	chnget		"highPass1"
kLowFreq1	chnget		"lowPass1"
kOctave1	chnget		"octave1"
kPitchTweak1	chnget		"pitchTweak1"
kFeedback1	chnget		"feedback1"

;Voice 2
kGain2		chnget		"gain2"
kPan2		chnget		"pan2"
kDelay2		chnget		"delay2"
kDetune2	chnget		"detune2"
kHighFreq2	chnget		"highPass2"
kLowFreq2	chnget		"lowPass2"
kOctave2	chnget		"octave2"
kPitchTweak2	chnget		"pitchTweak2"
kFeedback2	chnget		"feedback2"

;Pitch Tweak - Voice 1
kSemitones1	chnget		"semitones1"
kCents1		chnget		"cents1"
kModDepth1	chnget		"modDepth1"
kModRate1	chnget		"modRate1"
kRandRate1	chnget		"randomRate1"
kRandRange1	chnget		"randomRange1"
kManPitch1	chnget		"manualPitch1"
kAutoPitch1	chnget		"autoPitch1"
kRandPitch1	chnget		"randomPitch1"
kFormant1	chnget		"formant1"

;Pitch Tweak - Voice 2
kSemitones2	chnget		"semitones2"
kCents2		chnget		"cents2"
kModDepth2	chnget		"modDepth2"
kModRate2	chnget		"modRate2"
kRandRate2	chnget		"randomRate2"
kRandRange2	chnget		"randomRange2"
kManPitch2	chnget		"manualPitch2"
kAutoPitch2	chnget		"autoPitch2"
kRandPitch2	chnget		"randomPitch2"
kFormant2	chnget		"formant2"

;Main voice
kMainGain	chnget		"mainGain"
kMainPan	chnget		"mainPan"

;Mix Section
kInGain		chnget		"inputGain"
kOutGain		chnget		"outputGain"
kCrossfade1	chnget		"crossfade1"
kCrossfade2	chnget		"crossfade2"
kMix			chnget		"mix"

;kDetune1  	portk		kDetune1, .01
aMono 		inch 		1
aMono		*=			ampdb(kInGain	)	;Apply input gain

;To prevent trigger of popup boxes at start
kForceOn1	init			0
kForceOn2	init			0
iInitXYPad	init			1
kOn			init			1
kOff			init			0
SAlpha0		sprintfk		"alpha(%d)", kOff
SAlpha1		sprintfk		"alpha(%d)", kOn

;Images state change switch for individual Voices
#define SWITCH_STATE(CHANNEL'ID_ON'ID_OFF) #
if ($CHANNEL == 1) then
	chnset	SAlpha0, $ID_OFF
	chnset	SAlpha1, $ID_ON
else
	chnset	SAlpha1, $ID_OFF
	chnset	SAlpha0, $ID_ON
endif
#
$SWITCH_STATE(kVoice1'"voice1On"'"voice1Off")
$SWITCH_STATE(kVoice2'"voice2On"'"voice2Off")
$SWITCH_STATE(kMainVoice'"mainVoiceOn"'"mainVoiceOff")
$SWITCH_STATE(kManPitch1'"manualPitch1On"'"manualPitch1Off")
$SWITCH_STATE(kManPitch2'"manualPitch2On"'"manualPitch2Off")
$SWITCH_STATE(kAutoPitch1'"pitchMod1On"'"pitchMod1Off")
$SWITCH_STATE(kAutoPitch2'"pitchMod2On"'"pitchMod2Off")
$SWITCH_STATE(kRandPitch1'"randomize1On"'"randomize1Off")
$SWITCH_STATE(kRandPitch2'"randomize2On"'"randomize2Off")
$SWITCH_STATE(kFormant1'"formant1On"'"formant1Off")
$SWITCH_STATE(kFormant2'"formant2On"'"formant2Off")

;Initialize number boxes of XY pad variable on first pass. Ignore rest of the time
if (iInitXYPad == 1) then
	chnset .1, "pan1"
	chnset .9, "pan2"
	chnset .5, "mainPan"
	chnset 20, "delay1"
	chnset 40, "delay2"
endif

;Opening Pitch Tweak popup
if changed:k(kPitchTweak1) == 1 then
	kForceOn1 	=		1
	Smess sprintfk "show(%d), pos(1, 19)", kForceOn1
	chnset Smess, "popup1"
	
endif
if changed:k(kPitchTweak2) == 1 then
	kForceOn2 	=		1
	Smess sprintfk "show(%d), pos(1, 19)", kForceOn2
	chnset Smess, "popup2"	
endif

;Pitch shifting:
ifftsize	=			1024
ioverlap	=			ifftsize/8
iwinsize	=			ifftsize
iwintype	=			1

; Voice 1 pitch modification
fMono1		pvsanal		aMono, ifftsize, ioverlap, iwinsize, iwintype
kPitch1		=			octave(kOctave1) * cent(kDetune1) 					; Basic pitch from XY Pad
kPitch1		*= 			(kManPitch1 == 1 ? (semitone(kSemitones1) * cent(kCents1)) : 1)		;If Manual Pitch is turned on
; Generate an LFO for modulating pitch between +- 100 cents, depending on depth and rate
if kAutoPitch1 == 1 then
	kLFO1		poscil		kModDepth1 * 100, kModRate1
	kPitch1 	*=			cent(kLFO1)
endif
; Generate a random spline curve modulating pitch between +- 100 cents max, depending on range and rate
if kRandPitch1 == 1 then
	kRand1		jspline		kRandRange1, kRandRate1, kRandRate1
	kPitch1		*=			cent(kRand1)
endif
; Apply pitchshifting along with formant preservation value
fScale1		pvscale		fMono1, kPitch1, kFormant1
aShift1		pvsynth		fScale1

; Voice 2 pitch modification
fMono2		pvsanal		aMono, ifftsize, ioverlap, iwinsize, iwintype
kPitch2		=			octave(kOctave2) * cent(kDetune2) 					; Basic pitch from XY Pad
kPitch2		*= 			(kManPitch2 == 1 ? (semitone(kSemitones2) * cent(kCents2)) : 1)		;If Manual Pitch is turned on
; Generate an LFO for modulating pitch between +- 100 cents, depending on depth and rate
if kAutoPitch2 == 1 then
	kLFO2		poscil		kModDepth2 * 100, kModRate2
	kPitch2 	*=			cent(kLFO2)
endif
; Generate a random spline curve modulating pitch between +- 100 cents max, depending on range and rate
if kRandPitch2 == 1 then
	kRand2		jspline		kRandRange2, kRandRate2, kRandRate2
	kPitch2		*=			cent(kRand2)
endif
; Apply pitchshifting along with formant preservation value
fScale2		pvscale		fMono2, kPitch2, kFormant2
aShift2		pvsynth		fScale2


; Delay section
if kVoice1 == 1 then
	aCopy1		vdelay 		aShift1 + (aCopy1 * kFeedback1), kDelay1, 200
else
	aCopy1		=			0
endif
if kVoice2 == 1 then
	aCopy2		vdelay 		aShift2 + (aCopy2 * kFeedback2), kDelay2, 200
else
	aCopy2 		=			0
endif
if kMainVoice == 0 then
	aMono		=			0
endif

;Filter section
aCopy1		butlp		aCopy1, kLowFreq1
aCopy1		buthp		aCopy1, kHighFreq1
aCopy2		butlp		aCopy2, kLowFreq2
aCopy2		buthp		aCopy2, kHighFreq2

aMixL		=			(aMono * ampdb(kMainGain) * (1 - kMainPan) * (1 - kMix)) + (aCopy1 * ampdb(kGain1) * (1 - kPan1) + aCopy2 * ampdb(kGain2) * (1 - kPan2)) * kMix
aMixR		=			(aMono * ampdb(kMainGain) * kMainPan * (1 - kMix)) 		 + (aCopy1 * ampdb(kGain1) * kPan1       + aCopy2 * ampdb(kGain2) * kPan2)       * kMix

aMixL		*=			ampdb(kOutGain)
aMixR		*=			ampdb(kOutGain)
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

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
