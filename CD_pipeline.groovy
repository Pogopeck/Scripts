pipeline {
    environment {

    }
    agent {
        node {
            label 'ccramer09_decr46hr'
        }
    }
    stages {
        stage('ARM_MM pre scripts excution') { // Pre_mm scripts execution
            steps {
                sh '''
                cd /Custom_HF_R5.11.0.1/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @update_circuittype.sql |tee -a update_circuittype.log
                cd /Custom_HF_R5.11.0.3/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_addressrel_rel.sql |tee -a pre_mm_del_addressrel_rel.log
                cd /Custom_HF_R5.11.0.5/ARM_MM/Pre_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_loctypeloctype.sql |tee -a pre_mm_del_loctypeloctype.log
                '''
            }
          }
        stage('ANN_MM pre scripts excution') { // Pre_mm scripts execution
            steps {
                sh '''
                cd /Custom_HF_R5.11.0.1/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @update_circuittype.sql |tee -a update_circuittype.log
                cd /Custom_HF_R5.11.0.3/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_addressrel_rel.sql |tee -a pre_mm_del_addressrel_rel.log
                cd /Custom_HF_R5.11.0.5/ARM_MM/Pre_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_loctypeloctype.sql |tee -a pre_mm_del_loctypeloctype.log
                '''
            }
          }
        stage('ANN_MM cleanup scripts') { // Pre_mm clean up script execution
            steps {
                sh '''
                cd /Custom_HF_R5.11.0.1/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @update_circuittype.sql |tee -a update_circuittype.log
                cd /Custom_HF_R5.11.0.3/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_addressrel_rel.sql |tee -a pre_mm_del_addressrel_rel.log
                cd /Custom_HF_R5.11.0.5/ARM_MM/Pre_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_loctypeloctype.sql |tee -a pre_mm_del_loctypeloctype.log
                '''
            }
          }  
        stage('Parallel Jobs ARM_MM & ANN_MM') { // It will 2 jenkins jobs Parallely
            Parallel {
                stage (ARM_MM) {
                    steps {
                        build job: 'ACC09_PreProd_VFDE_ARM_MM_Deployment', parameters: [string(name: 'Release_Name', value: 'Rollout_5.0'), string(name: 'Patch_Version', value: ${Patch_Version})]
                        }
                    }  
                stage (ANN_MM) {
                    steps {
                        build job: 'ACC09_PreProd_VFDE_ANN_MM_Deployment', parameters: [string(name: 'Release_Name', value: 'Rollout_5.0'), string(name: 'Patch_Version', value: ${Patch_Version})]
                        }
                    }
                 }
            }
        stage('ANN_MM pre scripts excution') { // Pre_mm scripts execution
            steps {
                sh '''
                cd /Custom_HF_R5.11.0.1/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @update_circuittype.sql |tee -a update_circuittype.log
                cd /Custom_HF_R5.11.0.3/ARM_MM/Pre_Post_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_addressrel_rel.sql |tee -a pre_mm_del_addressrel_rel.log
                cd /Custom_HF_R5.11.0.5/ARM_MM/Pre_Script/
                sqlplus CRAMER/CRAMER@CRRMTAJ @pre_mm_del_loctypeloctype.sql |tee -a pre_mm_del_loctypeloctype.log
                '''
            }
          }
        }
    }
