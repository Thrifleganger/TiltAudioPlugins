<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
keyboard bounds(8, 158, 381, 95)
gentable bounds(36, 0, 260, 160), channel("pos","end"), tablecolour("white", "cornflowerblue", "yellow", "lime", "green", "pink", "brown", "purple", "lightblue", "darkgreen", "lightgreen", "mango"), scrubberposition(0, 0),  tablenumber(1), 
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 48000
ksmps = 16
nchnls = 2
0dbfs = 1

;instrument will be triggered by keyboard widget
instr 1

iSkip 	= 		0;
iTranspose	=	1;
iLast	=		int(sr*p3*iTranspose)+iSkip
kEnv	linseg	0,.01,.8,p3,.8,.01,0
;aRead	line	iLast, p3, iSkip
aRead	line	iSkip, p3, iLast
aSound	tablei	aRead, 1
aSig	=		aSound*kEnv
		out		aSig
endin

</CsInstruments>
<CsScore>
f 1 0 262144 1 "C:\Users\Thrifleganger\Downloads\Crotales01.wav" 0 1 0
;f 1 0 262144 1 "F:\Eclipse for C\Assignments\4.5 Mics\triangleWave.raw" 0 6 0
i 1 0 3
</CsScore>
</CsoundSynthesizer>
