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
        stage('Deploy docker image on dockerhub') {
            steps {
                echo 'deploying docker image...'
                script {
                    docker.withRegistry( '', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy docker container in EC2') {
            steps {
                sh "cd /infra/backend && BACKEND_IMAGE_VERSION=$registry:$BUILD_NUMBER docker compose up --build -d"
            }
        }
    }
}
