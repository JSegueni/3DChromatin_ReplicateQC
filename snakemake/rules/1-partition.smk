rule partition:
    input:
        bed_file=config["bed_file"]
    output:
        partition="results/QuASAR/partition/nodes.partition"
    params:
        subset_chr=config["chr"],
        resolution=config["resolution"]
    conda: "../conda.yaml"
    shell:
        "python2 scripts/make_partition_from_bedfile.py --nodes {input.bed_file} " +
        "--partition {output.partition} --subset_chromosomes {params.subset_chr} " +
        "--resolution {params.resolution}"
