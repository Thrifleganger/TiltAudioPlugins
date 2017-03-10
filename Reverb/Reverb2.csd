<cabbage>
form caption("Untitled") size(500, 300), pluginID("def1")
rslider bounds(242, 16, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(18, 24, 67, 72), channel("feedback"), range(0	, 1, .5, 1, 0.001), text("Feedback"),  
rslider bounds(146, 216, 71, 72), channel("lowcf"), range(0	, 20000, 15000, 1, 0.001), text("Low pass"),  
rslider bounds(310, 216, 74, 72), channel("mix"), range(0, 1, 0.5, 1, 0.001), text("Mix"),  
rslider bounds(228, 216, 74, 72), channel("highcf"), range(0, 400, 30, 1, 0.001), text("High pass"),  
rslider bounds(346, 8, 70, 71), channel("pdepth"), range(0, 50, 10, 1, 0.001), text("Depth"),  
rslider bounds(426, 8, 70, 74), channel("prate"), range(0, 5, 1, 1, 0.001), text("Rate"),  
rslider bounds(350, 100, 70, 71), channel("tdepth"), range(0, 5, , 1, 0.001), text("Depth"),  
rslider bounds(430, 100, 70, 74), channel("trate"), range(0, 5, 1, 1, 0.001), text("Rate"),  
rslider bounds(94, 26, 67, 70), channel("roomsize"), range(1, 2, 1, 1, 0.001), text("RoomSize"),  
rslider bounds(432, 216, 50, 50), channel("input"), range(0, 1, 1, 1, 0.001), text("Input"),  
rslider bounds(16, 104, 72, 78), channel("diffusion"), range(0, 1, , 1, 0.001), text("Diffusion"),  
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

seed	0

gkSplineRate1, gkSplineRate2 init 0


opcode 		FDNReverb, a, akkkkk

aSignal, kFB, kLowCF, kHighCF, kRoomSize, kDiffusion  	xin

 iNumDelays = 8
 
 afil1, afil2, afil3, afil4, afil5, afil6, afil7, afil8	init		0					; initialise the delay outputs (after filtering) for the first pass.

 aGFB		=		(afil1 + afil2 + afil3 + afil4 + afil5 + afil6 + afil7 + afil8) * 2/8	; global feedback signal. Note amplitude scaling - the 8 derives from the number of parallel delays employed. This scaling factor can be reduced but not increased!
 
 

 ;Scale diffusion to width
 kWidth 	= 	(kDiffusion * kRoomSize * 0.95) + 0.05 
 kTimeDiv	=	kWidth / iNumDelays
 
 kDelTime1	=	kRoomSize * 1000
 kDelTime2  =	kRoomSize * 1000 * 0.9137   
 kDelTime3  =	kRoomSize * 1000 * 0.81678  
 kDelTime4  =	kRoomSize * 1000 * 0.72190  
 kDelTime5  =	kRoomSize * 1000 * 0.627189 
 kDelTime6  =	kRoomSize * 1000 * 0.526177 
 kDelTime7  =	kRoomSize * 1000 * 0.421567 
 kDelTime8  =	kRoomSize * 1000 * 0.3372891


 kDelTime1	=	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000
 kDelTime2  =	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000 * 0.9137   
 kDelTime3  =	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000 * 0.81678  
 kDelTime4  =	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000 * 0.72190  
 kDelTime5  =	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000 * 0.627189 
 kDelTime6  =	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000 * 0.526177 
 kDelTime7  =	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000 * 0.421567 
 kDelTime8  =	rspline:k(0.08,0.0806,5,8) * kRoomSize * 1000 * 0.3372891
 
 ; create the 8 delays
 adel1	vdelay	aSignal + aGFB - afil1, kDelTime1, 2*1000
 adel2	vdelay	aSignal + aGFB - afil2, kDelTime2, 2*1000
 adel3	vdelay	aSignal + aGFB - afil3, kDelTime3, 2*1000
 adel4	vdelay	aSignal + aGFB - afil4, kDelTime4, 2*1000
 adel5	vdelay	aSignal + aGFB - afil5, kDelTime5, 2*1000
 adel6	vdelay	aSignal + aGFB - afil6, kDelTime6, 2*1000
 adel7	vdelay	aSignal + aGFB - afil7, kDelTime7, 2*1000
 adel8	vdelay	aSignal + aGFB - afil8, kDelTime8, 2*1000
 
; adel1	alpass	adel1, .053213, 2
; adel2	alpass	adel2, .04236, 2
; adel3	alpass	adel3, .02345, 2
; adel4	alpass	adel4, .06451, 2
; adel5	alpass	adel5, .08651, 2
; adel6	alpass	adel6, .0533, 2
; adel7	alpass	adel7, .07653, 2
; adel8	alpass	adel8, .09852, 2
 

 ; lowpass filter each tap
 afil1	tone		adel1*kFB, kLowCF
 afil2	tone		adel2*kFB, kLowCF
 afil3	tone		adel3*kFB, kLowCF
 afil4	tone		adel4*kFB, kLowCF
 afil5	tone		adel5*kFB, kLowCF
 afil6	tone		adel6*kFB, kLowCF
 afil7	tone		adel7*kFB, kLowCF
 afil8	tone		adel8*kFB, kLowCF
 
  ; highpass filter each tap
 afil1	atone		afil1, kHighCF
 afil2	atone		afil2, kHighCF
 afil3	atone		afil3, kHighCF
 afil4	atone		afil4, kHighCF
 afil5	atone		afil5, kHighCF
 afil6	atone		afil6, kHighCF
 afil7	atone		afil7, kHighCF
 afil8	atone		afil8, kHighCF

 xout	adel1 + adel2 + adel3 + adel4 + adel5 + adel6 + adel7 + adel8
endop





instr 1
kGain 		chnget		"gain"
kFeedback	chnget		"feedback"
kLowCF		chnget		"lowcf"
kHighCF		chnget		"highcf"
kMix		chnget		"mix"
kPDepth		chnget		"pdepth"
kPRate		chnget		"prate"
kTDepth		chnget		"tdepth"
kTRate		chnget		"trate"
kRoomSize	chnget		"roomsize"
kDiffusion	chnget		"diffusion"


ifftsize = 1024
ioverlap = ifftsize/8
iwinsize = ifftsize
iwinshape = 2
aL,aR		diskin2   	"Blip.wav", 1, 0, 1
aL *= chnget:k("input")
aR *= chnget:k("input")

aMod		poscil		1, 4
aVibrato	=			aMod * 0.0005
;aTremelo	=			(aMod * 3) - 3
aTremelo	=	0

aRevL		FDNReverb 	aL, kFeedback, kLowCF, kHighCF, kRoomSize, kDiffusion
aRevR		FDNReverb	aR, kFeedback, kLowCF, kHighCF, kRoomSize, kDiffusion

kPitchLFO  	poscil		kPDepth, kPRate
fftinL		pvsanal 	aRevL * ampdbfs(aTremelo), ifftsize, ioverlap, iwinsize, iwinshape
fscaleL		pvscale		fftinL, cent(kPitchLFO), 0
aRVibL		pvsynth		fscaleL

fftinR		pvsanal 	aRevR * ampdbfs(aTremelo), ifftsize, ioverlap, iwinsize, iwinshape
fscaleR		pvscale		fftinR, cent(kPitchLFO), 0
aRVibR		pvsynth		fscaleR

kVolLFO		poscil		1, kTRate
aTremelo	=			(kVolLFO * kTDepth) - kTDepth
aRVibL		*=			ampdbfs(aTremelo)
aRVibR		*=			ampdbfs(aTremelo)

iReverbGain =			0.3
aLeft		ntrpol		aL, aRVibL * iReverbGain, kMix
aRight		ntrpol		aR, aRVibR * iReverbGain, kMix

			outs		aLeft * kGain, aRight * kGain

endin




</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
