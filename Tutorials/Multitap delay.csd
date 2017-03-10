<Cabbage>
form caption("Untitled") size(400, 400), pluginID("def1")

groupbox bounds(16, 14, 214, 99), text("Delay Ratios")
groupbox bounds(240, 14, 86, 99), text("Time")
rslider bounds(26, 38, 58, 57), channel("delay1"), range(0, 1, .25, 1, 0.001), text("Delay 1") 
rslider bounds(90, 38, 62, 57), channel("delay2"), range(0, 1, .333, 1, 0.001), text("Delay 2") 
rslider bounds(158, 38, 62, 57), channel("delay3"), range(0, 1, .5, 1, 0.001), text("Delay 3" ) 
rslider bounds(252, 38, 62, 57), channel("delay4"), range(0, 6, 1, 1, 0.001), text("Delay 4"), identchannel("delay4_id")  

groupbox bounds(18, 124, 284, 99), text("Strengths")
rslider bounds(26, 148, 58, 63), channel("str1"), range(0, 1, .5, 1, 0.001), text("1")  
rslider bounds(94, 148, 58, 63), channel("str2"), range(0, 1, .5, 1, 0.001), text("2")  
rslider bounds(162, 148, 58, 63), channel("str3"), range(0, 1, .5, 1, 0.001), text("3") 
rslider bounds(229, 148, 59, 63), channel("str4"), range(0, 1, .5, 1, 0.001), text("4")  
 
rslider bounds(26, 248, 59, 67), channel("feedback"), range(0, 1, .6, 1, 0.001), text("Feedback") 
rslider bounds(98, 248, 59, 67), channel("mix"), range(0, 1, .5, 1, 0.001), text("Mix")  
rslider bounds(172, 248, 59, 67), channel("gain"), range(0, 1, 0.5, 1, 0.001), text("Gain")  
combobox bounds(250, 250, 100, 30), channel("timeChoise"), items("Free range", "Loop time", "Half time")
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

kOff		=			0
kOn			=			1

kGain 		chnget 		"gain"
kDel1		chnget		"delay1"
kDel2 		chnget		"delay2"
kDel3 		chnget		"delay3"
kDel4		chnget		"delay4"

kStr1		chnget		"str1"
kStr2 		chnget		"str2"
kStr3		chnget		"str3"
kStr4		chnget		"str4"

kFB			chnget		"feedback"
kMix		chnget		"mix"

kTChoise	chnget		"timeChoise"

Sname		=			"tabla.wav"
aLoop, aIgn  	diskin2 	Sname, 1, 0, 1
iLen		filelen		Sname

SInactive	sprintfk	"active(%d)", kOff
SActive		sprintfk	"active(%d)", kOn
if kTChoise == 2 then
	kDel4		=			iLen
				chnset		kDel4, "delay4"
				chnset 		SInactive, "delay4_id"
elseif kTChoise == 3 then
	kDel4		=			iLen/2
				chnset		kDel4, "delay4"
				chnset 		SInactive, "delay4_id"
elseif kTChoise == 1 then
				chnset 		SActive, "delay4_id"
endif
aDump		delayr		6
aTap1		deltapi		kDel4 * kDel1
aTap2 		deltapi		kDel4 * kDel2
aTap3 		deltapi		kDel4 * kDel3
aTap4		deltapi		kDel4
			delayw		aLoop + (aTap4 * kFB)
			
aWet		=			(aTap1 * kStr1) + (aTap2 * kStr2) + (aTap3 * kStr3) + (aTap4 * kStr4)

aMix		ntrpol		aLoop, aWet, kMix
			outs 		aMix * kGain, aMix * kGain

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
