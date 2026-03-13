#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process enaDownload {

    publishDir "results/fastq/${accession}", mode: 'symlink'

    input:
    val accession

    output:
    tuple val(accession), path("reads_fastq/${accession}/${accession}*.fastq.gz")

    script:
    """
    java -jar ${baseDir}/tools/ena-file-downloader.jar \
      --location=\$PWD\
      --accessions=${accession}\
      --format=READS_FASTQ\
      --protocol=FTP\
      --asperaLocation=null

    """

}

