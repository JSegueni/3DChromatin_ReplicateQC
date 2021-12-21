rule score_chr:
    input:
        quasar_score="results/QuASAR/score/{sample}.quasar_score"
    output:
        quasar_score_chr="results/QuASAR/score_chr/chr1.{sample}.quasar_score"
    params:
        sample_name=lambda wildcards: [wildcards.sample]
    conda: "../conda.yaml"
    shell:
        "python2 scripts/quasar_split_by_chromosomes_qc.py {input.quasar_score} {params.sample_name}"
