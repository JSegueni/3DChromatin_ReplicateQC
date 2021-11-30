import hifive


hic=hifive.HiC(snakemake.input["quasar_project"],'w')

hic.load_data(snakemake.input["fulldata"])

hic.save()