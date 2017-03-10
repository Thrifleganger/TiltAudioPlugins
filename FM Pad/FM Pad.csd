
form caption("Untitled") size(500, 300), pluginID("def1")
keyboard bounds(34, 170, 381, 95)
groupbox bounds(32, 4, 86, 150), corners("10"), text("FM 1"),  
groupbox bounds(130, 4, 86, 149), corners(10), text("FM 2"),  
groupbox bounds(230, 4, 86, 150), corners(10), text("FM 3"),  
groupbox bounds(330, 4, 86, 150), corners(10), text("FM 4"),  
rslider bounds(50, 36, 50, 50), channel("index1"), range(0	, 10	, 5	, 1, 0.001), text("Index 1"),  
rslider bounds(148, 36, 50, 50), channel("index2"), range(0	, 10	, 5	, 1, 0.001), text("Index 2"),  
rslider bounds(248, 36, 50, 50), channel("index3"), range(0	, 10	, 5	, 1, 0.001), text("Index 3"),  
rslider bounds(348, 34, 50, 50), channel("index4"), range(0	, 10	, 5	, 1, 0.001), text("Index 4"),  

rslider bounds(52, 94, 50, 57), channel("ratio1"), range(1, 5	, 2, 1, 0.2), text("Ratio 1"),  
rslider bounds(148, 94, 50, 57), channel("ratio2"), range(1, 5	, 2, 1, 0.2), text("Ratio 2"),  
rslider bounds(250, 92, 50, 57), channel("ratio3"), range(1, 5	, 2, 1, 0.2), text("Ratio 3"),  
rslider bounds(350, 92, 50, 57), channel("ratio4"), range(1, 5	, 2, 1, 0.2), text("Ratio 4"),  
filebutton bounds(214, 268, 60, 25), channel("but1"), text("Save"), populate("*.snaps")

combobox bounds(34, 266, 131, 30), channel("combobox"), populate("*.snaps")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

;instrument will be triggered by keyboard widget
instr 1
kGain		=			.1
kEnv madsr .1, .2, .6, .4
kFreq		=			p4

klfo1		poscil		.5, .5
klfo1		+=			.5

klfo2		poscil		.5, .2
klfo2		+=			.5

klfo3		poscil		.5, .7
klfo3		+=			.5

aEnv1		expseg		.001, 2, 1, 10, 2, 20, 2.5
aEnv2		expseg		.001, 1, 1, 10, 2, 20, 2.5
aEnv3		expseg		.001, 3, 1.5, 10, 2, 20, 2.5

;Modulator 1
kIndex1		chnget		"index1"
kRatio1		chnget		"ratio1"
aMod1		poscil		kFreq*kIndex1*klfo2*aEnv1, kFreq*kRatio1

;Modulator 2
kIndex2 	chnget		"index2"
kRatio2		chnget		"ratio2"
aMod2		poscil		kFreq*kIndex2*klfo3*aEnv2, kFreq*kRatio2

;Modulator 3
kIndex3 	chnget		"index3"
kRatio3		chnget		"ratio3"
aMod3		poscil		kFreq*kIndex3*klfo1*aEnv3, kFreq*kRatio3

;Modulator 4
kIndex4 	chnget		"index4"
kRatio4		chnget		"ratio4"
aMod4		poscil		kFreq*kIndex4*aEnv1, kFreq*kRatio4 + aMod3



aCarr1 		poscil 		p5, p4 + aMod1 + aMod2

aCarr2		poscil		p5, p4 + aMod4

aOut		=			aCarr2 + aCarr1

			outs aOut*kEnv*kGain, aOut*kEnv*kGain
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
