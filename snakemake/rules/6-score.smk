rule score:
    input:
        quasar_transform="results/QuASAR/QuASAR/{sample}.quasar_transform"
    output:
        quasar_score="results/QuASAR/score/{sample}.quasar_score"
    conda: "../conda.yaml"
    shell:
        "hifive quasar {input.quasar_transform} -o {output.quasar_score}"