<Cabbage>
form caption("Feedback Buster") size(800, 300), pluginID("def1")

gentable bounds(20,20,750,200), tablenumber(1), amprange(0, 1, 1), zoom(-1), tablegridcolour(0,0,0,0), tablecolour("red", "yellow", "green"), identchannel("fftDisplay"), samplerange(0, 1024) 
label	bounds(0,0,60,13), text(""), align("left"), identchannel("MOUSEFreqID"), visible(1), fontcolour("black"), colour(255,255,255,200) 

rslider bounds(22, 234, 50, 50), channel("tableGain"), range(1, 50	, 5	, .5, 0.001), text("Amplify"),  
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

giTable		ftgen			1, 0, 1024, 2, 0
instr 1
kTableGain 	chnget 		"tableGain"
kLow		chnget		"low"
kHigh		chnget		"high"


printk2	kLow
printk2 kHigh

a1 inch 1
a2 inch 2

;a1 mp3in	"F:\\Bandcamp Music\\A Mutual Question - Strangeloop\\Awakener.mp3"

iTabSize	=	1024
ifftsize	=	iTabSize*2
ioverlap	=	ifftsize/4
iwinsize	=	ifftsize
iwintype	=	1


fSig		pvsanal			a1*kTableGain, ifftsize, ioverlap, iwinsize, iwintype
fSig		pvsblur 		fSig, 0.2, 5
if	metro(16)==1 then
	kflag		pvsftw 			fSig, giTable
endif
if kflag==1 then
 	 			chnset			"tablenumber(1)", "fftDisplay"
endif		


kMOUSE_X	chnget		"MOUSE_X"
kMOUSE_Y	chnget		"MOUSE_Y"
iTabXPos	=			20
iTabYPos	=			20
iTabXSize	=			750
iTabYSize	=			200

if changed(kMOUSE_X,kMOUSE_Y)==1 then
	if kMOUSE_X>iTabXPos && kMOUSE_X<(iTabXSize+iTabXPos) && kMOUSE_Y>iTabYPos && kMOUSE_Y<(iTabYSize+iTabYPos) then
   		kMOUSEFreq	=	((kMOUSE_X-20)/(iTabXSize+iTabXPos)) * (22050)
   		Spos		sprintfk	"pos(%d,%d), text(%d Hz), visible(1)",kMOUSE_X,kMOUSE_Y-10,kMOUSEFreq
  					chnset		Spos,"MOUSEFreqID"
  	else
   					chnset		"visible(0)","MOUSEFreqID"
  	endif
endif
;outs a1
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
