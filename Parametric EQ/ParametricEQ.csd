; 3 - Band Parametroc Equalizer
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Author: thrifleganger
; Descroption: A simple parametric equalizer which controls a 20db variable gain across three band peaking filters, 2 shelf filters and a low and high pass filter.

<Cabbage>
form caption("Parametric Equalizer") size(1002, 277), pluginID("def1"), svgpath("./SVGs")
image bounds(0, 0, 1001, 276), corners(0), file("Assets/EQ-Panel-mount.png")

rslider bounds(362, 40, 68, 50), channel("LowFrequency"), range(50, 500, 200, 1, 0.001), svgfile("slider","SVGs/rslider_white.svg"), trackercolour(159, 0, 0, 255)
rslider bounds(261, 40, 77, 50), channel("LowQ"), range(0.69999999999999995559, 10, 1, 0.5, 0.001), svgfile("slider","SVGs/rslider_white.svg"),  trackercolour(159, 0, 0, 255) 
rslider bounds(315, 129	, 72, 62), channel("LowGain"), range(-20, 20, , 1, 0.001), svgfile("slider","SVGs/rslider_black.svg"),  trackercolour(159, 0, 0, 255) 
rslider bounds(559, 137, 64, 50), channel("MidFrequency"), range(450, 2500, 1600, 1, 0.001), svgfile("slider","SVGs/rslider_white.svg"),  trackercolour(159, 0, 0, 255) 
rslider bounds(459, 136, 63, 50), channel("MidQ"), range(0.69999999999999995559, 10, 1, 0.5, 0.001), svgfile("slider","SVGs/rslider_white.svg"),  trackercolour(159, 0, 0, 255) 
rslider bounds(508, 40, 68, 62), channel("MidGain"), range(-20, 20, , 1, 0.001),  svgfile("slider","SVGs/rslider_black.svg")    ,trackercolour(159, 0, 0, 255)
rslider bounds(743, 40, 66, 50), channel("HighFrequency"), range(2000, 16000, 5000, 1, 0.001), svgfile("slider","SVGs/rslider_white.svg"),  trackercolour(159, 0, 0, 255) 
rslider bounds(646, 40, 67, 50), channel("HighQ"), range(0.80000000000000004441, 10, 1, 0.5, 0.001),  svgfile("slider","SVGs/rslider_white.svg")   ,trackercolour(159, 0, 0, 255) 
rslider bounds(690, 129, 82, 62), channel("HighGain"), range(-20, 20, , 1, 0.001),  svgfile("slider","SVGs/rslider_black.svg")    ,trackercolour(159, 0, 0, 255)
  
combobox bounds(8, 246, 155, 22), channel("combobox"), populate("*.snaps")
filebutton bounds(176, 248, 60, 22), channel("but1"), text("Save"), populate("*.snaps")
image bounds(36, 68, 56, 93), file("Assets/Switch_position_2.png"), alpha(1), identchannel("switch_off")  
image bounds(36, 68, 56, 93), file("Assets/Switch_position_1.png"), alpha(0), identchannel("switch_on")
image bounds(22, 0, 85, 85), file("Assets/LED_on.png"), identchannel("led_on")  
image bounds(22, 0, 85, 85), file("Assets/LED_off.png"), identchannel("led_off")
checkbox bounds(36, 68, 56, 93), channel("bypass"), shape("circle"), alpha(0),  value(1) 
 
rslider bounds(172, 128, 63, 62), channel("LowShelfGain"), range(-20, 20, 0, 1, 0.001),  svgfile("slider","SVGs/rslider_black.svg")    ,trackercolour(159, 0, 0, 255)
rslider bounds(849, 130, 63, 62), channel("HighShelfGain"), range(-20, 20, , 1, 0.001),  svgfile("slider","SVGs/rslider_black.svg")    ,trackercolour(159, 0, 0, 255)
rslider bounds(124, 40, 71, 62), channel("LowShelfFrequency"), range(15, 400, 305, 1, 0.001), svgfile("slider","SVGs/rslider_blue.svg")    ,trackercolour(159, 0, 0, 255)
rslider bounds(109, 127, 39, 38), channel("LowCutOff"), range(0, 500, , 1, 0.001), svgfile("slider","SVGs/rslider_blue.svg"),  trackercolour(159, 0, 0, 255) 
rslider bounds(900, 40, 68, 62), channel("HighShelfFrequency"), range(2000, 16000, 10000, 1, 0.001),  svgfile("slider","SVGs/rslider_blue.svg")    ,trackercolour(159, 0, 0, 255)
rslider bounds(940, 128, 39, 38), channel("hcoFreq"), range(5000	, 20000	, 20000, 1, 0.001),  svgfile("slider","SVGs/rslider_blue.svg")    ,trackercolour(159, 0, 0, 255)
button bounds(250, 246, 85, 25), channel("toneButton"), text("Play Tone","Stop Tone")  
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
kBypass		chnget 		"bypass"
kToneButton	chnget		"toneButton"
;Band 1 : Lows
klmFreq		chnget		"LowFrequency"
klmQ		chnget		"LowQ"
klmLevel	chnget		"LowGain"
;Band 2 : Mids
kmFreq		chnget		"MidFrequency"
kmQ			chnget		"MidQ"
kmLevel		chnget		"MidGain"
;Band 3 : Highs
khmFreq		chnget		"HighFrequency"
khmQ		chnget		"HighQ"
khmLevel	chnget		"HighGain"
;Low Shelf
klsFreq		chnget		"LowShelfFrequency"
klsLevel	chnget		"LowShelfGain"
;High Shelf
khsFreq		chnget		"HighShelfFrequency"
khsLevel	chnget		"HighShelfGain"
;CutOff filters
klcoFreq	chnget		"LowCutOff"
khcoFreq	chnget		"hcoFreq"

;Left and Right input channels
;aLeft		inch 		1
;aRight		inch 		2
aLeft, aRight 	ins

;Test tone - White noise
aSig		rand		.1

printk2 	kToneButton

if ( kBypass == 1 ) then

	#define applyFilter(SIGNAL) #
	$SIGNAL		rbjeq 		$SIGNAL, klmFreq, ampdb(klmLevel), klmQ, 1, 8			;Low Band Filter
	$SIGNAL		rbjeq 		$SIGNAL, kmFreq, ampdb(kmLevel), kmQ, 1, 8				;Mid Band Filter
	$SIGNAL		rbjeq 		$SIGNAL, khmFreq, ampdb(khmLevel), khmQ, 1, 8			;High Band Filter
	$SIGNAL		rbjeq		$SIGNAL, klsFreq, ampdb(klsLevel), 1, .7, 10			;Low Shelf Filter
	$SIGNAL		rbjeq		$SIGNAL, khsFreq, ampdb(khsLevel), 1, .7, 12			;High Shelf Filter
	$SIGNAL 	butlp		$SIGNAL, khcoFreq										;Treble cutoff filter
	$SIGNAL		buthp		$SIGNAL, klcoFreq			
	#
	
	if ( kToneButton == 1 ) then
		$applyFilter(aSig)
	else
		$applyFilter(aLeft)
		$applyFilter(aRight)
	endif

endif

if ( kToneButton == 1 ) then
			outs		aSig*.3, aSig*.3
else
			outs		aLeft, aRight
endif

endin



instr 99

kBypass		chnget		"bypass"

if (kBypass == 1) then
			chnset		"alpha(0)","switch_off"
			chnset		"alpha(1)","switch_on"
			chnset		"alpha(0)","led_off"
			chnset		"alpha(1)","led_on"
elseif (kBypass == 0) then
			chnset		"alpha(0)","switch_on"
			chnset		"alpha(1)","switch_off"
			chnset		"alpha(0)","led_on"
			chnset		"alpha(1)","led_off"

endif 			

endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i 99 0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 

;i 1 0 5
</CsScore>
</CsoundSynthesizer>
