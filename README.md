# R Correlogram — Correlation Analysis of Mariana Trench Data

R script computing a pairwise correlation matrix of the Mariana Trench environmental variables and rendering it as a correlogram (a colour/shape-coded grid of correlation coefficients), to reveal the strength and sign of the pairwise relationships at a glance.

## Related publication

This script produced figures in:

Lemenkova, P. Computing and Plotting Correlograms by Python and R Libraries for Correlation Analysis of the Environmental Data in Marine Geomorphology. Journal of Geomorphological Researches 2019, 3, 1-16.

- DOI:      https://doi.org/10.5281/zenodo.3516458
- figshare: https://doi.org/10.6084/m9.figshare.10012808
- HAL:      https://hal.science/hal-02327797
- SSRN:     https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3473861
- ISSN:     2667-4238

## Script

- Correlogram-MarianaTrench.R: reads the data (Depths.csv), computes the Pearson correlation matrix and draws a correlogram (ggcorrplot / corrplot style grid) with a custom ggplot theme (my_theme_Fonts.R).

## Methods

- Pearson correlation-matrix estimation and correlogram visualisation of environmental variables.

## Data

- Depths.csv: depth observations along the Mariana Trench cross-section profiles.

## Requirements

- R (>= 3.5); packages: ggcorrplot / corrplot, ggplot2, RColorBrewer

## Author and citation

Polina Lemenkova — ORCID https://orcid.org/0000-0002-5759-1089

Cite: Lemenkova, P. Computing and Plotting Correlograms by Python and R Libraries for Correlation Analysis of the Environmental Data in Marine Geomorphology. Journal of Geomorphological Researches 2019, 3, 1-16. https://doi.org/10.5281/zenodo.3516458

## License

MIT — see LICENSE (Copyright Polina Lemenkova).
