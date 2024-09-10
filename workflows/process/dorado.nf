process dorado {
        executor = 'local'
        label 'dorado'
        maxForks 1
        storeDir "${params.output}/${name}/${name}_${models[0]}/"
    input:
        tuple val(name), path(pod5)
        each (models)
    output:
        tuple val(name), val(models), path("${name}_${models[0]}.fastq.gz"), emit: reads
    script:
        """
        dorado download --model ${models[1]}

        mkdir -p pod5_dir
        mv ${pod5} pod5_dir/
        dorado basecaller --device cuda:all -r --emit-fastq ${models[1]} pod5_dir > ${name}_${models[0]}.fastq
        """

    stub:
    """
    touch ${name}_${models[0]}.fastq.gz
    """
}
