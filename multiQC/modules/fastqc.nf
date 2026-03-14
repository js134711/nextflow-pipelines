#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process fastqc {

    conda 'bioconda::fastqc=0.12.1'

    publishDir "results/fastqc/${accession}", mode: 'symlink'

    input: 
    tuple val(accession), path(fastq_files)

    output:
    path "*fastqc.*"

    script:
    fastq_files = (fastq_files instanceof Collection ? fastq_files : [fastq_files])
    """
    fastqc ${fastq_files.join(' ')} -o \$PWD
    """
}