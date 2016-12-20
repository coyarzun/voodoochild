(
SynthDef(\bass, { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.5,
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
TempoClock.default.tempo = 1;
p = Pbind(
	\instrument, \bass,
    \degree, Pswitch1([Pwhite(7, 14, inf), Pwhite(-7, 0, inf)], Pfunc { 0.7.coin.binaryValue }),
    \dur, 0.25
).play;
)

p.stop;


MIDIClient.init;    // if not already done

(

    // substitute your own device here
var    mOut = MIDIOut.newByName("Dispositivo MIDI USB", "Puerto 2").latency_(Server.default.latency);
TempoClock.default.tempo = 1;
p = Pbind(
    \type, \midi,
        // this line is optional b/c noteOn is the default
        // just making it explicit here
    \midicmd, \noteOn,
    \midiout, mOut,    // must provide the MIDI target here
    \chan, 1,
        // degree is converted to midinote, not just frequency
    \degree, Pwhite(-7, 12, inf),
    \dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
    \legato, sin(Ptime(inf) * 0.5).linexp(-1, 1, 1/3, 3),
    \amp, Pexprand(0.5, 1.0, inf)
).play(quant: 1);
)

p.stop;


(
var    mOut1 = MIDIOut.newByName("Dispositivo MIDI USB", "Puerto 1").latency_(Server.default.latency);
var    mOut2 = MIDIOut.newByName("Dispositivo MIDI USB", "Puerto 2").latency_(Server.default.latency);

TempoClock.default.tempo = 157/120;

~bass = Pbind(
	// this line is optional b/c noteOn is the default
    // just making it explicit here
	\type, \midi,
    \midicmd, \noteOn,
    \midiout, mOut2,    // must provide the MIDI target here
    \chan, 1,

    \degree, Pwhite(0, 7, inf),
    \octave, 3,    // down 2 octaves
    \dur, Pwhite(1, 4, inf),
    \legato, 1,
    \amp, 0.2
).collect({ |event|
    ~lastBassEvent = event;
}).play(quant: Quant(quant: 1, timingOffset: 0.1));

// shorter form for the Quant object: #[1, 0, 0.1]

~chords = Pbind(
	\type, \midi,
        // this line is optional b/c noteOn is the default
        // just making it explicit here
    \midicmd, \noteOn,
    \midiout, mOut1,    // must provide the MIDI target here
    \chan, 0,

    \topNote, Pseries(7, Prand(#[-2, -1, 1, 2], inf), inf).fold(2, 14),
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
    \dur, Pwrand([Pseq([0.5, Pwhite(1, 3, 1), 0.5], 1), 1, 2, 3], #[1, 3, 2, 2].normalizeSum, inf),
    \amp, 0.05
).play(quant: 1);
)

~bass.stop;
~chords.stop;
~chords.play(quant: 1);











(
var    mOut1 = MIDIOut.newByName("Dispositivo MIDI USB", "Puerto 1").latency_(Server.default.latency);
var    mOut2 = MIDIOut.newByName("Dispositivo MIDI USB", "Puerto 2").latency_(Server.default.latency);

TempoClock.default.tempo = 104 / 60;

~kikEnvir = (
    parent: ~commonFuncs,
        // rhythm pattern that is constant in each bar
    baseAmp: #[1, 0, 0, 0,  0, 0, 0.7, 0,  0, 1, 0, 0,  0, 0, 0, 0] * 0.5,
    baseDecay: #[0.15, 0, 0, 0,  0, 0, 0.15, 0,  0, 0.15, 0, 0,  0, 0, 0, 0],
    addNotes: {
        var    beat16pos = (thisThread.clock.beats - ~startTime) % 16,
            available = ~getRestIndices.(~baseAmp);
        ~amp = ~baseAmp.copy;
        ~decay2 = ~baseDecay.copy;
            // if last bar of 4beat cycle, do busier fills
        if(beat16pos.inclusivelyBetween(12, 16)) {
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
        }
    }
);

~snrEnvir = (
    parent: ~commonFuncs,
    baseAmp: #[0, 0, 0, 0,  1, 0, 0, 0,  0, 0, 0, 0,  1, 0, 0, 0] * 1.5,
    baseDecay: #[0, 0, 0, 0,  0.7, 0, 0, 0,  0, 0, 0, 0,  0.4, 0, 0, 0],
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
        if(beat16pos.inclusivelyBetween(12, 16)) {
            toAdd = available.scramble[..rrand(2, 5)]
        } {
            toAdd = available.scramble[..rrand(0, 1)]
        };
        toAdd.do({ |index|
            ~amp[index] = ~doubleTimeAmps;
            ~dur[index] = ~doubleTimeDurs;
        });
    },
    doubleTimeAmps: Pseq(#[15, 10], 1),
    doubleTimeDurs: Pn(0.125, 2)
);


~kik = Penvir(~kikEnvir, Pn(Plazy({
    ~init.value;
    ~addNotes.value;
    Pbindf(
        Pbind(
			\type, \midi,
			\midicmd, \noteOn,
			\midiout, mOut1,    // must provide the MIDI target here
			\chan, 0,

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

/*~snr = Penvir(~snrEnvir, Pn(Plazy({
    ~init.value;
    ~addNotes.value;
    Pbindf(
        Pbind(
			\type, \midi,
			\midicmd, \noteOn,
			\midiout, mOut1,    // must provide the MIDI target here
			\chan, 9,

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
			\type, \midi,
			\midicmd, \noteOn,
			\midiout, mOut1,    // must provide the MIDI target here
			\chan, 9,

            \rq, 0.06,
            \amp, 15,
            \decay, 0.04,
            *(~pbindPairs.value(#[amp, dur]))
        ),
        \freq, Pif(Pkey(\amp) > 0, 12000, \rest)
    )
}), inf)).play(quant: 4);*/
)

// stop just before barline
t = TempoClock.default;
t.schedAbs(t.nextTimeOnGrid(4, -0.001), {
    [~kik, ~snr, ~hh].do(_.stop);
});
~snr.stop;
~snr.play(quant:1);

TempoClock.default.tempo = 0.25*157/120;
TempoClock.default.tempo = 0.5*157/120;
TempoClock.default.tempo = 1*157/120;
TempoClock.default.tempo = 1.5*157/120;
TempoClock.default.tempo = 2*157/120;
TempoClock.default.tempo = 4*157/120;
TempoClock.default.tempo = 8*157/120;





