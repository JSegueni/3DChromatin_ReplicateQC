rule fulldata:
    input:
        "input/{sample}.hicqc.gz"
    output:
        temp("results/QuASAR/{sample}.fulldata.gz")
    log:
        "logs/fulldata/{sample}.log"
    conda: "../conda.yaml"
    shell:
        "scripts/fulldata.sh {input} > {output} 2> {log}"