<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
rslider bounds(176, 16, 61, 62), channel("res"), range(0, .99, .8, 1, 0.001), text("Resonance"),  
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

giArp		ftgen		1, 0, 4, -2, 0, 4, 7, 4			;Table for holding necessary arpeggio increments.
giCos		ftgen		2, 0, 16384, 11, 1				;Cosine table for gbuzz

;instrument will be triggered by keyboard widget
instr 1
iTempo 		=			120					;Assign tempo, since we are not using score
iRate		=			iTempo/60			;Rate is tempo divided by 60 seconds
kIndex 		init 		0
			
kTrig		metro		iRate * 4			;Trigger for every 16th note
kCutOff		rspline		200, 2000, .1, .5	;Smooth curve for filter cutoff
kMul		rspline		0.2, 1, .1, .5		;Smooth curve for gbuzz mul
if (kTrig == 1) then	
	kStep		tablei 		kIndex, giArp	;Select arpeggio increment
	kIndex		+=			1				
	kIndex		wrap		kIndex, 0, 4	;Rotate arpeggio
	kFreq		=			p4 * semitone(kStep)		;Account for selected arpeggio 
							;i	p1,p2,p3,			  p4,	p5,	 p6, 	  p7
				event		"i", 2, 0, 1/(4 * iRate), kFreq, p5, kCutOff, kMul		;Trigger event
endif
endin


instr 2
;p4 - Frequency
;p5 - Amplitude
;p6 - Filter cutoff
;p7 - Gbuzz mul parameter

kRes		chnget			"res"

kEnv 		expsegr 		.01, .01, 1, .05, .01
aOut		gbuzz			p5, p4, 20, 1, p7, giCos	;Output tone
aOut		moogladder		aOut, p6, kRes				;Lowpass filter with variable resonance
			outs 			aOut*kEnv, aOut*kEnv
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...

f0 z
f 2 0 16384 11 1
</CsScore>
</CsoundSynthesizer>
