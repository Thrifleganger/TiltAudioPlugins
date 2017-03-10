<cabbage>
form caption("Untitled") size(800, 583), pluginID("def1"), svgpath("./SVGs")
; Metering widgets
gentable bounds(270, 164, 90, 253), tablenumber(1), amprange(0, 1, 1), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterIn")
gentable bounds(440, 166, 93, 250), tablenumber(2), amprange(0, 1, 2), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("vuMeterOut")

image bounds(0, 0, 800, 583), file("Levaithan_Final.png")

rslider bounds(488, 410, 71, 46), channel("gain"), range(0, 1, , 1, 0.01),  trackercolour(0, 0, 0, 0), 
rslider bounds(63, 166, 101, 111), channel("decay"), range(.05, 25, 3, .5, 0.01), trackercolour(0, 0, 0, 0)
rslider bounds(402, 474, 77, 77), channel("lowcf"), range(400, 20000, 15000, .5, 0.001), trackercolour(0, 0, 0, 0)
rslider bounds(304, 174, 192, 234), channel("mix"), range(0, 1, 0.5, 1, 0.001),  trackercolour(0, 0, 0, 0), svgfile("slider","./SVGs/rslider_mix.svg") 
rslider bounds(322, 474, 74, 76), channel("highcf"), range(0, 400, 30, 1, 0.001), trackercolour(0, 0, 0, 0)  
rslider bounds(56, 376, 75, 73), channel("pdepth"), range(0, 50, 10, 1, 0.001), trackercolour(0, 0, 0, 0) 
rslider bounds(133, 376, 77, 74), channel("prate"), range(0, 5, 1, 1, 0.001), trackercolour(0, 0, 0, 0)  
rslider bounds(596, 376, 72, 72), channel("tdepth"), range(0, 5, , 1, 0.001), trackercolour(0, 0, 0, 0)  
rslider bounds(676, 376, 75, 74), channel("trate"), range(0, 5, 1, 1, 0.001), trackercolour(0, 0, 0, 0)  
rslider bounds(248, 409, 61, 45), channel("input"), range(0, 1, 1, 1, 0.001), trackercolour(0, 0, 0, 0)  
rslider bounds(138, 40, 75, 84), channel("predelay"), range(10, 400, 60, 1, 0.001), trackercolour(0, 0, 0, 0)  
rslider bounds(584, 30, 75, 85), channel("width"), range(0, 1, .5, 1, 0.001), trackercolour(0, 0, 0, 0)    
rslider bounds(645, 177, 102, 101), channel("shimmer"), range(0, 100, 50, 1, 0.001), trackercolour(0, 0, 0, 0)  
     


image bounds(274, 172, 79, 234), file("Bent_grill_L.png")
image bounds(444, 168, 81, 240), file("Bent_grill_R.png")
numberbox bounds(246, 70, 40, 20), channel("predelay"), range(10, 400, 60, 1, 1), fontcolour(214, 176, 176, 255)
numberbox bounds(198, 198, 40, 20), channel("decay"), range(.05, 25, 3, 1, 0.01),  fontcolour(214, 176, 176, 255)
numberbox bounds(72, 472, 40, 20), channel("pdepth"), range(0, 50, 10, 1, 1), fontcolour(214, 176, 176, 255) 
numberbox bounds(152, 472, 40, 20), channel("prate"), range(0, 5, 1, 1, 0.01),  fontcolour(214, 176, 176, 255)
numberbox bounds(688, 336, 40, 20), channel("trate"), range(0, 5, 1, 1, 0.01),  fontcolour(214, 176, 176, 255) 
numberbox bounds(612, 336, 40, 20), channel("tdepth"), range(0, 5, , 1, 0.01), fontcolour(214, 176, 176, 255) 
numberbox bounds(564, 198, 40, 20), channel("shimmer"), range(0, 100, 50, 1, 1),  fontcolour(214, 176, 176, 255)
numberbox bounds(518, 72, 40, 20), channel("width"), range(0, 1, 0, 1, 0.01), fontcolour(214, 176, 176, 255) 
numberbox bounds(340, 552, 40, 20), channel("highcf"), range(0	, 400	, 30, 1, 1), fontcolour(214, 176, 176, 255)  
numberbox bounds(422, 554, 40, 20), channel("lowcf"), range(400	, 20000, 15000, .5, 1), fontcolour(214, 176, 176, 255) 
image bounds(646, 538, 55, 31), file("C:\Users\Thrifleganger\Documents\Cabbage\Reverb\Switch_side_1.png"),  
</Cabbage>

<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d -b-64
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

seed	0

; Gen routines for metering
giMeterIn	ftgen 		1, 0, -1, 2, 0
giMeterOut	ftgen 		2, 0, -1, 2, 0

gifftsize = 1024
gioverlap = gifftsize/8
giwinsize = gifftsize
giwinshape = 2

opcode	EarlyReflections,aa,iikip					; define the form of the user defined opcode. Stereo output and more input arguments.
 iMax,iWidth,iTone,iEchoes,iCount	xin				; more input arguments this time. Remember, this list needs to match the form of the UDO inputs defined above.
 aTap		deltap	ksmps/sr + rnd(iMax - ksmps/sr)	; create a delay tap, delay time chosen randomly
 aTap		*=		ampdbfs(-rnd(50))				; random amplitude scaling
 aTap		tone		aTap, 100 + rnd(iTone)			; random high-cut (lowpass filtering)
 ;aL,aR	pan2		aTap, 0.5 + random:i(-iWidth/2,iWidth/2)	; random pan positioning. Creates the stereo signal for output
 aMixL	=	0							; clear variables. this can sometimes be necessary to remove stuck variable values after changing the 'Echoes' control.
 aMixR	=	0
 if iCount<=iEchoes then						; if we haven't yet completed recursion for all strings, call the UDO again from itself
  aMixL,aMixR	EarlyReflections	iMax,iWidth,iTone,iEchoes,iCount+1	; Note that iCount is incremented!
 endif
 		xout		aTap + aMixL, aTap + aMixR			; send audio (This string and mix of all other strings) back to caller instrument	
endop


opcode 		FDNReverb, a, akkkk

aSignal, kDecayTime, kLowCF, kHighCF, kShimmer  	xin

 afil1, afil2, afil3, afil4, afil5, afil6, afil7, afil8, afil9, afil10, afil11, afil12	init		0					; initialise the delay outputs (after filtering) for the first pass.

 aGFB1		=		(afil1 + afil2 + afil3 + afil4 + afil5 + afil6 + afil7 + afil8 + afil9 + afil10 + afil11 + afil12) * 2/12	; global feedback signal. Note amplitude scaling - the 8 derives from the number of parallel delays employed. This scaling factor can be reduced but not increased!
 
 fftin		pvsanal 	aGFB1, gifftsize, gioverlap, giwinsize, giwinshape
 fscale		pvscale		fftin, semitone(12), 0
 aGFB2		pvsynth		fscale
 
 aGFB 		=			aGFB1 * (1-kShimmer) + aGFB2 * kShimmer 
 
 kDelTime1	=	rspline:k(0.119,0.120,5,8)*1000
 kDelTime2  =	rspline:k(0.119,0.120,5,8)*1000*0.9137 
 kDelTime3  =	rspline:k(0.119,0.120,5,8)*1000*0.87379  
 kDelTime4  =	rspline:k(0.119,0.120,5,8)*1000*0.81678 
 kDelTime5  =	rspline:k(0.119,0.120,5,8)*1000*0.78791 
 kDelTime6  =	rspline:k(0.119,0.120,5,8)*1000*0.72190
 kDelTime7  =	rspline:k(0.119,0.120,5,8)*1000*0.66113  
 kDelTime8  =	rspline:k(0.119,0.120,5,8)*1000*0.627189 
 kDelTime9  =	rspline:k(0.119,0.120,5,8)*1000*0.57989
 kDelTime10 =	rspline:k(0.119,0.120,5,8)*1000*0.526177
 kDelTime11 =	rspline:k(0.119,0.120,5,8)*1000*0.49317 
 kDelTime12 =	rspline:k(0.119,0.120,5,8)*1000*0.421567 

 kNum 		= 	kDecayTime/kDelTime8
 kStep 		= 	-60/kNum
 kFB 		= 	ampdbfs(kStep)
 ;kFB = .98
 
 ; create the 8 delays
 adel1	vdelay	aSignal + aGFB - afil1, kDelTime1, 2*1000
 adel2	vdelay	aSignal + aGFB - afil2, kDelTime2, 2*1000
 adel3	vdelay	aSignal + aGFB - afil3, kDelTime3, 2*1000
 adel4	vdelay	aSignal + aGFB - afil4, kDelTime4, 2*1000
 adel5	vdelay	aSignal + aGFB - afil5, kDelTime5, 2*1000
 adel6	vdelay	aSignal + aGFB - afil6, kDelTime6, 2*1000
 adel7	vdelay	aSignal + aGFB - afil7, kDelTime7, 2*1000
 adel8	vdelay	aSignal + aGFB - afil8, kDelTime8, 2*1000
 adel9	vdelay	aSignal + aGFB - afil9, kDelTime9, 2*1000
 adel10	vdelay	aSignal + aGFB - afil10, kDelTime10, 2*1000
 adel11	vdelay	aSignal + aGFB - afil11, kDelTime11, 2*1000
 adel12	vdelay	aSignal + aGFB - afil12, kDelTime12, 2*1000

 ; lowpass filter each tap
 afil1	tone		adel1*kFB, kLowCF
 afil2	tone		adel2*kFB, kLowCF
 afil3	tone		adel3*kFB, kLowCF
 afil4	tone		adel4*kFB, kLowCF
 afil5	tone		adel5*kFB, kLowCF
 afil6	tone		adel6*kFB, kLowCF
 afil7	tone		adel7*kFB, kLowCF
 afil8	tone		adel8*kFB, kLowCF
 afil9	tone		adel9*kFB, kLowCF
 afil10	tone		adel10*kFB, kLowCF
 afil11	tone		adel11*kFB, kLowCF
 afil12	tone		adel12*kFB, kLowCF
 
  ; highpass filter each tap
 afil1	atone		afil1, kHighCF
 afil2	atone		afil2, kHighCF
 afil3	atone		afil3, kHighCF
 afil4	atone		afil4, kHighCF
 afil5	atone		afil5, kHighCF
 afil6	atone		afil6, kHighCF
 afil7	atone		afil7, kHighCF
 afil8	atone		afil8, kHighCF
 afil9	atone		afil9, kHighCF
 afil10	atone		afil10, kHighCF
 afil11	atone		afil11, kHighCF
 afil12	atone		afil12, kHighCF

 xout	adel1 + adel2 + adel3 + adel4 + adel5 + adel6 + adel7 + adel8 + adel9 + adel10 + adel11 + adel12
endop




instr 2

kGain 		chnget		"gain"
kDecayTime	chnget		"decay"
kLowCF		chnget		"lowcf"
kHighCF		chnget		"highcf"
kMix		chnget		"mix"
kPDepth		chnget		"pdepth"
kPRate		chnget		"prate"
kTDepth		chnget		"tdepth"
kTRate		chnget		"trate"
kPredelay	chnget		"predelay"
kWidth		chnget		"width"
kShimmer 	chnget		"shimmer"

kPredelay	/=	1000
kDecayTime	*=	1000
kShimmer	/=	100	

ifftsize = 1024
ioverlap = ifftsize/8
iwinsize = ifftsize
iwinshape = 2
;aL,aR		diskin2   	"AcousticGuitar.wav", 1, 0, 1
aL inch 1
aR = aL
denorm		aL, aR
aL *= chnget:k("input")
aR *= chnget:k("input")

; Early reflection and predelay
if changed(kPredelay,kWidth)==1 then	; if any of the list of k-rate variables listed after changed() are changed a trigger (1) will be created and the conditional branch will be followed.
  		reinit			RestartEarlyReflections				; begin a reinitilaisation from the given label (RestartEarlyReflections)
endif
RestartEarlyReflections:
aDump		delayr		.4
aEarlyL,aEarlyR		EarlyReflections	i(kPredelay), i(kWidth), 15000, 20
 			delayw		aL
rireturn

; Late reflection (FDN network)
aRevL		FDNReverb 	aEarlyL, kDecayTime, kLowCF, kHighCF, kShimmer
aRevR		FDNReverb	aEarlyR, kDecayTime, kLowCF, kHighCF, kShimmer

; Pitch modulation section (Vibrato)
kPitchLFO  	poscil		kPDepth, kPRate
fftinL		pvsanal 	aRevL, ifftsize, ioverlap, iwinsize, iwinshape
fscaleL		pvscale		fftinL, cent(kPitchLFO), 0
aRVibL		pvsynth		fscaleL

fftinR		pvsanal 	aRevR, ifftsize, ioverlap, iwinsize, iwinshape
fscaleR		pvscale		fftinR, cent(kPitchLFO), 0
aRVibR		pvsynth		fscaleR

; Volume modulation section (Tremolo)
kVolLFO		poscil		1, kTRate
aTremelo	=			(kVolLFO * kTDepth) - kTDepth
aRVibL		*=			ampdbfs(aTremelo)
aRVibR		*=			ampdbfs(aTremelo)

; Output section
iReverbGain =			0.3
aLeft		ntrpol		aL, aRVibL * iReverbGain * kGain, kMix
aRight		ntrpol		aR, aRVibR * iReverbGain * kGain, kMix

			outs		aLeft, aRight 
			
; Write Metering data
kMeterIn 	rms 		aL
kMeterIn	=			(60-abs(dbamp(kMeterIn)))/60
kMeterOut 	rms 		aLeft
kMeterOutL	=			(60-abs(dbamp(kMeterOut)))/60

if metro(60) == 1 then
  	tablew  	kMeterIn, k(0), giMeterIn
	tablew 		kMeterOutL, k(0), giMeterOut
  	chnset 		"tablenumber(1)", "vuMeterIn" 		
	chnset 		"tablenumber(2)", "vuMeterOut" 		 		
endif


endin




</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i2 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
 