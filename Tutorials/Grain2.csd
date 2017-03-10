<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr 	 	= 	44100
ksmps 	= 	32
nchnls 	= 	2
0dbfs		=	1

; Note: not all of these tables are used!
giSawRaw	ftgen		0,0,131072,7,-1,131072,1					; non-band-limited sawtooth
giSqRaw	ftgen		0,0,131072,7,1,131072/2,1,0,-1,131072/2,-1	; non-band-limited square wave

giSine	ftgen		0,0,131072,10,1
giBuzz	ftgen		0,0,131072,11,80,1,0.7
giSaw		ftgen		0,0,131072,30,giSawRaw,1,(sr/2)/1000	; band-limited saw
giSq		ftgen		0,0,131072,30,giSqRaw,1,(sr/2)/1000		; band-limited square
giOcts	ftgen		0,0,131072,10,1,1					; first two partials (octave apart)

giHanning	ftgen		0,0,4096,20,2,1						; a hanning window

instr		1
 kAmp			expsegr	0.01,0.5,0.03,2,0.0001	; amplitude
 icps			cpsmidi					; read pitch from keyboard
 kPitch		rspline	100,400,0.1,0.2		; random pitch function - this sounds a bit like a moving comb filter / flanger
 kDens		init		icps				; density derived from midi note played
 kAmpOff		=		0				; amplitude random offset (random values in this range are added to grain amplitudes on a grain-by-grain basis
 kPitchOff		=		0				; pitch random offset (random values in this range are added to grain pitch on a grain-by-grain basis)
 kGDur		=		0.2
 iMGDur		=		1				; maximum grain duration allowed
 iGRnd		=		1				; grain initial phase random on/off (0=on 1=off)
 aSig			grain 	kAmp, kPitch, kDens, kAmpOff, kPitchOff, kGDur, giSaw, giHanning, iMGDur, iGRnd
 aSig			butlp		aSig, 3000			; lowpass filter the signal to remove some of the excessive high frequencies
 aPan			rspline	0.1,0.9,0.2,0.3		; a random function that will be used to move around the pan position of the signal
 aL,aR		pan2		aSig, aPan			; create a stereo panned signal based on the slowly shifting random function created above 
 			outs		aL, aR			; sedn 'dry' signal to the outputs
 			chnmix	aL*0.4,"sendL"		; send some signal to the reverb instrument
 			chnmix	aR*0.4,"sendR"
endin

alwayson	99							; make sure instr 99 is on! (This could also be done from the score.)
instr		99 ; reverb instrument
 aInL		chnget	"sendL"				; read in signal sent from instr 1			
 aInR		chnget	"sendR"
		chnclear	"sendL"				; clear signal to prevent continuous accumulation (chnmix is used in previous instrument)
		chnclear	"sendR"
 aL,aR	reverbsc	aInL,aInR,0.85,7000		; reverberate signal
 		outs		aL,aR					; send reverb to outputs
 
 endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
