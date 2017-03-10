<Cabbage>
form caption("Untitled") size(600, 300), colour(58, 110, 182), pluginID("def1")

groupbox bounds(0, 0, 500, 200), text("Popup Plant"),plant("pop1"), colour(20, 20, 20), identchannel("pops") {
rslider bounds(20, 54, 63, 66), channel("semitones"), range(-12	, 12, , 1, 1), text("Semitone")  
rslider bounds(88, 54, 64, 65), channel("cents"), range(-100	, 1	00, 0	, 1	, 1), text("Cents")
rslider bounds(178, 54, 62, 66), channel("modRate"), range(.1, 5, 1, 1, 0.001), text("Rate") 
rslider bounds(246, 54, 63, 65), channel("modDepth"), range(0, 1, .5, 1, 0.001), text("Depth")
rslider bounds(332, 54, 62, 66), channel("randomRate"), range(0.10000000000000000555, 5, 1, 1, 0.001), text("Rate"),  
rslider bounds(402, 54, 63, 65), channel("randomRange"), range(0, 100, 10, 1, 0.001), text("Range") 

checkbox bounds(20, 19, 27, 24), channel("manualPitch"), shape("circle"), radiogroup("1"), value(1) 
checkbox bounds(178, 22, 27, 24), channel("autoPitch"), shape("circle"), radiogroup("1")  
checkbox bounds(334, 24, 27, 24), channel("randomPitch"), shape("circle"), radiogroup("1")
button bounds(166, 142, 106, 33), channel("but1"), text("Push", "Push"), alpha(0), popuptext("If on preserves vocal formants. If off sounds unnatural like a Voices of chipmunk") 
checkbox bounds(236, 144, 27, 24), channel("formant"), shape("circle")
}
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

a1 inch 1
a2 inch 2

outs a1*kGain, a2*kGain
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
