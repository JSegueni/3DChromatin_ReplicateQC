rule QuASAR_QC:
    input:

    output:

    shell:
        "hifive quasar -p {input.sample.quasar_project} {output.sample.quasar_transform} -r {params.resolution} -d {params.coverage}"