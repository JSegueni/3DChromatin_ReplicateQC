rule data_to_hifive:
    input:

    output:

    script:
        "script/data_to_hifive.py snakemake.input['sample.fulldata'] snakemake.input['partition'] snakemake.output['sample.quasar_data']"
