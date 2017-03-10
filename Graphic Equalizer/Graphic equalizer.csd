<Cabbage>
form caption("Feedback Buster") size(400, 300), pluginID("def1")
rslider bounds(296, 188, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

checkbox bounds(273, 128, 80, 20), channel("checkbox"), text("checkbox"), identchannel("check1")


groupbox bounds(156, 16, 53, 200),  colour(35, 35, 35, 0), plant("ledPlant1"){
checkbox bounds(0, 0, 53, 10), corners(3), colour:1(255, 0, 0, 200), colour:0(150, 150, 150, 200), value(0), channel("led1"), identchannel("led_ident1")
checkbox bounds(0, 12, 53, 10), corners(3), colour:1(255, 0, 0, 200), colour:0(150, 150, 150, 200), value(0), channel("led2"), identchannel("led_ident2")
checkbox bounds(0, 24, 53, 10), corners(3), colour:1(255, 69, 0, 200), colour:0(150, 150, 150, 200), value(0), channel("led3"), identchannel("led_ident3")
checkbox bounds(0, 36, 53, 10), corners(3), colour:1(255, 140, 0, 200), colour:0(150, 150, 150, 200), value(0), channel("led4"), identchannel("led_ident4")
checkbox bounds(0, 48, 53, 10), corners(3), colour:1(255, 215, 0, 200), colour:0(150, 150, 150, 200), value(0), channel("led5"), identchannel("led_ident5")
checkbox bounds(0, 60, 53, 10), corners(3), colour:1(173, 255, 47, 200), colour:0(150, 150, 150, 200), value(0), channel("led6"), identchannel("led_ident6")
checkbox bounds(0, 72, 53, 10), corners(3), colour:1(173, 255, 47, 200), colour:0(150, 150, 150, 200), value(0), channel("led7"), identchannel("led_ident7")
checkbox bounds(0, 84, 53, 10), corners(3), colour:1(124, 252, 0, 200), colour:0(150, 150, 150, 200), value(0), channel("led8"), identchannel("led_ident8")
checkbox bounds(0, 96, 53, 10), corners(3), colour:1(124, 252, 0, 200), colour:0(150, 150, 150, 200), value(0), channel("led9"), identchannel("led_ident9")
checkbox bounds(0, 108, 53, 10), corners(3), colour:1(0,255,34, 200), colour:0(150, 150, 150, 200), value(0), channel("led10"), identchannel("led_ident10")
checkbox bounds(0, 120, 53, 10), corners(3), colour:1(0,255,34, 200), colour:0(150, 150, 150, 200), value(0), channel("led11"), identchannel("led_ident11")
checkbox bounds(0, 132, 53, 10), corners(3), colour:1(0,255,34, 200), colour:0(150, 150, 150, 200), value(0), channel("led12"), identchannel("led_ident12")
checkbox bounds(0, 144, 53, 10), corners(3), colour:1(0,255,34, 200), colour:0(150, 150, 150, 200), value(0), channel("led13"), identchannel("led_ident13")
checkbox bounds(0, 156, 53, 10), corners(3), colour:1(0,255,34, 200), colour:0(150, 150, 150, 200), value(0), channel("led14"), identchannel("led_ident14")
checkbox bounds(0, 168, 53, 10), corners(3), colour:1(0,255,34, 200), colour:0(150, 150, 150, 200), value(0), channel("led15"), identchannel("led_ident15")
}

checkbox bounds(0, 0, 53, 10), corners(3), colour:1(150, 150, 150, 200), value(1), channelarray("ledArray1",15)
;checkbox bounds(0, 0, 53, 10), corners(3), colour:0(150, 150, 150, 200), value(1), channelarray("led",15)

rslider bounds(310, 0, 63, 63), channel("sense"), range(0, 1, 1, 1, 0.001), text("Sensitivity"),  
combobox bounds(26, 248, 100, 30), channel("type"), items("Amp", "Db")
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
;a2 inch 2
aNoise		rand		kGain
kThresh 	rms			a1

kLedSet1[]	init		15
kLedSet2[] 	init		15

#define INITIALIZE_ARRAY(LED_ARRAY'CHANNEL) #
kIndex		=			0
while kIndex < 15 do
	$LED_ARRAY[kIndex]	chnget		sprintfk("$CHANNEL%d", kIndex+1)
	kIndex				= 			kIndex+1
od
#

$INITIALIZE_ARRAY(kLedSet1'led)
$INITIALIZE_ARRAY(kLedSet2'ledArray1)

if(kType == 2) then
kThresh 	=			dbamp(kThresh)
kSense		=			dbamp(kSense)
endif

;printk  1,kThresh
;printk	1,kSense

#define ACTIVATE_LED(IDENT) #
kIndex		=			14
while kIndex > -1 do
	if (kThresh >= kSense - (kType == 1 ? kIndex/15 : dbamp(kIndex/15))) then
		chnset "value(1)", sprintfk("$IDENT%d", kIndex+1)
	else
		chnset "value(0)", sprintfk("$IDENT%d", kIndex+1)
	endif
		
	kIndex = kIndex - 1
od
#

$ACTIVATE_LED(led_ident)
;$ACTIVATE_LED(ledArray1_ident)

;if (kThresh > 1 - iled1/15 ) then
;		S2 sprintfk "check1", iled1
;		chnset "value(0)", "led_ident12"
;else	
;		S2 sprintfk "check1", iled1
;		chnset "value(1)", "led_ident12"
;endif
;until  iCnt > 15 do
;	if(kThresh > iCnt/15) then
;    	S2 sprintfk "led_ident%d", 14 - iCnt
;		chnset "value(0)", S2
;	endif
;	iCnt = iCnt+1
;enduntil	




;outs a1*kGain, a2*kGain
endin


instr 2

iCnt init 0

#define	ARRANGE_LED(IDENT) #
iCnt	=	0
kMetro metro 1
    until iCnt > 15 do
        S1 sprintfk "pos(0, %d)", (iCnt*12)
        S2 sprintfk "$IDENT%d", iCnt+1
        if iCnt < 2 then
        	S1 strcat	S1, ",colour:0(255, 0, 0, 200)"
        elseif iCnt == 2 then
        	S1 strcat	S1, ",colour:0(255, 69, 0, 200)"
        elseif iCnt == 3 then
        	S1 strcat	S1, ",colour:0(255, 140, 0, 200)"
        elseif iCnt == 4 then
        	S1 strcat	S1, ",colour:0(255, 215, 0, 200)"
        elseif iCnt > 4 && iCnt < 7 then
        	S1 strcat	S1, ",colour:0(173, 255, 47, 200)"
        elseif iCnt > 6 && iCnt < 10 then
        	S1 strcat	S1, ",colour:0(124, 252, 0, 200)"
        else
        	S1 strcat	S1, ",colour:0(0,255,34, 200)"
        endif
        chnset S1, S2
        iCnt=iCnt+1
    enduntil  
#

$ARRANGE_LED(ledArray1_ident)           
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
i2 0 z
</CsScore>
</CsoundSynthesizer>
