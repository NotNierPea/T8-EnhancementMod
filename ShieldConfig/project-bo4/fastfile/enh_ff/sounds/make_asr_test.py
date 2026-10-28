# usage: python make_asr_test.py
# the intro/loop/outro test sounds (48 kHz mono 16 bits): enh_test_asr_intro/loop/outro.wav (3 files: a rising chirp,
# a seamless 1 s hum, a falling chirp) and enh_test_asr_cut.wav (the same idea in one file, the loop 0.5 s to 2.0 s)
import math, struct, wave, os

RATE = 48000
here = os.path.dirname(os.path.abspath(__file__))


def write(name, samples):
    with wave.open(os.path.join(here, name), "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(RATE)
        w.writeframes(b"".join(struct.pack("<h", int(max(-1, min(1, s)) * 30000)) for s in samples))


def chirp(f0, f1, seconds, fade_in=False, fade_out=False):
    n = int(seconds * RATE)
    out, phase = [], 0.0
    for i in range(n):
        t = i / n
        phase += 2 * math.pi * (f0 + (f1 - f0) * t) / RATE
        a = 0.6 * (t if fade_in else 1) * ((1 - t) if fade_out else 1)
        out.append(a * math.sin(phase))
    return out


def hum(f, trem, seconds):
    # whole cycles of the tone and the tremolo: the end meets the start
    n = int(seconds * RATE)
    return [0.6 * (0.75 + 0.25 * math.sin(2 * math.pi * trem * i / RATE)) * math.sin(2 * math.pi * f * i / RATE) for i in range(n)]


write("enh_test_asr_intro.wav", chirp(200, 600, 0.6, fade_in=True))
write("enh_test_asr_loop.wav", hum(600, 4, 1.0))
write("enh_test_asr_outro.wav", chirp(600, 150, 0.8, fade_out=True))
write("enh_test_asr_cut.wav", chirp(250, 450, 0.5, fade_in=True) + hum(450, 2, 1.5) + chirp(450, 120, 0.7, fade_out=True))
print("written")
