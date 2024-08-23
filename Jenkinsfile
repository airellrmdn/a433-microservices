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
        stage('Grype Scan') {
            steps {
                grypeScan scanDest: "docker:${DOCKER_REGISTRY}:${IMAGE_TAG}", repName: "myScanResult-${JOB_BASE_NAME}1.txt", autoInstall:true
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
            script {
                // Clean up the Docker image from the local workspace
                sh "docker rmi ${DOCKER_REGISTRY}:${IMAGE_TAG} -f || true"
            }
            discoverReferenceBuild()
            recordIssues(
                tools: [grype()],
                aggregatingResults: false,
                trendChartType: 'NONE',
                //failedNewAll: 1, //fail if >=1 new issues
                //failedTotalHigh: 20, //fail if >=20 HIGHs
                //failedTotalAll : 100, //fail if >=100 issues in total
                //failOnError: true
            )
        }
    }
}
