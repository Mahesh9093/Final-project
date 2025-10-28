pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        IMAGE_NAME = "mahesh9093/final-project"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Mahesh9093/Final-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BRANCH_NAME .'
            }
        }

        stage('Push to DockerHub') {
            when {
                anyOf {
                    branch 'Dev'
                    branch 'prod'
                }
            }
            steps {
                script {
                    echo "Pushing image for branch ${env.BRANCH_NAME}"
                    sh '''
                        echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                        docker push $IMAGE_NAME:$BRANCH_NAME
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Successfully built and pushed $IMAGE_NAME:$BRANCH_NAME"
        }
        failure {
            echo "❌ Build failed for branch $BRANCH_NAME"
        }
    }
}
