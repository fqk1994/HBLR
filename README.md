# HBLR: Hierarchical Bayesian Low-Rank Modelling for DAS VSP Denoising

Official MATLAB implementation of the paper:

> **Hierarchical Bayesian Low-Rank Modelling for DAS VSP Denoising with Dynamic Structural Constraint**
> Haitao Ma, Yilin Liu, Qiankun Feng\*, Yue Li
> *Expert Systems With Applications*, 2026. [https://doi.org/10.1016/j.eswa.2026.133369](https://doi.org/10.1016/j.eswa.2026.133369)

<!-- Optional badges — uncomment once the repo is public
![MATLAB](https://img.shields.io/badge/MATLAB-R2020b%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)
[![DOI](https://img.shields.io/badge/DOI-10.1016%2Fj.eswa.2026.133369-orange)](https://doi.org/10.1016/j.eswa.2026.133369)
-->

## Overview

**HBLR** is an unsupervised, training-free framework for denoising DAS VSP records corrupted by complex coherent downhole noise (fading, horizontal, optical, checkerboard). It couples an **HDP-GMM** statistical model — which characterizes the complex target-signal distribution and produces adaptive confidence weights — with a dynamic **Structure-Oriented Median Filtering (SOMF)** physical prior, optimized jointly so that the low-rank component fits the noise while the structural continuity and amplitude of seismic events are preserved.

## Highlights

- A Bayesian framework that unifies statistical modelling and physical constraints for DAS VSP denoising.
- HDP-GMM for adaptive modelling of complex target-signal distributions via data-driven confidence weighting.
- A dynamic SOMF constraint that mitigates rank overlap and signal leakage.
- Weight-guided joint optimization for robust low-rank noise separation.
- No labeled data, no pretraining, and no network training required.


## Requirements

- MATLAB (R2020b or newer recommended)
- Bundled / third-party toolboxes (added via `addpath` in the demo):

| Toolbox | Purpose |
|---------|---------|
| `seistr` | Structure-oriented filtering & local dip (slope) estimation for SOMF |
| `inexact_alm_rpca` | Inexact ALM Robust PCA, used for low-rank initialization |
| `mtimesx` | Fast batched matrix multiplication |
| `subroutines` | Internal helper functions for the HBLR framework |


## Repository structure

<!-- TODO: adjust to match your actual layout before publishing -->
```
.
├── hblr.m                  # main entry point (HBLR optimization, Algorithm 2)
├── set_parameter.m         # builds the opts struct
├── test_hblr1.m            # demo script (multi-view field data)
├── subroutines/            # HDP-GMM inference, low-rank update, SOMF helpers
├── seistr/                 # structure-oriented filtering / dip estimation
├── SegyMAT/                # SEG-Y I/O
├── inexact_alm_rpca/       # RPCA initialization
├── assets/                 # README figures
└── data/                   # input SEG-Y records (not included)
```

## Quick start

1. Clone this repository to your local machine.
2. Ensure all subfolders (`seistr`, `subroutines`, `SegyMAT`, etc.) are added to your MATLAB path.
3. Open  `test_hblr1.m` in MATLAB.
4. Run the script. The algorithm will automatically process the synthetic/field `.segy` datasets and output the denoised signals and noise residuals into new `.segy` files.


## Results

### Synthetic DAS VSP — qualitative comparison
HBLR (g) suppresses the strong coherent interferences while preserving the weak reflections, leaving the cleanest result among the compared methods (SVD, F-X, BP+SOMF+FK, RPCA, U-Net, Diffusion).

[Synthetic denoising comparison](assets\Figure10.png)

### Field DAS VSP (DAS-VSP 1) — qualitative comparison
On openly available field data, HBLR (g) removes coherent noise while faithfully retaining the structural continuity and amplitude of the seismic events.

[Field data 1 denoising comparison](assets\Figure17.png)
[Removed noise sections comparison](assets\Figure18.png)

### Field DAS VSP (DAS-VSP 2 of Utah FORGE dataset) — qualitative comparison
On openly available field data, HBLR (g) removes coherent noise while faithfully retaining the structural continuity and amplitude of the seismic events.

[Field data 2 denoising comparison](assets\Figure20.png)
[Removed noise sections comparison](assets\Figure21.tif)

> See the paper for the full set of experiments, F-K spectra, single-trace analysis, convergence study, ablations, and hyper-parameter sensitivity.

## Datasets

- **Synthetic DAS VSP** — pure signals forward-modeled with the acoustic wave equation (20–90 Hz Ricker wavelets), then contaminated with non-stationary field-extracted DAS noise.
- **Field DAS VSP (Tahe area, China)** — authorized for academic research only; **cannot be redistributed** due to confidentiality agreements with the data provider.
- **Public DAS VSP (Utah FORGE, wells 78A-32 / 78B-32)** — openly available in the OEDI repository under CC BY 4.0: [https://doi.org/10.15121/2541598](https://doi.org/10.15121/2541598).

## Citation

```bibtex
@article{Ma2026HBLR,
  title   = {Hierarchical Bayesian Low-Rank Modelling for DAS VSP Denoising with Dynamic Structural Constraint},
  author  = {Ma, Haitao and Liu, Yilin and Feng, Qiankun and Li, Yue},
  journal = {Expert Systems With Applications},
  year    = {2026},
  doi     = {10.1016/j.eswa.2026.133369}
}
```

## Acknowledgements

Supported by the National Natural Science Foundation of China (grant numbers 42230805, 42304126) and the Natural Science Foundation of Jilin Province, China (grant number 20260102034JC).

## Contact

Qiankun Feng (corresponding author) — fengqk@jlu.edu.cn
College of Communication Engineering, Jilin University, Changchun, China

## License

The HBLR code is released under the [MIT License](LICENSE). Bundled third-party toolboxes retain their original licenses; the Utah FORGE data is CC BY 4.0.

