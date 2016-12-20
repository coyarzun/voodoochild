(
SynthDef(\bass, { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.7, ffreq = 550, width = 0.315,
        detune = 1.005, preamp = 4|
    var    sig,
        env = Env.adsr(0.01, 0.4, 0.4, 0.1);
    freq = Lag.kr(freq, slideTime);
    sig = Mix(VarSaw.ar([freq, freq * detune/1], 0, width, preamp)).distort * amp
        * EnvGen.kr(env, gate, doneAction: 2);
    sig = LPF.ar(sig, ffreq);
    Out.ar(0, sig ! 2)
}).add;
)

(
// this kick drum doesn't sound so good on cheap speakers
// but if your monitors have decent bass, it's electro-licious
SynthDef(\kik, { |basefreq = 50, ratio = 7, sweeptime = 0.05, preamp = 1, amp = 1,
        decay1 = 0.3, decay1L = 0.8, decay2 = 0.15, out|
    var    fcurve = EnvGen.kr(Env([basefreq * ratio, basefreq], [sweeptime], \exp)),
        env = EnvGen.kr(Env([1, decay1L, 0], [decay1, decay2], -4), doneAction: 2),
        sig = SinOsc.ar(fcurve, 0.5pi, preamp).distort * env * amp;
    Out.ar(out, sig ! 2)
}).add;

SynthDef(\kraftySnr, { |amp = 1, freq = 2000, rq = 3, decay = 0.3, pan, out|
    var    sig = PinkNoise.ar(amp),
        env = EnvGen.kr(Env.perc(0.01, decay), doneAction: 2);
    sig = BPF.ar(sig, freq, rq, env);
    Out.ar(out, Pan2.ar(sig, pan))
}).add;

~commonFuncs = (
        // save starting time, to recognize the last bar of a 4-bar cycle
    init: {
        if(~startTime.isNil) { ~startTime = thisThread.clock.beats };
    },
        // convert the rhythm arrays into patterns
    pbindPairs: { |keys|
        var    pairs = Array(keys.size * 2);
        keys.do({ |key|
            if(key.envirGet.notNil) { pairs.add(key).add(Pseq(key.envirGet, 1)) };
        });
        pairs
    },
        // identify rests in the rhythm array
        // (to know where to stick notes in)
    getRestIndices: { |array|
        var    result = Array(array.size);
        array.do({ |item, i|
            if(item == 0) { result.add(i) }
        });
        result
    }
);
)

(
TempoClock.default.tempo = 120 / 60;

~kikEnvir = (
    parent: ~commonFuncs,
        // rhythm pattern that is constant in each bar
    baseAmp: #[1, 0, 0, 0,  1, 0, 0, 0,  1, 0, 0, 0,  1, 0, 0, 0] * 0.5,
    baseDecay: #[0.15, 0, 0, 0,  0,15, 0, 0, 0,  0.15, 0, 0, 0, 0.15, 0, 0, 0],
    addNotes: {
        var    beat16pos = (thisThread.clock.beats - ~startTime) % 16,
            available = ~getRestIndices.(~baseAmp);
        ~amp = ~baseAmp.copy;
        ~decay2 = ~baseDecay.copy;
            // if last bar of 4beat cycle, do busier fills
        /*if(beat16pos.inclusivelyBetween(1, 16)) {
            available.scramble[..rrand(5, 10)].do({ |index|
                    // crescendo
                ~amp[index] = index.linexp(0, 15, 0.2, 0.5);
                ~decay2[index] = 0.15;
            });
        } {
            available.scramble[..rrand(0, 2)].do({ |index|
                ~amp[index] = rrand(0.15, 0.3);
                ~decay2[index] = rrand(0.05, 0.1);
            });
        }*/
    }
);

~snrEnvir = (
    parent: ~commonFuncs,
    baseAmp: #[0, 0, 0, 0,  1, 0, 0, 0,  0, 0, 0, 0,  1, 0, 0, 0] * 1.5,
    baseDecay: #[0, 0, 0, 0,  0.4, 0, 0, 0,  0, 0, 0, 0,  0.4, 0, 0, 0],
    addNotes: {
        var    beat16pos = (thisThread.clock.beats - ~startTime) % 16,
            available = ~getRestIndices.(~baseAmp),
            choice;
        ~amp = ~baseAmp.copy;
        ~decay = ~baseDecay.copy;
        if(beat16pos.inclusivelyBetween(12, 16)) {
            available.scramble[..rrand(5, 9)].do({ |index|
                ~amp[index] = index.linexp(0, 15, 0.5, 1.8);
                ~decay[index] = rrand(0.2, 0.4);
            });
        } {
            available.scramble[..rrand(1, 3)].do({ |index|
                ~amp[index] = rrand(0.15, 0.3);
                ~decay[index] = rrand(0.2, 0.4);
            });
        }
    }
);

~hhEnvir = (
    parent: ~commonFuncs,
    baseAmp: 15 ! 16,
    baseDelta: 0.25 ! 16,
    addNotes: {
        var    beat16pos = (thisThread.clock.beats - ~startTime) % 16,
            available = (0..15),
            toAdd;
            // if last bar of 4beat cycle, do busier fills
        ~amp = ~baseAmp.copy;
        ~dur = ~baseDelta.copy;
/*        if(beat16pos.inclusivelyBetween(12, 16)) {
            toAdd = available.scramble[..rrand(2, 5)]
        } {
            toAdd = available.scramble[..rrand(0, 1)]
        };
        toAdd.do({ |index|
            ~amp[index] = ~doubleTimeAmps;
            ~dur[index] = ~doubleTimeDurs;
        });*/
    },
    doubleTimeAmps: Pseq(#[15, 10], 1),
    doubleTimeDurs: Pn(0.125, 2)
);


~kik = Penvir(~kikEnvir, Pn(Plazy({
    ~init.value;
    ~addNotes.value;
    Pbindf(
        Pbind(
            \instrument, \kik,
            \preamp, 0.4,
            \dur, 0.25,
            *(~pbindPairs.value(#[amp, decay2]))
        ),
            // default Event checks \freq --
            // if a symbol like \rest or even just \,
            // the event is a rest and no synth will be played
        \freq, Pif(Pkey(\amp) > 0, 1, \rest)
    )
}), inf)).play(quant: 4);

~snr = Penvir(~snrEnvir, Pn(Plazy({
    ~init.value;
    ~addNotes.value;
    Pbindf(
        Pbind(
            \instrument, \kraftySnr,
            \dur, 0.25,
            *(~pbindPairs.value(#[amp, decay]))
        ),
        \freq, Pif(Pkey(\amp) > 0, 5000, \rest)
    )
}), inf)).play(quant: 4);

~hh = Penvir(~hhEnvir, Pn(Plazy({
    ~init.value;
    ~addNotes.value;
    Pbindf(
        Pbind(
            \instrument, \kraftySnr,
            \rq, 0.06,
            \amp, 15,
            \decay, 0.04,
            *(~pbindPairs.value(#[amp, dur]))
        ),
        \freq, Pif(Pkey(\amp) > 0, 12000, \rest)
    )



}), inf)).play(quant: 4);
)

// stop just before barline
t = TempoClock.default;
t.schedAbs(t.nextTimeOnGrid(4, -0.001), {    [~kik, ~snr, ~hh].do(_.stop);});
~snr.stop;

~snr.play(quant:1);



// To keep looping the envelope, wrap Pif inside Pn
(
p = Pbind(
	\instrument, \bass,
	\degree, Pwhite(-7+24, 0+24+12, inf),
    \pan, Pn(Pif(Ptime(inf) <= 4.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
	\dur, 0.25
).play;
)

p.stop;



(
// this SynthDef has a strong attack, emphasizing the articulation
SynthDef(\sawpulse, { |out, freq = 440, gate = 0.15, plfofreq = 8, mw = 0, ffreq = 4400, rq = 0.213, freqlag = 1.5, amp = 0.8|
    var sig, plfo, fcurve;
    plfo = SinOsc.kr(plfofreq, mul:mw, add:1);
    freq = Lag.kr(freq, freqlag) * plfo;
    fcurve = EnvGen.kr(Env.adsr(0, 0.3, 0.1, 20), gate);
    fcurve = (fcurve - 1).madd(0.7, 1) * ffreq;
    sig = Mix.ar([Pulse.ar(freq, 0.9), Saw.ar(freq*1.7)]);
    sig = RLPF.ar(sig, fcurve, rq)
        * EnvGen.kr(Env.adsr(0.04, 0.2, 0.6, 0.1), gate, doneAction:2)
        * amp;
    Out.ar(out, sig ! 2)
}).add;
)


(

	~phrases = (
    repeated: Pbind(
        \instrument, \bass,
        \midinote, 38,
        \dur, Pseq([0.25*2, 0.25*2, 0.25*2, 0.25*2], 1),
        \legato, Pseq([0.9, 0.3, 0.3, 0.3], 1),
        \amp, 0.5, \detune, 1.005
    ),
    octave: Pmono(\bass,
        \midinote, Pseq([38, 45, 47, 50], 1),
        \dur, Pseq([0.25, 0.5, 0.25, 0.5], 1),
        \amp, 0.5, \detune, 1.005
    ),
    tritone: Pmono(\bass,
        \midinote, Pseq([36, 42, 41, 33], 1),
        \dur, Pseq([0.25, 0.25, 0.25, 0.75], 1),
        \amp, 0.5, \detune, 1.005
    ),
    dim: Pmono(\bass,
        \midinote, Pseq([36, 39, 36, 42], 1),
        \dur, Pseq([0.25, 0.5, 0.25, 0.5], 1),
        \amp, 0.5, \detune, 1.005
    )
);

//TempoClock.default.tempo = 60/60;

// the higher level control pattern is really simple now
p = Psym(Pxrand(#[repeated], inf), ~phrases).play;//octave, tritone, dim
	)

p.stop;





(
//TempoClock.default.tempo = 1;

/*~bass = Pbind(
    \degree, Pwhite(0, 7, inf),
    \octave, 3,    // down 2 octaves
    \dur, Pwhite(1, 4, inf),
    \legato, 1,
    \amp, 0.2
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.1));*/

// shorter form for the Quant object: #[1, 0, 0.1]

~chords = Pbind(
	\instrument, \sawpulse,
    \topNote, Pseries(5, Prand(#[-7, -2, 5, 2], inf), inf).fold(2, 14),
    \bassTriadNotes, Pfunc { ~lastBassEvent[\degree] } + #[0, 2, 4],
        // merge triad into topnote
        // raises triad notes to the highest octave lower than top note
        // div: is integer division, so x div: 7 * 7 means the next lower multiple of 7
    \merge, (Pkey(\topNote) - Pkey(\bassTriadNotes)) div: 7 * 7 + Pkey(\bassTriadNotes),
        // add topNote to the array if not already there
    \degree, Pfunc { |ev|
        if(ev[\merge].detect({ |item| item == ev[\topNote] }).isNil) {
            ev[\merge] ++ ev[\topNote]
        } {
            ev[\merge]
        }
    },
    \dur, Pwrand([Pseq([0.125, Pwhite(1, 3, 1), 0.25], 1), 1, 2, 3], #[1, 3, 2, 2].normalizeSum, inf),
    \amp, 0.125
).play(quant: 1);
)

~bass.stop;
~chords.stop;
~chords.play(quant: 1);