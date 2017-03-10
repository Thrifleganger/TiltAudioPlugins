; LED Metering 
; Written by Thrifleganger
; Description: LED Metering simulation using checkbox widgets. The led's are placed inside plants which are completely resizable.
; User input: 
;		Sensitivity: Decrease threshold for triggering led's. Should really be used with decibels only. For Db mode, set sensitivity very low for responsive behavior.
;		Type: Either select Amplitude scale (0 - 1) or Db scale ( -120 to 0 )
;		If more LED's need to be introduced, change value of iNumLeds

; Area for improvement: Use channelarrays instead for cleaner cabbage code. But there was difficulty setting checkbox value and oncolour with when using channelarrays. 
;						Possible Cabbage bug.
<Cabbage>
form caption("Metering") size(400, 300), pluginID("def1")

; Left channel LED Plant 
groupbox bounds(116, 16, 53, 182),  colour(35, 35, 35, 0), plant("ledPlant1"){
#define COMMON ,corners(3), colour:0(150, 150, 150, 200), value(0)
checkbox bounds(0, 0, 53, 10), 		colour:1(255, 0, 0, 200),  		channel("Lled1"), 	identchannel("Lled_ident1") , 	 $COMMON
checkbox bounds(0, 12, 53, 10), 	colour:1(255, 0, 0, 200), 		channel("Lled2"), 	identchannel("Lled_ident2") ,    $COMMON
checkbox bounds(0, 24, 53, 10), 	colour:1(255, 69, 0, 200), 		channel("Lled3"), 	identchannel("Lled_ident3") ,    $COMMON
checkbox bounds(0, 36, 53, 10), 	colour:1(255, 140, 0, 200),		channel("Lled4"),	identchannel("Lled_ident4") ,    $COMMON
checkbox bounds(0, 48, 53, 10), 	colour:1(255, 215, 0, 200),		channel("Lled5"), 	identchannel("Lled_ident5") ,    $COMMON
checkbox bounds(0, 60, 53, 10), 	colour:1(173, 255, 47, 200), 	channel("Lled6"),	identchannel("Lled_ident6") ,    $COMMON
checkbox bounds(0, 72, 53, 10), 	colour:1(173, 255, 47, 200), 	channel("Lled7"), 	identchannel("Lled_ident7") ,    $COMMON
checkbox bounds(0, 84, 53, 10), 	colour:1(124, 252, 0, 200), 	channel("Lled8"), 	identchannel("Lled_ident8") ,    $COMMON
checkbox bounds(0, 96, 53, 10), 	colour:1(124, 252, 0, 200), 	channel("Lled9"), 	identchannel("Lled_ident9") ,    $COMMON
checkbox bounds(0, 108, 53, 10), 	colour:1(0,255,34, 200), 		channel("Lled10"), 	identchannel("Lled_ident10"),    $COMMON
checkbox bounds(0, 120, 53, 10), 	colour:1(0,255,34, 200), 		channel("Lled11"), 	identchannel("Lled_ident11"),    $COMMON
checkbox bounds(0, 132, 53, 10), 	colour:1(0,255,34, 200), 		channel("Lled12"), 	identchannel("Lled_ident12"),    $COMMON
checkbox bounds(0, 144, 53, 10), 	colour:1(0,255,34, 200), 		channel("Lled13"), 	identchannel("Lled_ident13"),    $COMMON
checkbox bounds(0, 156, 53, 10), 	colour:1(0,255,34, 200), 		channel("Lled14"), 	identchannel("Lled_ident14"),    $COMMON
checkbox bounds(0, 168, 53, 10), 	colour:1(0,255,34, 200), 		channel("Lled15"), 	identchannel("Lled_ident15"),    $COMMON
}

; Right channel LED plant
groupbox bounds(184, 16, 53, 182),  colour(35, 35, 35, 0), plant("ledPlant1"){
#define COMMON ,corners(3), colour:0(150, 150, 150, 200), value(0)
checkbox bounds(0, 0, 53, 10), 		colour:1(255, 0, 0, 200),  		channel("Rled1"), 	identchannel("Rled_ident1") , 	 $COMMON
checkbox bounds(0, 12, 53, 10), 	colour:1(255, 0, 0, 200), 		channel("Rled2"), 	identchannel("Rled_ident2") ,    $COMMON
checkbox bounds(0, 24, 53, 10), 	colour:1(255, 69, 0, 200), 		channel("Rled3"), 	identchannel("Rled_ident3") ,    $COMMON
checkbox bounds(0, 36, 53, 10), 	colour:1(255, 140, 0, 200),		channel("Rled4"),	identchannel("Rled_ident4") ,    $COMMON
checkbox bounds(0, 48, 53, 10), 	colour:1(255, 215, 0, 200),		channel("Rled5"), 	identchannel("Rled_ident5") ,    $COMMON
checkbox bounds(0, 60, 53, 10), 	colour:1(173, 255, 47, 200), 	channel("Rled6"),	identchannel("Rled_ident6") ,    $COMMON
checkbox bounds(0, 72, 53, 10), 	colour:1(173, 255, 47, 200), 	channel("Rled7"), 	identchannel("Rled_ident7") ,    $COMMON
checkbox bounds(0, 84, 53, 10), 	colour:1(124, 252, 0, 200), 	channel("Rled8"), 	identchannel("Rled_ident8") ,    $COMMON
checkbox bounds(0, 96, 53, 10), 	colour:1(124, 252, 0, 200), 	channel("Rled9"), 	identchannel("Rled_ident9") ,    $COMMON
checkbox bounds(0, 108, 53, 10), 	colour:1(0,255,34, 200), 		channel("Rled10"), 	identchannel("Rled_ident10"),    $COMMON
checkbox bounds(0, 120, 53, 10), 	colour:1(0,255,34, 200), 		channel("Rled11"), 	identchannel("Rled_ident11"),    $COMMON
checkbox bounds(0, 132, 53, 10), 	colour:1(0,255,34, 200), 		channel("Rled12"), 	identchannel("Rled_ident12"),    $COMMON
checkbox bounds(0, 144, 53, 10), 	colour:1(0,255,34, 200), 		channel("Rled13"), 	identchannel("Rled_ident13"),    $COMMON
checkbox bounds(0, 156, 53, 10), 	colour:1(0,255,34, 200), 		channel("Rled14"), 	identchannel("Rled_ident14"),    $COMMON
checkbox bounds(0, 168, 53, 10), 	colour:1(0,255,34, 200), 		channel("Rled15"), 	identchannel("Rled_ident15"),    $COMMON
}

rslider bounds(290, 18, 63, 63), channel("sense"), range(0, 1, 1, 1, 0.001), text("Sensitivity"),  
combobox bounds(272, 98, 100, 30), channel("type"), items("Amp", "Db")
label bounds(118, 206, 50, 15), text("Left"),  
label bounds(186, 206, 50, 15), text("Right"),  
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
kGain		chnget		"gain"
kSense		chnget		"sense"
kType		chnget		"type"

a1 inch 1
a2 inch 2

; Use RMS amplitube instead of instantaneous amplitude
kThreshL 	rms			a1
kThreshR 	rms			a2

; Number of LEDs
iNumLeds	=			15
kLedSet1[]	init		iNumLeds
kLedSet2[] 	init		iNumLeds

; Macro for initializing arrays with LED channels
#define INITIALIZE_ARRAY(LED_ARRAY'CHANNEL) #
kIndex		=			0
while kIndex < iNumLeds do
	$LED_ARRAY[kIndex]	chnget		sprintfk("$CHANNEL%d", kIndex+1)
	kIndex				= 			kIndex+1
od
#

$INITIALIZE_ARRAY(kLedSet1'Lled)
$INITIALIZE_ARRAY(kLedSet2'Rled)

; If Db is selected, convert to DB scale
if(kType == 2) then
kThreshL 	=			dbamp(kThreshL)
kThreshR 	=			dbamp(kThreshR)
kSense		=			dbamp(kSense)
endif

; Macro for LED behaviour
#define ACTIVATE_LED(IDENT'THRESHOLD) #
kIndex		=			iNumLeds - 1
while kIndex > -1 do
	if ($THRESHOLD >= kSense - (kType == 1 ? kIndex/iNumLeds : dbamp(kIndex/iNumLeds))) then
		chnset "value(1)", sprintfk("$IDENT%d", kIndex+1)
	else
		chnset "value(0)", sprintfk("$IDENT%d", kIndex+1)
	endif
		
	kIndex = kIndex - 1
od
#

$ACTIVATE_LED(Lled_ident'kThreshL)
$ACTIVATE_LED(Rled_ident'kThreshR)

	outs 	a1*.1, a2*.1
endin


</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
