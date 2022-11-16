pipeline {
    agent any

    stages {
        stage('Build docker image') {
            steps {
                echo 'building docker image...'
            }
        }
        stage('Push to registry') {
            steps {
                echo 'pushing to registry...'
            }
        }
        stage('Deploy docker container in EC2 Instance') {
            steps {
                echo 'deploying...'
            }
        }
        stage('Stress test') {
            steps {
                echo 'AAAAAAAAAAAAAAAAAAAAAAAAAAA'
            }
        }
    }
}