rule data_to_hifive:
    input:
        fulldata="results/QuASAR/fulldata/{sample}.fulldata.gz",
        partition="results/QuASAR/partition/nodes.partition"
    output:
        quasar_data="results/QuASAR/data_to_hifive/{sample}.quasar_data"
    conda: "../conda.yaml"
    shell:
        "python2 scripts/data_to_hifive.py {input.fulldata} {input.partition} {output.quasar_data}"
