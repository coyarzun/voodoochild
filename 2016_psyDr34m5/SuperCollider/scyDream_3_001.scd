/////////////////////////////////////////////////////////////////////////////////////
//                ///////////////////////////////////////////////////////////////////
// ブードゥー教の子 ///////////////////////////////////////////////////////////////////
// PSY.DR34M5:OO5 ///////////////////////////////////////////////////////////////////
// SCL20161118    ///////////////////////////////////////////////////////////////////
//                ///////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 00.- tune           //////////////////////////////////////////////////////////////
// 01.- brownie        //////////////////////////////////////////////////////////////
// 02.- warpWidow      //////////////////////////////////////////////////////////////
// 03.- egg            //////////////////////////////////////////////////////////////
// 04.- cardioid       //////////////////////////////////////////////////////////////
// 05.- toshimiYeah!   //////////////////////////////////////////////////////////////
// 06.- add            //////////////////////////////////////////////////////////////
// 07.- add            //////////////////////////////////////////////////////////////
// 08.- add            //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

s.boot;
MIDIClient.init;

/////////////////////////////////////////////////////////////////////////////////////

m=MIDIOut(1);//1);
n=MIDIOut(2);//2);

TempoClock.default.tempo = 1;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

(
SynthDef(\playbuf, { |bufnum, start, dur = 0.2, amp = 1.2, out|
    var    sig = PlayBuf.ar(1, bufnum, BufRateScale.ir(bufnum), 0, start);
    sig = sig * amp * EnvGen.kr(Env.linen(0.01, dur, 0.01), doneAction: 2);
    Out.ar(out, sig ! 2)
}).add;
)

(
SynthDef(\bass, { |freq = 440, gate = 1, amp = 1.5, slideTime = 0.17, ffreq = 1100, width = 0.15,
        detune = 1.005, preamp = 4|
    var    sig,
        env = Env.adsr(0.01, 0.3, 0.4, 0.1);
    freq = Lag.kr(freq, slideTime);
    sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort * amp
        * EnvGen.kr(env, gate, doneAction: 2);
    sig = LPF.ar(sig, ffreq);
    Out.ar(0, sig ! 2)
}).add;
)

(
// this SynthDef has a strong attack, emphasizing the articulation
SynthDef(\sawpulse, { |out, freq = 440, gate = 0.5, plfofreq = 6, mw = 0, ffreq = 2000, rq = 0.3, freqlag = 1.05, amp = 1|
    var sig, plfo, fcurve;
    plfo = SinOsc.kr(plfofreq, mul:mw, add:1);
    freq = Lag.kr(freq, freqlag) * plfo;
    fcurve = EnvGen.kr(Env.adsr(0, 0.3, 0.1, 20), gate);
    fcurve = (fcurve - 1).madd(0.7, 1) * ffreq;
    sig = Mix.ar([Pulse.ar(freq, 0.9), Saw.ar(freq*1.007)]);
    sig = RLPF.ar(sig, fcurve, rq)
        * EnvGen.kr(Env.adsr(0.04, 0.2, 0.6, 0.1), gate, doneAction:2)
        * amp;
    Out.ar(out, sig ! 2)
}).add;
)

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 00.- tune           //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

m.program(0, 46);//64+33);//46);//64+33);//64+41);//40);//33);//5*8+6);
//m.program(0, 32);

m.control(9,0,1);
m.program(9, 5);

n.control(1,0,2);
n.program(1, 3);

TempoClock.default.tempo = 1.2;//1.2;//1.2;//4;//
TempoClock.default.tempo = 1.2*0.5;
/////////////////////////////////////////////////////////////////////////////////////
(
p = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,
    \degree, Pbrown(2, 7, 4, inf),
	\octave, 7,
    //\cutoff, Pn(Pif(Ptime(inf) <= 2.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
    \dur, Pbrown(1, 2, 5, inf),
	\legato, 3.15
).play;
)
/////////////////////////////////////////////////////////////////////////////////////
//bassline
(
r = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,
    \degree, Pbrown(2, 7, 4, inf),
	\octave, 2,
    //\cutoff, Pn(Pif(Ptime(inf) <= 2.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
    \dur, Pbrown(1, 3, 2, inf),//0.125*4.5,
	\legato, 1.5
).play;
)
/////////////////////////////////////////////////////////////////////////////////////
(
q = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,
    \degree, Pbrown(2, 7, 4, inf),
	\octave, 4,
    \cutoff, Pn(Pif(Ptime(inf) <= 2.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
    \dur, Pbrown(1, 2, 1, inf),
	\legato, 0.5
).play;
)
/////////////////////////////////////////////////////////////////////////////////////
(
u = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 9,
    \degree, Pwhite(6, 7, inf),
    \octave, 2,
    \dur, 0.25*Pbrown(1, 3, 3, inf),
    \amp, 1.8
).play;
)
u.stop;




/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
p.stop();
r.stop();
t.stop();
q.stop();

u.stop();
/////////////////////////////////////////////////////////////////////////////////////
//noteOffes
(
m.allNotesOff(0);
n.allNotesOff(1);
)


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 01.- brownie        //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

// To keep looping the envelope, wrap Pif inside Pn

TempoClock.default.tempo = 0.5*157/120;

(
/*p = Pbind(
	\instrument, \sawpulse,
    \degree, Pbrown(1, 7, 7, inf),
	\octave, 4,
    \pan, Pn(Pif(Ptime(inf) <= 2.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
    \dur, 0.125*36.0,
	\legato, 1.2
).play;*/

q = Pbind(
	\instrument, \sawpulse,
    \degree, Pbrown(1, 7, 7, inf),
	\octave, 7,
    \pan, Pn(Pif(Ptime(inf) <= 2.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
    \dur, 0.125*3.5,
	\legato, 1.5
).play;
)
(
r = Pbind(
	\instrument, \sawpulse,
    \degree, Pbrown(1, 7, 7, inf),
	\octave, 2,
    \pan, Pn(Pif(Ptime(inf) <= 2.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
    \dur, 0.125*1.5,
	\legato, 1.5
).play;

)
p.play;
p.stop;
q.play;
q.stop;
r.play;
r.stop;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 02.- warpWidow      //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

b = Buffer.read(s,"/Users/coyarzun/ima/artProjects/2016_psyDreams/rsrcs/13_freshWidow_mixdown-7eqa_01x.wav"


// play with rnd, overlap + grainSize for taste
(
m.program(0, 5);

~granulator = { |bufnum, rate = 0.33, freqScale=1.33, grainSize=0.4, overlaps=4, rnd=0.3|
	Pan2.ar(
		Warp1.ar(
			bufnum.numChannels,
			bufnum,
			LFSaw.kr(BufDur.kr(bufnum).reciprocal * rate,1,0.5,0.5),
			freqScale,
			grainSize,
			-1, overlaps, rnd);
	)
}.play(args: [\bufnum, b]);

TempoClock.default.tempo = 94.5*2/60;//199.5/60;//95*2/60;//

~kk = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\degree, Pwhite(0, 0, inf),\octave, 3,\dur, Pwhite(2, 2, inf),\legato, 0,\amp, 2).collect({ |event|~lastDrumEvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.2));

)

//~granulator.set(\rate, 3.15);
~granulator.set(\rate, 1.33);
~granulator.set(\rate, 0.33);
~granulator.set(\rate, 9);
~granulator.set(\rate, 0.0033);
~granulator.set(\rate, 0.00000033);
b.stop;

~kk.stop;
b.stop;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

(
var w,f;

w = Window("warp", Rect(400,400,300,125));
w.view.background_(Color.rand);
f = w.addFlowLayout;

EZSlider(w, 280@20, "rate", [0.1,4],  {|sl| ~granulator.set(\rate, sl.value) }, 1);
EZSlider(w, 280@20, "freqScale", [0.1,4],  {|sl| ~granulator.set(\freqScale, sl.value) }, 1);
EZSlider(w, 280@20, "grainSize", [0.01,1],  {|sl| ~granulator.set(\grainSize, sl.value) }, 0.2);
EZSlider(w, 280@20, "overlaps", [1,8,\lin,1],  {|sl| ~granulator.set(\overlaps, sl.value) }, 4);
EZSlider(w, 280@20, "rnd", \unipolar,  {|sl| ~granulator.set(\rnd, sl.value) }, 0.1);

w.front;
)

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 03.- egg            //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
TempoClock.default.tempo = 5;

m.allNotesOff(0);
m.allNotesOff(1);
n.allNotesOff(1);


m.program(0, 32);

m.control(9,0,1);
m.program(9, 5);



~bass = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,\degree, Pwhite(5, 5+12, inf),\octave, 1,\dur, Pwhite(1, 3, inf),\legato, 1,\amp, 2).collect({ |event|~lastBassvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));

~bass.stop;

/////////////////////////////////////////////////////////////////////////////////////
n.control(1,0,1);
n.program(1, 47);

~bass2 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, n,\chan,1,\degree, Pwhite(5, 5+12, inf),\octave, 2,\dur, Pwhite(1, 3, inf),\legato, 1,\amp, 0.2).collect({ |event|~lastBassvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));

~bass3 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, n,\chan,1,\degree, Pwhite(5, 5+12, inf),\octave, 5,\dur, Pwhite(1, 3, inf),\legato, 1,\amp, 0.2).collect({ |event|~lastBassvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));

~bass2.stop;
~bass3.stop;



/////////////////////////////////////////////////////////////////////////////////////

~drum1 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\degree, Pwhite(0, 7, inf),\octave, 3,\dur, Pwhite(1, 1, inf),\legato, 1,\amp, 0.5).collect({ |event|~lastDrumEvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));
~drum2 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\degree, Pwhite(0, 7, inf),\octave, 3,\dur, Pwhite(1, 2, inf),\legato, 1,\amp, 0.3).collect({ |event|~lastDrumEvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));
~drum3 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\degree, Pwhite(0, 7, inf),\octave, 3,\dur, Pwhite(1, 3, inf),\legato, 1,\amp, 0.3).collect({ |event|~lastDrumEvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));
~drum4 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\degree, Pwhite(0, 7, inf),\octave, 3,\dur, Pwhite(1, 4, inf),\legato, 1,\amp, 0.5).collect({ |event|~lastDrumEvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));
~drum5 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\degree, Pwhite(0, 7, inf),\octave, 3,\dur, Pwhite(1, 5, inf),\legato, 1,\amp, 0.5).collect({ |event|~lastDrumEvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));

~drum6 = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\degree, Pwhite(14, 16, inf),\octave, 3,\dur, Pwhite(1, 2, inf),\legato, 1,\amp, 0.8).collect({ |event|~lastDrumEvent = event;}).play(quant: Quant(quant: 1, timingOffset: 0.1));

~drum1.stop;
~drum2.stop;
~drum3.stop;
~drum4.stop;
~drum5.stop;
~drum6.stop;

/////////////////////////////////////////////////////////////////////////////////////

//TempoClock.default.tempo = 0.5;
TempoClock.default.tempo = 20;
TempoClock.default.tempo = 1;
TempoClock.default.tempo = 2.5;
TempoClock.default.tempo = 3.5;
TempoClock.default.tempo = 4.0;
TempoClock.default.tempo = 4.5;
TempoClock.default.tempo = 5;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 04.- cardioid       //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

m.allNotesOff(0);
m.allNotesOff(1);
n.allNotesOff(1);

m.program(0, 87);//B38 = 10*8+8-1

m.control(9,0,1);
m.program(9, 5);

n.control(1,0,0);
n.program(1, 2);

TempoClock.default.tempo = 2*157/120;

(
~chords1 = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 0,
    \degree, Pwhite(1, 4, inf),
    \octave, 6,
    \dur, Pwhite(4, 12, inf),
    \legato, 0.5,
    \amp, 0.2
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.1));
)

(
~chords2 = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 0,
    \degree, Pwhite(1, 4, inf),
    \octave, 7,
    \dur, Pwhite(4, 12, inf),
    \legato, 0.5,
    \amp, 0.2
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.2));
)

(
~hhat = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 9,
    \degree, 13,
    \octave, 3,
    \dur, 0.5,
    \amp, 0.8
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.1));
)

(
~keys = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 9,
    \degree, Pwhite(8, 9, inf),
    \octave, 5,
    \dur, 0.5,
    \amp, 1.8
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.6));
)

(
~kick = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 9,
    \degree, 0,
    \octave, 3,
    \dur, 2,
    \amp, 1
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.1));
)

(
~bassJ = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, n,
    \chan, 1,
    \degree, Pwhite(1, 4, inf),
    \octave, 2,
    \dur, 0.5,//Pwhite(1, 4, inf),
    \legato, 1,
    \amp, 0.2
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.1));

)

(
~chords3 = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 0,
    \degree, Pwhite(1, 4, inf),
    \octave, 8,
    \dur, Pwhite(0.125, 1, inf),
    \legato, 1.5,
    \amp, 0.2
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.2));
)

(
~bassK = Pbind(
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 1,
    \degree, Pwhite(1, 4, inf),
    \octave, 4,
    \dur, 0.5,
    \legato, 1,
    \amp, 0.5
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.6));

)
~bassk.stop;

~hhat.stop;
~hhat.play(quant: Quant(quant: 1, timingOffset: 0.1));

~keys.play;
~keys.stop;

~kick.stop;
~kick.play(quant: Quant(quant: 1, timingOffset: 0.1));

~chords1.play;
~chords1.stop;

~chords2.play;
~chords2.stop;

~chords3.stop;
~chords3.play(quant: Quant(quant: 1, timingOffset: 0.1));;

~bassJ.stop;
~bassJ.play(quant: Quant(quant: 1, timingOffset: 0.1));


~bassK.stop;
~bassK.play(quant: Quant(quant: 1, timingOffset: 0.1));

(
~bassJ.stop;
~kick.stop;
)
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 05.- toshimiYeah!   //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

(

t = Pfset({
	~buf = Buffer.read(s, "/Users/coyarzun/ima/artProjects/2016_psyDreams/rsrcs/toshimi.wav");//Platform.resourceDir +/+ "sounds/a11wlk01.wav");
    0.2.yield;    // sync seems to be incompatible with patterns
    ~bufFrames = ~buf.numFrames;
}, Pbind(
    \instrument, \playbuf,
        // access resources in the protoevent by Pkey
    \bufnum, Pkey(\buf),
    \dur, Pwhite(1, 4, inf) * 0.25,
        // upper bound of Pwhite is based on duration
        // so that start + (dur * samplerate) never goes past the buffer's end
    \start, Pwhite(0, Pkey(\bufFrames) - (Pkey(\dur) * 44100*1), inf)
), { defer(inEnvir { "freeing buffer".postln; ~buf.free }, 1.1) }).play;
)

// shows a buffer number allocated ('true' ContiguousBlock)
s.bufferAllocator.debug;


t.stop;


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 06.- textToSpeech!  //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


Speech.init(2);
Speech.channels[0].speak("hallo");
Speech.channels[0].isActive;
Speech.channels[0].voice_(3);
Speech.channels[0].speak("IDEOLOGICALLY");
Speech.channels[0].pitch_(-110.1101);
Speech.channels[0].speak("hallo");
Speech.channels[0].volume_(1.0.dbamp);//-20.dbamp);
Speech.channels[0].pitchMod_(50);
Speech.channels[0].speak("hallo");
Speech.channels[0].stop(\immediate);
Speech.channels[0].stop(\endOfWord);
Speech.channels[0].stop(\endOfSentence);


//Force the voice to speaking something different by setting the second argument of speak to true.
Speech.channels[0].speak("Force the voice to speaking something different.");
Speech.channels[0].speak("Force the voice to speaking something different.".reverse, true);
//First argument is always the voice channel number, second the value.
//*/
Speech.setSpeechVoice(0,3);
Speech.setSpeechPitch(0, 38); //pitch in MIDI Num
Speech.setSpeechRate(0, 10);
Speech.setSpeechVolume(0,0.1);//0,0.1);
Speech.setSpeechPitchMod(0, 200);
Speech.stop(0, 1);
//Two actions can be applied:
Speech.wordAction = {arg voiceNum;i.postln;Speech.setSpeechPitch(voiceNum,[41,60].choose);Speech.setSpeechRate(voiceNum,[60,80, 10].choose);};
Speech.doneAction_({arg voiceNum;Speech.setSpeechPitch(voiceNum,[41,48,40,43,30,60].choose);});
//Pause the speech while speaking: 1=pause, 0= start
Speech.pause(0,1);
//Initialization happens automatically, by default with one voice channel. You may explicitly initialize with more channels, up to 16:

(
Speech.init(16);

Task({
    16.do ({arg i;
        [0.1, 0.18, 0.2].choose.wait;
        Speech.setSpeechRate(i,[90, 30, 60].choose);
        Speech.setSpeechVolume(i,0.2);
        "no this is private. float . boolean me. char[8] ".speak(i);
    });
}).play;
)

//jan@sampleAndHold.org 04/2003
//update 10/2007

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 07.- lost&found     //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

TempoClock.default.tempo = 4;//1.8*132/60;


m.program(0, 64+12);
n.control(1,0,0);
n.program(1, 12);

(
m.allNotesOff(0);
m.allNotesOff(1);
n.allNotesOff(1);
)


(
~violins =

	//Pxrand([
EventPatternProxy(
Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,
        \midinote,

		Pseq(-12+9+24+[
                    70, 72, 70, 63, 65, 67, 65, 60
                    ], inf),
        \dur, Pwhite(0, 4, inf),
        \legato, 0.9,\amp, 1.0)
)
.play(quant: Quant(quant: 1, timingOffset: 0.1));


~bassV = EventPatternProxy(
Pbind(\type, \midi,\midicmd,\noteOn,\midiout, n,\chan,1,
	\midinote, Pseq(-12+9+0+[24, 24, 36, 36, 24, 24, 36, 36,
                         24, 24, 36, 36, 24, 24, 36, 36,
                         24+2, 24+2, 36+2, 36+2, 24+2, 24+2, 36+2, 36+2,
                         24+2, 24+2, 36+2, 36+2, 24+2, 24+2, 36+2, 36+2,
                         24+2+5, 24+2+5, 36+2+5, 36+2+5, 24+2+5, 24+2+5, 36+2+5, 36+2+5,
                         24+2+5, 24+2+5, 36+2+5, 36+2+5, 24+2+5, 24+2+5, 36+2+5, 36+2+5,
                         24+2+5, 24+2+5, 36+2+5, 36+2+5, 24+2+5, 24+2+5, 36+2+5, 36+2+5,
                         24+2+5, 24+2+5, 36+2+5, 36+2+5, 24+2+5, 24+2+5, 36+2+5, 36+2+5
		], inf),
        \dur, 1,
        \legato, 0.9,\amp, 1.0)
)
.play(quant: Quant(quant: 1, timingOffset: 0.1));

~drumV = EventPatternProxy(
Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,
	\midinote, Pseq([
			//36, 42, 38, 42, 36, 36, 38, 42
			36,42,42,42,38,42,42,42,36,42,42,42,38,42,42,42
		], inf),
        \dur, 0.5,
        \legato, 0.9,\amp, 0.5)
)
.play(quant: Quant(quant: 1, timingOffset: 0.1));
)

(
~violins.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,\midinote, Pseq([
	0, 60, 65, 68, 67, 68, 67, 60,
//                    62, 63, 62, 55, 58, 60, 58, 51,
//                   70, 72, 70, 63, 65, 67, 65, 60
], inf),\dur,
	Pwhite(0, 2, inf)
//	1.0
	,\legato, 1.8,\amp, 3.0);
)
(
~bassV.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, n,\chan,1,\midinote,
	Pseq(12+9+[
//		70, 72, 70, 63, 65, 67, 65, 60,
		24+2//, 24+2, 36+2, 36+2, 24+2, 24+2, 36+2, 36+2,
//		70-12, 72-12, 70-12, 63-12, 65-12, 67-12, 65-12, 60-12,
//                    24, 24, 36, 36, 24, 24, 36, 36
], inf),\dur, 0.5,\legato, 0.6,\amp, 0.5);
)
(
~drumV.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\midinote, Pseq([38,42,42,42,36,42,42,42,38,42,42,42,36,42,42,42], inf),\dur, 0.5,\legato, 0.9,\amp, 1.0);
)



~violins.stop;
//~violins.play(quant: Quant(quant: 1, timingOffset: 0.1));
(
~bassV.stop;
~drumV.stop;
)
~drumV.stop;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 08.- karmaZqncer    //////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
TempoClock.default.tempo = 1.9;

m.program(0, 16);
n.control(1,0,0);
n.program(1, 2);

m.control(9,0,1);
m.program(9, 5);

m.allNotesOff(0);
m.allNotesOff(1);
n.allNotesOff(1);

(
~bassdrum = EventPatternProxy(
	        Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,
	              \midinote, Pseq([36,36,36,36], inf),
                  \dur, 1,
                  \legato, 0.9,\amp, 1.0)
            ).play(quant: Quant(quant: 1, timingOffset: 0.1));
~someBass2 = EventPatternProxy(
	        Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,1,
	              \midinote, Pseq([38,50,38+5,38+5+12,38-2], inf),
                  \dur,      0.25,
                  \legato,   0.9,\amp, 1.0)
           ).play(quant: Quant(quant: 1, timingOffset: 0.1));

~someBass = EventPatternProxy(
	        Pbind(\type, \midi,\midicmd,\noteOn,\midiout, n,\chan,1,
	              \midinote, Pseq([38,50,50], inf),
                  \dur,      0.25,
                  \legato, 0.9,\amp, 1.0)
           ).play(quant: Quant(quant: 1, timingOffset: 0.1));

~someKeys = EventPatternProxy(
	        Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,
	              \midinote, Pseq(12+[38,50], inf),
                  \dur,      0.25,
                  \legato, 0.9,\amp, 1.0)
           ).play(quant: Quant(quant: 1, timingOffset: 0.1));

)

//p = Pchain(~someBass, ~bassdrum).play;
~bassdrum.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\midinote, Pseq([36,42,42,42,36,42,42,42,36,42,42,42,36,42,42,42], inf),\dur, 0.25,\legato, 0.9,\amp, 1.0);

~bassdrum.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\midinote, Pseq([36,42,42,42,38,42,42,42,36,42,42,42,38,42,42,42], inf),\dur, 0.25,\legato, 0.9,\amp, 1.0);

~bassdrum.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,9,\midinote, Pseq([36], inf),\dur, 1,\legato, 0.9,\amp, 1.0);

~someBass2.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,1,\midinote, Pseq([38,50,50], inf),\dur, Pseq([0.25,0.25,0.25], inf),\legato, 0.9,\amp, 1.0);

~someBass2.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,1,\midinote, Pseq([38,50,38+5,38+12,38+12+5], inf),\dur, 0.25,\legato, 0.9,\amp, 1.0);

~someBass2.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,1,\midinote, Pseq([38,50], inf),\dur, 0.25,\legato, 0.9,\amp, 1.0);

~someBass.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, n,\chan,1,\midinote, Pseq([38,50], inf),\dur, 0.25,\legato, 0.9,\amp, 1.0);

~someBass.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, n,\chan,1,\midinote, Pseq(12+[38,50,50], inf),\dur, 0.25,\legato, 0.9,\amp, 1.0);

~someKeys.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,\midinote, Pseq(2*12+[38,50,50], inf),\dur, 0.25,\legato, 0.9,\amp, 1.0);

~someKeys.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,\midinote, Pseq(31+12+[38,50,38+5,38+5+12,38-2], inf),\dur, 0.5,\legato, 0.8,\amp, 1.0);

~someKeys.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,\midinote, Pseq(31+12*2.0+[38,50,38+5,38+5+12,38-2], inf),\dur, 0.5,\legato, 0.8,\amp, 1.0);

~someKeys.source = Pbind(\type, \midi,\midicmd,\noteOn,\midiout, m,\chan,0,\midinote, Pseq(12+[38,50,38+5,38+5+12,38-2], inf),\dur, 0.5,\legato, 0.8,\amp, 1.0);


~someKeys.stop;
~bassdrum.stop;
~someBass.stop;
~someBass2.stop;


/////////////////////////////////////////////////////////////////////////////////////