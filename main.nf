#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process sayHello {
    input:
    val msg 

    output:
    stdout

    script:
    """
    python3 - <<PY
print("${msg}")
PY
    """
}

workflow {
    ch = channel.value('Hello, Nextflow!')
    ch.view()
    //sayHello(ch).view()
}