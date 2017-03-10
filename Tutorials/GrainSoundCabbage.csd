form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(30, 26, 50, 50), channel("pitch"), range(50	, 2000	, 400	, 1	, 0.001), text("Pitch"),  
rslider bounds(92, 26, 50, 50), channel("density	"), range(10, 8000, 400, 1, 0.001), text("Density"),  
rslider bounds(154, 24, 50, 50), channel("ampOffset"), range(0	, 1	, , 1, 0.001), text("AmpOff"),  
rslider bounds(214, 26, 50, 50), channel("freqOffset"), range(0, 400, , 1, 0.001), text("PitchOff"),  
rslider bounds(278, 28, 50, 50), channel("gdur"), range(.0001, 1, 0.1, 1, 0.001), text("GDur"),  
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1
gaSendL,gaSendR	init	0


giSawRaw	ftgen		0,0,131072,7,-1,131072,1					; non-band-limited sawtooth
giSine	ftgen		0,0,131072,10,1
giBuzz	ftgen		0,0,131072,11,80,1,0.7
giSaw		ftgen		0,0,131072,30,giSawRaw,1,(sr/2)/1000
giHanning	ftgen		0,0,4096,20,2,1	
giSharpWin	ftgen		0,0,4096,7,0,100,1,3896,1,100,0

instr 1

kPitch		chnget		"pitch"
;kPitch 		=			cpsmidinn(p4)
kDensity	chnget		"density"
kAmpOff		chnget		"ampOffset"
kFreqOff	chnget		"freqOffset"
kGDur		chnget		"gdur"

aout 		grain 		.01, kPitch, kDensity, kAmpOff, kFreqOff, kGDur, giBuzz, giHanning, 1, 0
out aout


endin

instr	99	; Reverb
 
 aL,aR	reverbsc	gaSendL,gaSendR,0.83,6000
 	outs		aL,aR
 	clear		gaSendL,gaSendR
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i 1 0 2000 

</CsScore>
</CsoundSynthesizer>
