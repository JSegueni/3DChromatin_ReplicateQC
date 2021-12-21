rule HiCRep:
    input:
        expand("input/{cell_line}_1_" + str(config["resolution"])+ ".hicqc.gz",cell_line=cell_lines),
        expand("input/{cell_line}_2_" + str(config["resolution"]) + ".hicqc.gz", cell_line=cell_lines),
        bed_file=config["bed_file"]
    output:
        expand("results/HiCRep/{cell_line}_1.vs.{cell_line}_2.txt", cell_line=cell_lines)
    params:
        metadata_samples=config["metadata_samples"],
        metadata_pairs=config["metadata_pairs"],
        parameters_file=config["parameters_file"],
        outdir=config["outdir"],
        running_mode=config["running_mode"],
        subset_chr=config["chr"]
    shell:
        "3DChromatin_ReplicateQC run_all --metadata_samples {params.metadata_samples} --metadata_pairs {params.metadata_pairs} --bins {input.bed_file} --outdir {params.outdir} --running_mode {params.running_mode} --subset_chromosomes {params.subset_chr} --parameters_file {params.parameters_file} --methods HiCRep"
    