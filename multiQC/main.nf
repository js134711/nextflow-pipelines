#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include {enaDownload} from './modules/enaDownload.nf'
include {fastqc} from './modules/fastqc.nf'
include {MULTIQC} from './modules/multiqc.nf'

workflow {

    if (params.accessions.size() == 0) {

    def file = new File(params.tsvFile)
    
    accessions = file.readLines()
                        .drop(1)
                        .collect {it.split('\t')[0]}
    
    println "size of accessions from tsv file: ${accessions.size()}"

    accCh = channel.fromList(accessions)

    } else {

    accCh = channel.fromList(params.accessions)

    }   
    
    fastqCh = accCh | enaDownload


    qcCh    = fastqCh | fastqc


    qcCh.collect() | MULTIQC

}