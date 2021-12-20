rule QuASAR_Rep:
    input:
        quasar_transform_1="results/QuASAR/{cell_line}_1.quasar_transform",
        quasar_transform_2="results/QuASAR/{cell_line}_2.quasar_transform",
    output:
        vs=temp("results/QuASAR/{cell_line}_1_vs_{cell_line}_2.quasar_rep.scores.txt")
    conda: "../conda.yaml"
    shell:
        "hifive quasar -Q {input.quasar_transform_2} -o {output.vs} -d 0 {input.quasar_transform_1} && sleep 10"