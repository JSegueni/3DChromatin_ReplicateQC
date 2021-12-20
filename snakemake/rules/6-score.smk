rule score:
    input:
        quasar_transform="results/QuASAR/{sample}.quasar_transform"
    output:
        quasar_score="results/QuASAR/{sample}.quasar_score"
    conda: "../conda.yaml"
    shell:
        "hifive quasar {input.quasar_transform} -o {output.quasar_score}"