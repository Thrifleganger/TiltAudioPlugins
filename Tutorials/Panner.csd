<Cabbage>
form caption("Untitled") size(400, 300), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
label bounds(8, 76, 50, 18), text("L")
rslider bounds(20, 20, 84, 88), channel("panpot"), range(0, 1, 0.5, 1, 0.001), text("Pan"), colour(108, 105, 105, 255), \
trackercolour(0, 30, 94, 255), fontcolour(160, 160, 160, 255), textcolour(255, 255, 255, 255), outlinecolour(0, 0, 0, 255), svgfile("background","F:\Inkscape\InkscapePortable\Data\settings\Cabbage\testKnob.svg")\

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
iRvbSend	=				.8
iDelSend	=				.8
kEnv		linen			.8, .1, p3, .1
aSig		diskin			"C:\Users\Thrifleganger\Downloads\Crotales01.wav", 1
			out				aSig

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
