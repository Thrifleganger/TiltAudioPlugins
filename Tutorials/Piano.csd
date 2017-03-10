<CsoundSynthesizer>
<CsOptions>
-odac -Ma -m0
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1.0

giRand	ftgen	1, 0, 256, 21, 3, 40

instr 1

iNote	notnum
iVel 	ampmidi  5 ; read in note velocity
iDur 	=		5
;print 	iNote

if (iNote > 21 && iNote < 108) then
 	if (iNote < 31) then
	 	event  	"i", 2, 0, iDur, iNote, iVel
	 	print iNote
	elseif (iNote > 30 && iNote < 47) then
		iFreq1		table		iNote, giRand
		iFreq1		*=			10
		print	 	iNote , iFreq1
		event_i		"i", 2, 0, iDur, iNote, iVel
		event_i		"i", 2, 0, iDur, iNote * cent(iFreq1), iVel
	elseif (iNote > 46) then
		iFreq1		table		iNote, giRand
		iFreq1		*=			10
		iFreq2		table		iNote+100, giRand
		iFreq2		*=			10	
		print  		iNote, iFreq1, iFreq2
		event_i		"i", 2, 0, iDur, iNote, iVel
		event_i		"i", 2, 0, iDur, iNote * cent(iFreq1), iVel
		event_i		"i", 2, 0, iDur, iNote * cent(iFreq2), iVel
	endif
endif
endin

instr 2
kEnv	expseg		1, p3, .01
icps	= cpsmidinn(p4)
iVel 	=		p5
aImp	mpulse 	iVel, 0 ; create a single impulse
aImp 	butlp 	aImp, 400 ; filter it
;icps 	cpsmidi ; read in note pitch
aSig 	wguide1 aImp, icps, sr/2, 0.999 ; create waveguide from the impulse
 		outs 	aSig*kEnv, aSig*kEnv
endin

</CsInstruments>
<CsScore>
i 1 0 3600
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
