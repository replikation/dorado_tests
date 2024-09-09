process dorado {
        executor = 'local'
        label 'dorado'
        maxForks 1
        storeDir "${params.output}/${name}/${name}_${models[0]}/"
    input:
        tuple val(name), path(dir)
        each (models)
    output:
        tuple val(name), val(models), path("${name}_${models[0]}.fastq.gz"), emit: reads
    script:
        """
        dorado download --model ${models[1]}
        mv ${models[1]} 1_model
        dorado basecaller --device cuda:all -r --emit-fastq 1_model/ ${dir} | gzip > ${name}_${models[0]}.fastq.gz
        
        # reduce foodprint
        rm -r 1_model
        """

    stub:
    """
    touch ${name}_${models[0]}.fastq.gz
    """
}
