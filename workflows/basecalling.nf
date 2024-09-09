include { dorado } from './process/dorado'



workflow basecalling_wf {
    take: pod5_dir
          ch_models

    main:
            dorado(pod5_dir, ch_models)


    emit:   dorado.out
}
