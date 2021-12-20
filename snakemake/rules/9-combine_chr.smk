rule combine_chr:
    input:
        vs="results/QuASAR/{cell_line}_1_vs_{cell_line}_2.quasar_rep.scores.txt"
    output:
        final="results/QuASAR/{cell_line}_1_vs_{cell_line}_2.txt"
    params:
        sample_1=lambda wildcards: [wildcards.cell_line]+"_1",
        sample_2=lambda wildcards: [wildcards.cell_line]+"_2"
    conda: "../conda.yaml"
    shell:
        "python2 scripts/quasar_combine_by_chromosomes.py {input.vs} {params.sample_1} {params.sample_2}"
