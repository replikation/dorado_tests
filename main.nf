#!/usr/bin/env nextflow
nextflow.enable.dsl=2


/************************** 
* INPUTs
**************************/

if (params.pod5 ) {
    pod5_input_ch = Channel
                .fromPath( params.pod5, checkIfExists: true)
                .map { file -> tuple(file.baseName, file) }
}


ch_models = Channel.from(['4.2.0','dna_r10.4.1_e8.2_400bps_sup@v4.2.0'],['4.3.0','dna_r10.4.1_e8.2_400bps_sup@v4.3.0'],['5.0.0','dna_r10.4.1_e8.2_400bps_sup@v5.0.0'],['res20230922','res_dna_r10.4.1_e8.2_400bps_sup@2023-09-22_bacterial-methylation'])

/************************** 
* Workflows
**************************/

include { basecalling_wf } from './workflows/basecalling.nf'





/************************** 
* WORKFLOW ENTRY POINT
**************************/


workflow {
    // basecalling
      basecalling_wf(pod5_input_ch, ch_models)

}
