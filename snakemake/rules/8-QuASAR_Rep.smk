rule QuASAR_Rep:
    input:
        expand("results/QuASAR/QuASAR/{sample}.quasar_transform", sample=samples),
    output:
        vs=temp("results/QuASAR/QuASAR_Rep/{cell_line}_1_vs_{cell_line}_2.quasar_rep.scores.txt")
    params:
        quasar_transform_1=lambda wildcards: "results/QuASAR/QuASAR/" + str([wildcards.cell_line])+ "_1.quasar_transform",
        quasar_transform_2=lambda wildcards: "results/QuASAR/QuASAR/" + str([wildcards.cell_line]) + "_2.quasar_transform"
    conda: "../conda.yaml"
    shell:
        "hifive quasar -Q {params.quasar_transform_2} -o {output.vs} -d 0 {params.quasar_transform_1} && sleep 10"