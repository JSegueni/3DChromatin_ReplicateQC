rule verify:
    input:

    output:

    shell:
        "gunzip -c {input.file} | sed 's/chr//g' | awk '{print \"chr\"$1\"\t\"$2\"\tchr\"$3\"\t\"$4\"\t\"$5}' | gzip > {output.sample.fulldata}"