## Transposable element quantification in immunotherapy treated patient samples

### Datasets (NCBI BioProject)

Individual run-info information for each experiment can be found in the 
[doc/](https://github.com/jcalendo/immuno-analysis/tree/main/doc) folder.

- PRJNA312948 
    - Melanoma biopsies
    - anti-PD1 (Pembrolizumab)
    - 28 BioSamples
- PRJNA356761
    - Melanoma 
    - anti-PD1 (Nivolumab)
    - 109 BioSamples
- PRJNA476140
    - Melanoma
    - anti-PD1, anti-CTLA4
    - 37 BioSamples
- PRJNA498500
    - Glioblastoma
    - anti-PD1
    - 29 BioSamples
- PRJNA693857
    - Melanoma
    - anti-CTLA4
    - 22 BioSamples
- PRJNA694637
    - Esophageal adenocarinoma
    - anti-PD1
    - 77 BioSamples
- PRJNA753518
    - Thymus tissue
    - anti-PD1
    - 26 BioSamples
- PRJNA762343
    - Esophageal and Gastroesophageal
    - anti-PD1
    - 37 BioSamples

### Workflow

A Snakefile is softlinked into each project directory with the analysis workflow steps. Briefly,
raw reads were downloaded from SRA. Run-level data for each experiment is coordinated with a 
samples.csv file. FASTQ files for each run are trimmed and quality filtered using fastp. Trimmed
reads are quantified against the [rmskProfiler](https://github.com/coriell-research/rmskProfiler) 
custom genome using 30 Gibbs resamples correcting for GC, position, and seq biases and including
the `--dumpEq` option. The Gibbs resampled counts are then imported into SummarizedExperiment
objects using `rmskProfiler::importQuants()`. The resulting SummarizedExperiment objects are 
serialized and saved in .rds formatted files for each experiment.


