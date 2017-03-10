<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(30, 40, 62, 64), channel("gain"), range(0, 1, 0.7, 1, 0.001), text("Gain"),  
rslider bounds(100, 41, 65, 63), channel("deltime"), range(0, 2, 1, 1, 0.001), text("DelTime"),  
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
kGain chnget "gain"

kGain		chnget		"gain"
kDelTime	chnget		"deltime"

a1 inch 1
aDel[]		init		10
aMix[]		init		10
kIndex		=			0

#define 	DELAY_TAP(IN ' DELSIG ' TIME ' OUT)
#
aDump		delayr		5
$DELSIG		deltap		$TIME
			delayw		$IN + ($DELSIG * kGain)
			
$DELSIG		=			$DELSIG * (1 - (kGain * kGain))

$OUT		=			$DELSIG + ($IN * (-kGain))
#	

$DELAY_TAP(a1 ' aDel1 ' kDelTime ' aMix[kIndex])		

while 	kIndex < 9 do
	
	kVal	pow		.333, kIndex+1
	kTime	=	kDelTime * kVal
	printk .4, kTime
	$DELAY_TAP(aMix[kIndex] ' aDel[kIndex] ' kTime ' aMix[kIndex + 1])
	kIndex += 1

od
outs aMix[9]*kGain, aMix[9]*kGain
endin
/* * (.333 ^ (kIndex + 1)) */
</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
