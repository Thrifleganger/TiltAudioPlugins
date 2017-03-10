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
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr   1
 iImpDur   chnget      "ImpDur"                          ; reads in the value for impulse duration
 
 
 iCF_LP    chnget	"CF_LP"			; cutoff frequency for the lowpass filter within the delay loop
  iCF_LP2    chnget	"CF_LP2"			; cutoff frequency for the lowpass filter within the delay loop
 
 iFeed_back   	chnget    "Feed_back"       ; reads in the value for feedback amount
 iFeed_back2   	chnget    "Feed_back2"       ; reads in the value for feedback amount
 
 iDelRatio      chnget     "Ratio"            ; Delay ratio
 iDelRatio2     chnget      "Ratio2"          ; Delay ratio 2
 


 ;inewfeed = iFeed_back > iFeed_back2 ? iFeed_back : iFeed_back2
 if (iFeed_back > 0.499) then
 iFeed_back2 = 1 - iFeed_back
 elseif (iFeed_back2 > 0.499) then
 iFeed_back = 1 - iFeed_back2
 
 endif
 
 icps		cpsmidi				                  ; read in midi note as cycles-per-second
                         ;impulse duration
 kEnv		linseg	1, iImpDur, 0	                 ; a rapidly decaying envelope for the noise impulse
 aNse		noise		kEnv, 0		                 ; some white noise with the envelope applied      
 

 aFB		init		0				; initialise the feedback signal 
 aFB2      init       0                     ; initialise the feedback signal 
 
;DELAY 1 LINE ----------------------------------------------------------------------------- 
 aDel		delay		aNse + aFB + aFB2, 1/icps * iDelRatio	; delay the impulse sound. Add the feedback signal into the input.

 aFB		=		aDel * iFeed_back		; create feedback signal for the next pass
 

 aFB		tone		aFB, iCF_LP			; lowpass filter the feedback signal
 
;DELAY 2 LINE -----------------------------------------------------------------------------
 aDel2 	delay      aNse + aFB2 +aFB , 1/icps * iDelRatio2
 
 aFB2   	= 		aDel2 * iFeed_back2

 
 aFB2		tone		aFB2, iCF_LP2		; lowpass filter the feedback signal
 
; Mixing together 
 aSig		=		aNse + aDel	 + aDel2	; output signal is a mix of the noise impulse and and two delays signal
 
 
 
 
 aEnv		linsegr	1,0.5,0			; anti-clicking envelope
 aSig		*=		aEnv				; apply envelope
 		out		aSig				; send audio to output
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
