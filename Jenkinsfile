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
    }
}