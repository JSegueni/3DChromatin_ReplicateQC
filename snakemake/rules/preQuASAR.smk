/opt/conda/bin/python /opt/3DChromatin_ReplicateQC/wrappers/QuASAR/make_partition_from_bedfile.py --nodes /scratchlocal/7th_run/input/MCF10A_1_10000_3DQC.bed.gz 
--partition /scratchlocal/7th_run/7th_run_output/data/forQuASAR/nodes.partition --subset_chromosomes NA --resolution 10000


gunzip -c  /scratchlocal/7th_run/input/MCF10A_1_10000_QC_perlchr.matrix.tidy.gz | sed 's/chr//g' | awk '{print "chr"$1"\t"$2"\tchr"$3"\t"$4"\t"$5}' | gzip 
> /scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.fulldata.gz

/opt/conda/bin/python /opt/3DChromatin_ReplicateQC/wrappers/QuASAR/data_to_hifive.py /scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.fulldata.gz 
/scratchlocal/7th_run/7th_run_output/data/forQuASAR/nodes.partition /scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.quasar_data

rm /scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.fulldata.gz

/opt/conda/bin/python -c 

"import hifive; hic=hifive.HiC('/scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.quasar_project','w');
hic.load_data('/scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.quasar_data'); hic.save()"

/opt/conda/bin/hifive quasar -p /scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.quasar_project /scratchlocal/7th_run/7th_run_output/data/forQuASAR/MCF10A_1.quasar_transform -r 10000 -d 0





python $script_dir/make_partition_from_bedfile.py --nodes $bed_file --partition $output/data/forQuASAR/nodes.partition --subset_chromosomes $subset_chr --resolution $resolution

gunzip -c $input/$file | sed 's/chr//g' | awk '{print "chr"$1"\t"$2"\tchr"$3"\t"$4"\t"$5}' | gzip > $output/data/forQuASAR/$sample.fulldata.gz

python $script_dir/data_to_hifive.py $output/data/forQuASAR/$sample.fulldata.gz $output/data/forQuASAR/nodes.partition $output/data/forQuASAR/$sample.quasar_data

rm $output/data/forQuASAR/$sample.fulldata.gz

python -c "import hifive; hic=hifive.HiC(snakemake.input["quasar_project"],'w'); hic.load_data(snakemake.input["fulldata"]); hic.save()"

hifive quasar -p $output/data/forQuASAR/$sample.quasar_project $output/data/forQuASAR/$sample.quasar_transform -r $resolution -d 0

