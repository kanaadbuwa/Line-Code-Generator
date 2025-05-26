# 📡 MATLAB Line Coding Generator

**This MATLAB script generates visual waveforms for 8 popular digital line coding schemes** based on user-provided binary input. It’s designed for quick analysis, signal visualization, and educational/demo purposes. The output features a graph paper-style background for enhanced clarity and waveform distinction.

---

## 🔧 Features

* ✅ **User Input**: Accepts binary sequences like `[1 0 1 1 0]`
* ✅ **Supported Line Codes**:

  * **NRZ-L**
  * **NRZ-I**
  * **Return-to-Zero (RZ)**
  * **Manchester**
  * **Differential Manchester**
  * **AMI (Alternate Mark Inversion)**
  * **Pseudoternary**
  * **Quaternary (4-Level Line Code)** — binary pairs grouped and mapped to {−3, −1, +1, +3}
* ✅ **Graph-Paper Styled Output**:

  * Dashed vertical lines between bit intervals
  * Grid overlay for amplitude/time correlation
  * Distinct color per encoding scheme
* ✅ **Auto-padding** for odd-length input (for quaternary compatibility)

---

## ▶️ How to Run

### Prerequisites:

* MATLAB R2016b or later (or Octave with basic plotting)

### Run It:

1. Open the `.m` file in MATLAB
2. Run the script
3. Input your binary sequence when prompted:

```matlab
Enter binary data (e.g., [1 0 1 1 0]):
```

That’s it. All 8 line codes will be plotted in subplots with labeled titles.

---

## 🧠 Quaternary Mapping Reference

| Binary Pair | Level |
| ----------- | ----- |
| 00          | -3    |
| 01          | -1    |
| 10          | +1    |
| 11          | +3    |

> If the input length is odd, a `0` is auto-appended to complete the final pair.

---

## 📈 Example Input

```matlab
[1 0 1 1 0 0 1]
```

**Results**: Eight waveform subplots — one for each coding scheme — cleanly separated with consistent timing and amplitude grids.

---

## 💡 Future Extensions (Optional)

Want to extend this? Here's what to build next:

* [ ] Decode signals back to binary
* [ ] Export waveforms to CSV or MAT files
* [ ] Add GUI for interactive inputs
* [ ] Animate transitions for teaching demos
* [ ] Add error-checking and pulse-shaping options

---

## 🛠 Author Notes

This tool is ideal for:

* Engineering students
* DSP/Comms lab simulations
* Digital transmission system debugging
* Quick visual validation of bit encoding logic



