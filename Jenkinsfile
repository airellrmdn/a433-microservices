pipeline {
    agent any
    environment {
        // Environment variables for Docker credentials and registry details
        DOCKER_REGISTRY = 'airellrmdn/imagescan-test'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        IMAGE_TAG = "latest"
    }

    stages {
        stage('SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_REGISTRY}:${IMAGE_TAG}")
                }
            }
        }
        stage('Docker Login') {
            steps {
            script {
                    // Log in to the Docker registry
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                    echo "Logged in to Docker registry"
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                // Push the Docker image to the registry
                docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        def image = docker.image("${DOCKER_REGISTRY}:${IMAGE_TAG}")
                        image.push()
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
