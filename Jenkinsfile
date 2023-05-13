pipeline {
    agent any
    stages {
        stage('TerraformVersion') {
            steps {
                sh 'terraform --version'
            }
        }
        stage('TerraformInit') {
            steps {
                dir('./env/build'){
                    sh 'pwd'
                    sh 'terraform init'
                }
            }
        }

        stage('TerraformPlan') {
            steps {
                dir('./env/build'){
                    sh 'terraform plan -out terraform.tfplan'
                    sh 'ls -la'
                }
            }
        }

         stage('TerraformApply') {
            steps {
                dir('./env/build'){
                    sh 'terraform apply terraform.tfplan'
                }
            }
        }
        stage('TerraformInit-Staging') {
            steps {
                dir('./env/staging'){
                    sh 'terraform init'
                }
            }
        }

         stage('TerraformPlan-Staging') {
            steps {
                dir('./env/staging'){
                    sh 'terraform plan'
                }
            }
        }
    }
}