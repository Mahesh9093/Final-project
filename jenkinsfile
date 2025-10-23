pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('Docker-cred')
        DEV_REPO = "mahesh0504/devops-project-dev"
        PROD_REPO = "mahesh0504/devops-project-prod"
        IMAGE_NAME = "react-app"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Building branch: ${env.BRANCH_NAME}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"

                    if (env.BRANCH_NAME == "dev") {
                        sh """
                        docker tag ${IMAGE_NAME}:latest ${DEV_REPO}:latest
                        docker push ${DEV_REPO}:latest
                        """
                    } else if (env.BRANCH_NAME == "prod") {
                        sh """
                        docker tag ${IMAGE_NAME}:latest ${PROD_REPO}:latest
                        docker push ${PROD_REPO}:latest
                        """
                    } else {
                        echo "Branch ${env.BRANCH_NAME} not configured for Docker push"
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh "docker system prune -f || true"
            }
        }
    }

    post {
        success {
            echo "✅ Build completed for branch ${env.BRANCH_NAME}"
        }
        failure {
            echo "❌ Build failed for branch ${env.BRANCH_NAME}"
        }
    }
}
