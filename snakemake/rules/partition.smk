rule partition:
    input:

    output:

    script:
        "script/make_partition_from_bedfile.py --nodes snakemake.input['bed_file'] --partition snakemake.output['partition'] --subset_chromosomes snakemake.params['subset_chr'] --resolution snakemake.params['resolution']"
