<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>

sr 	 	= 	44100
ksmps 	= 	32
nchnls 	= 	2
0dbfs	=	1

giSawRaw	ftgen		0,0,131072,7,-1,131072,1					; non-band-limited sawtooth
giSqRaw	ftgen		0,0,131072,7,1,131072/2,1,0,-1,131072/2,-1	; non-band-limited square wave

giSine	ftgen		0,0,131072,10,1
giBuzz	ftgen		0,0,131072,11,80,1,0.7
giSaw		ftgen		0,0,131072,30,giSawRaw,1,(sr/2)/1000	; band-limited saw
giSq		ftgen		0,0,131072,30,giSqRaw,1,(sr/2)/1000		; band-limited square
giOcts	ftgen		0,0,131072,10,1,1					; first two partials (octave apart)

giHanning	ftgen		0,0,4096,20,2,1						; a hanning window

instr		1
 kAmp		expsegr	0.01,0.5,0.1,2,0.0001			; amplitude
 iPitch	cpsmidi
 kPitch	init		iPitch
 kDens	expsegr	500,6,2000,2,5000				; grain density (grains per second). Rises from sparse to very dense.
 kAmpOff	=		0							; amplitude random offset (random values in this range are added to grain amplitudes on a grain-by-grain basis
 kPitchOff	=		0							; pitch random offset (random values in this range are added to grain pitch on a grain-by-grain basis)
 kGDur	expsegr	0.0005,0.5,0.1,6,0.005,2,0.0005	; grain duration
 iMGDur	=		1							; maximum grain duration allowed
 iGRnd	=		0							; grain initial phase random on/off (0=on 1=off)
 aL		grain 	kAmp, kPitch, kDens, kAmpOff, kPitchOff, kGDur, giSaw, giHanning, iMGDur, iGRnd
 aR		grain 	kAmp, kPitch, kDens, kAmpOff, kPitchOff, kGDur, giSaw, giHanning, iMGDur, iGRnd
 		outs		aL,aR
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
