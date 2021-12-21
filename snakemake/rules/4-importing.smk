rule importing:
    input:
        quasar_data="results/QuASAR/data_to_hifive/{sample}.quasar_data"
    output:
        quasar_project="results/QuASAR/importing/{sample}.quasar_project"
    conda: "../conda.yaml"
    shell:
        "python2 scripts/importing.py {input.quasar_data} {output.quasar_project}"
