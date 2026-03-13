process MULTIQC {
    conda 'bioconda::multiqc=1.27.1'
    publishDir "results/multiqc", mode: 'copy'

    input:
    path qc_files

    output:
    path 'multiqc_report.html'

    script:
    """
    multiqc -n multiqc_report.html .
    """
}