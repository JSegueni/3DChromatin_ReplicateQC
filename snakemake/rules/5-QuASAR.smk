rule QuASAR:
    input:
        quasar_project="results/QuASAR/importing/{sample}.quasar_project"
    output:
        quasar_transform="results/QuASAR/QuASAR/{sample}.quasar_transform"
    params:
        resolution=config["resolution"],
        coverage="0"
    conda: "../conda.yaml"
    shell:
        "hifive quasar -p {input.quasar_project} {output.quasar_transform} -r {params.resolution} -d {params.coverage}"