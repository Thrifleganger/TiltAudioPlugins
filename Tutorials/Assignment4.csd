<Cabbage>
form caption("Untitled") size(400, 300), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
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

instr 1

kFiltCutOff	init		3000

kEnv 		madsr 		.05, .2, .6, .4
kCutOffEnv	adsr		.1, .2, .8, .4

aSaw 		vco2 		p5, p4
aSine		oscil		p5, p4/2
aCombi		sum			aSaw + aSine

aFilt		moogladder	aCombi, kFiltCutOff * kCutOffEnv, 1

			outs 		aFilt*kEnv, aFilt*kEnv

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
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
