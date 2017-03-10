<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(44, 30, 61, 61), channel("reverbTime"), range(0, 10	, 5, 1, 0.001), text("RvbTime"),
rslider bounds(44, 100, 61, 61), channel("cutOffFreq"), range(200, 20000, 10000, 1, 0.001), text("CutOff"), 
 rslider bounds(122, 100, 61, 61), channel("predelay"), range(0, 100, 25, 1, 0.001), text("PreDelay"), 
rslider bounds(122, 30, 61, 61), channel("mix"), range(0, 1, .2, 1, 0.001), text("Mix"),  
rslider bounds(200, 30, 61, 61), channel("roomSize"), range(0, .5, 0, 1, 0.001), text("RoomSize"),
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

giCombTime		ftgen		1, 0, -6, -2, 	.05, .056, .061, .068, .072, .078
giDampFreq		ftgen		2, 0, -6, -2, 	1942, 1363, 1312, 1574, 981, 1036

giReflectTime	ftgen		3, 0, -18, -2, 	.0043, .0215, .0225, .0268, .0270, \
											.0298, .0458, .0485, .0572, .0587, \
											.0595, .0612, .0707, .0708, .0726, \
											.0741, .0753, .0797
giReflectGain	ftgen		4, 0, -18, -2, 	.841, .504, .491, .379, .380, \
											.346, .289, .272, .192, .193, \
											.217, .181, .180, .181, .176, \
											.142, .167, .134

giNumCombs 		=			6
giNumReflects	=			18

instr 1
kGain chnget "gain"
kRvbTime 	chnget		"reverbTime"
kCutOff		chnget		"cutOffFreq"
kPreDel		chnget		"predelay"
kRoomSize	chnget		"roomSize"
kMix		chnget		"mix"

kCIndex		init		0
kRIndex		=		0
aSum 		init		0
aCombi		init 		0

a1 			inch 		1
aReflects[]	init		18

;Comb filtering section
;#define COMB_FILTER(OUTPUT'DELAY'FREQ) #
;$OUTPUT 	comb		a1, kRvbTime, i($DELAY)
;$OUTPUT		butlp		$OUTPUT, $FREQ
;#
;
;while (kCIndex < giNumCombs) do
;	kCombTime	table		kCIndex, giCombTime
;	kCOFreq		table		kCIndex, giDampFreq
;	$COMB_FILTER(aCombs[kCIndex]'kCombTime'kCOFreq)
;	aSum		+=			aCombs[kCIndex]
;	kCIndex		wrap		kCIndex, 0, 6
;od


;Early reflection system:

aCombi 		=			0
aDump		delayr		1
while (kRIndex < giNumReflects) do
	kRTime		table		kRIndex, giReflectTime
	kRGain		table		kRIndex, giReflectGain
	
	aReflect	deltapi		kRTime + kRoomSize
	aReflect	=			aReflect * kRGain	
	
	aCombi		+=			aReflect
	kRIndex		+=			1
od
delayw		a1

		
;Comb filtering section:
aC1 		comb		aCombi, kRvbTime, .05
aC2 		comb		aCombi, kRvbTime, .056
aC3 		comb		aCombi, kRvbTime, .061
aC4 		comb		aCombi, kRvbTime, .068
aC5 		comb		aCombi, kRvbTime, .072
aC6 		comb		aCombi, kRvbTime, .078

aC1			butlp		aC1, 1942
aC2			butlp		aC2, 1363
aC3			butlp		aC3, 1312
aC4			butlp		aC4, 1574
aC5			butlp		aC5, 981
aC6			butlp		aC6, 1036

aSum		sum			aC1, aC2, aC3, aC4, aC5, aC6


aOut		butlp		aSum, kCutOff
aMix		ntrpol		a1, aOut, kMix
			outs		aMix* kGain, aMix * kGain
		
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
