
form caption("Compressor") size(700, 300), pluginID("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

rslider bounds(40, 38, 55, 68), channel("thresh"), range(-120, 0, -20, 1, 0.001), text("Threshold"),  
rslider bounds(176, 38, 55, 68), channel("lowKnee"), range(-80, 100, 40, 1, 0.001), text("Low Knee"),  
rslider bounds(246, 36, 55, 68), channel("highKnee"), range(-80, 100, 40, 1, 0.001), text("High Knee"),   
rslider bounds(108, 38, 55, 68), channel("ratio"), range(1, 100, 2, .2, 0.001), text("Ratio"),  
rslider bounds(42, 124, 55, 68), channel("attack"), range(.01, 1, .1, 1, 0.001), text("Attack"),
rslider bounds(112, 122, 55, 68), channel("release"), range(.01, 2, .1, 1, 0.001), text("Release"),  
rslider bounds(178, 122, 55, 68), channel("lookup"), range(.01, 1, .05, 1, 0.001), text("Lookup"),
gentable bounds(420, 62, 200, 200), identchannel("compTable"), tablenumber(1), 
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

giTabSize	=				1024
giCompTab	ftgen			1, 0, giTabSize, 7, -120, giTabSize, 0

instr 1

kThresh		chnget			"thresh"
kLowKnee	chnget			"lowKnee"
kHighKnee	chnget			"highKnee"
kRatio		chnget			"ratio"
kAttack		chnget			"attack"
kRelease	chnget			"release"
iLookup		chnget			"lookup"

avoice in
asig   mp3in "F:\\Bandcamp Music\\Southern Skies Motel\\Southern Skies Motel - Bastion.mp3"

;asig 	rand		.1
; duck the audio signal "beats.wav" with your voice.
/*  kthresh = 0
  kloknee = 40
  khiknee = 60
  kratio  = 2
  katt    = .1
  krel    = 0.2
  ilook   = .05
*/
asig  compress asig, asig, kThresh, kLowKnee, kHighKnee, kRatio, kAttack, kRelease, iLookup; voice-activated compressor
      outs asig, asig


kTabTrig	changed			kThresh, kRatio

if(kTabTrig == 1) then
	reinit REFRESH_TAB
endif

REFRESH_TAB:

giCompTab 	ftgen			1, 0, giTabSize, 7, -120, giTabSize*(120-abs(i(kThresh)))/120, i(kThresh), (giTabSize)- giTabSize*(120-abs(i(kThresh)))/120 , i(kThresh) - i(kThresh)/i(kRatio)
;giCompTab 	ftgen			1, 0, giTabSize, 7, 0, giTabSize/2, 50, giTabSize/2, 100
			chnset			"tablenumber(1)","compTable"
			
rireturn


endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
