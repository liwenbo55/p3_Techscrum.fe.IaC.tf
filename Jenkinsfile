pipeline {
    agent any
    
    parameters {
        // Choose an environment to deploy frond-end resources: 'dev', 'uat', or 'prod'.
        choice(choices: ['dev', 'uat', 'prod'], name: 'Environment')
    }
    
    stages {
      stage('Check out code'){
        steps{
          git branch:'main', url:'https://github.com/liwenbo55/p3_Techscrum.tf.fe.git'                
        }
      }

      stage('IaC') {
        steps{
          script {
            withCredentials([
              [$class: 'AmazonWebServicesCredentialsBinding', 
               credentialsId: 'lawrence-jenkins-credential']
            ]){
              dir('app/techscrum_be'){
                  if (params.Environment in ['dev', 'uat', 'prod']) {
                    echo "Deploying front-end resources for ${params.Environment} environment."
                    sh 'terraform --version'
                    sh 'terraform init -reconfigure -backend-config=backend_${params.Environment}.conf -input=false'
                    sh 'terraform plan -var-file="${params.Environment}.tfvars" -out=${params.Environment}_plan -input=false'
                    sh 'terraform apply "${params.Environment}_plan"'
                    } else {
                        error "Invalid environment: ${params.Environment}."
                    }

              }
            }
          }
        }
      }
    }
}
