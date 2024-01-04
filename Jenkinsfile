pipeline {
    agent any
    
    parameters {
        // Choose an environment to deploy frond-end resources: 'dev', 'uat', or 'prod'.
        choice(choices: ['dev', 'uat', 'prod'], name: 'Environment')
        // Apply or destroy resources
        choice(choices: ['apply', 'destroy'], name: 'Operation')
    }
    
    stages {
      stage('Check out code'){
        steps{
          git branch:'master', url:'https://github.com/liwenbo55/p3_Techscrum.tf.fe.git'                
        }
      }

      stage('IaC') {
        steps{
          script {
            withCredentials([
              [$class: 'AmazonWebServicesCredentialsBinding', 
               credentialsId: 'lawrence-jenkins-credential']
            ]){
              dir('app/techscrum_fe'){
                  if (params.Environment in ['dev', 'uat', 'prod']) {
                      echo "Deploying front-end resources for ${params.Environment} environment."
                      
                      // Echo terraform vision
                      sh 'terraform --version'

                      // Terraform init
                      sh "terraform init -reconfigure -backend-config=backend_${params.Environment}.conf"
                      if (params.Operation == 'apply') {
                          sh "terraform plan -var-file=${params.Environment}.tfvars -out=${params.Environment}_${params.Operation}_plan"
                        } else if (params.Operation == 'destroy') {
                          sh "terraform plan -var-file=${params.Environment}.tfvars -out=${params.Environment}_${params.Operation}_plan -destroy"
                        }
                      
                      // Apply plan file
                      sh "terraform apply '${params.Environment}_${params.Operation}_plan'"

                    //   // Plan and generate an apply/destroy file.
                    //   sh "terraform plan -var-file=${params.Environment}.tfvars -out=${params.Environment}_${params.Operation}_plan"

                    // // plan deployment & apply plan
                    // sh "terraform plan -var-file=${params.Environment}.tfvars -out=${params.Environment}_${params.Operation}_plan"
                    // sh "terraform apply '${params.Environment}_plan'"

                    // // // plan for destroy & apply destory
                    // // sh "terraform plan -var-file=${params.Environment}.tfvars -out=${params.Environment}_${params.Operation}_plan -destroy"
                    // // sh "terraform apply '${params.Environment}_destroy'"
                      
                    } else {
                        error "Invalid environment: ${params.Environment}."
                    }

              }
            }
          }
        }
      }
    }
    post {
        success {
            emailext(
                to: "lawrence.wenboli@gmail.com",
                subject: "Front-end terraform pipeline successed.",
                body: "Front-end resources for ${params.Environment} environment have been successfully ${params.Operation}ed. Please check the plan file.",
                attachLog: false
                attachmentsPattern: 'app/techscrum_fe/${params.Environment}_${params.Operation}_plan'
            )
        }

        failure {
            emailext(
                to: "lawrence.wenboli@gmail.com",
                subject: "Front-end terraform pipeline failed.",
                body: "Front-end resources for ${params.Environment} environment have failed to be ${params.Operation}ed. Please check logfile for more details.",
                attachLog: true
            )
        }
    }
}
