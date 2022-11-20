pipeline {
    environment {
        registry = "bvediner/balancefy-backend"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }

    agent any

    stages {
        stage('Build docker image') {
            steps {
                echo 'building docker image...'
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy docker image') {
            steps {
                echo 'deploying docker image...'
                script {
                    docker.withRegistry( '', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy docker container in EC2 Instance') {
            steps {
                dir('/infra/backend/') {
//                     sh "BACKEND_IMAGE_VERSION=$registry:$BUILD_NUMBER docker-compose up -d"
                    echo "$PWD"
                }
            }
        }
    }
}
