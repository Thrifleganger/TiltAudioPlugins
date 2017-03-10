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
kGain		=			.7
kDelTime	=			1
iRatio		=			1/2.57

a1 inch 1
aDel[]		init		10
aMix[]		init		10
kIndex		=			0

#define 	DELAY_TAP(IN ' DELSIG ' TIME ' OUT)
#
aDump		delayr		1
$DELSIG		deltap		$TIME
			delayw		$IN + ($DELSIG * kGain)
			
aNext		=			$DELSIG * (1 - (kGain * kGain))

$OUT		=			aNext + ($IN * (-kGain))
#	

$DELAY_TAP(a1 ' aDel1 ' kDelTime ' aMix1)		
$DELAY_TAP(aMix1 ' aDel2 ' kDelTime*((iRatio)^1) ' aMix2)
$DELAY_TAP(aMix2 ' aDel3 ' kDelTime*((iRatio)^2.1) ' aMix3)
$DELAY_TAP(aMix3 ' aDel4 ' kDelTime*((iRatio)^3.2) ' aMix4)
$DELAY_TAP(aMix4 ' aDel5 ' kDelTime*((iRatio)^4.3) ' aMix5)
$DELAY_TAP(aMix5 ' aDel6 ' kDelTime*((iRatio)^5.4) ' aMix6)
$DELAY_TAP(aMix6 ' aDel7 ' kDelTime*((iRatio)^6.5) ' aMix7)
$DELAY_TAP(aMix7 ' aDel8 ' kDelTime*((iRatio)^7.6) ' aMix8)
$DELAY_TAP(aMix8 ' aDel9 ' kDelTime*((iRatio)^8.7) ' aMix9)

;$DELAY_TAP(aMix6 ' aDel7 ' kDelTime/729 ' aMix7)


;while 	kIndex < 9 do
;	
;	kVal	pow		.333, (kIndex+1)
;	kTime	=	kDelTime * kVal
;	printk2  kIndex
;	$DELAY_TAP(aMix[kIndex] ' aDel[kIndex] ' kTime ' aMix[kIndex + 1])
;	kIndex  = 	kIndex + 1
;
;od
outs aMix8, aMix8
endin
/* * (.333 ^ (kIndex + 1)) */
</CsInstruments>
<CsScore>
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
<bsbPresets>
</bsbPresets>
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
