rule data_to_hifive:
    input:
        fulldata="results/QuASAR/{sample}.fulldata.gz",
        partition="results/QuASAR/nodes.partition"
    output:
        quasar_data="results/QuASAR/{sample}.quasar_data"
    conda: "../conda.yaml"
    shell:
        "python2 scripts/data_to_hifive.py {input.fulldata} {input.partition} {output.quasar_data"
