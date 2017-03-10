<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1.0

giTrumpetp		ftgen		1, 0, 2^12, 10, 0.38, 0.86, 0.08, 0.25, 0.09, 0.06, 0.01, 0.01, 0.00, 0.01
giTrumpetff		ftgen		2, 0, 2^12, 10, 0.11, 0.39, 0.2, 0.27, 0.77, 0.22, 0.32, 0.36, 0.11, 0.23, 0.27, 0.28, 0.22, 0.15, 0.1, 0.07, 0.07, 0.06, 0.04, 0.04, 0.04, 0.04, 0.04, 0.03, 0.03
giResult		ftgen		4, 0, 2^12, 10, 1
giMorph			ftgen		3, 0, 2, -2, giTrumpetp, giTrumpetff

instr 1

iRand		random      -40, 40
iAtt		=			.6
iRel		=			.5
iDur		=			p3
kFreq		=			cpsmidinn(p4)
kEnv		expseg		.01, iAtt, .2, iDur/2 - iAtt, 1, (iDur/2 - iRel), .2, iRel, .01

kVol		rspline	    .2, 1, .2, 1	
kPitch		rspline		0, 20, .2, 1
kRate		rspline		.5, 4, .2, 1

kVib		poscil		kPitch, 3

kIndex		linseg		0, iDur/2, 1, iDur/2, 0
			ftmorf		kIndex, giMorph, giResult
aSig		poscil		.5, kFreq * cent(iRand)* cent(kVib), giResult
			out 		aSig*kEnv, aSig*kEnv

endin

</CsInstruments>
<CsScore>
t 0 72
i 1 0 16 60
i 1 0 16 60
i 1 0 16 60
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
