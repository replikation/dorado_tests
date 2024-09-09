include { dorado_gpu } from './process/dorado_gpu'



workflow wf_basecalling_dorado {
    take: pod5_dir
          ch_models

    main:
            dorado_gpu(pod5_dir, ch_models)


    emit:   dorado_gpu.out
}