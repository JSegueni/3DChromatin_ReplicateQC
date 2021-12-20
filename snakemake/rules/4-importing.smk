rule importing:
    input:
        quasar_data="results/QuASAR/{sample}.quasar_data"
    output:
        quasar_project="results/QuASAR/{sample}.quasar_project"
    conda: "../conda.yaml"
    shell:
        "python2 scripts/importing.py {quasar_data} {quasar_project}"
