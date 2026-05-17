pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'

        FRONTEND_REPO = '563332534740.dkr.ecr.us-east-1.amazonaws.com/techchallenge1-redo-frontend'
        BACKEND_REPO  = '563332534740.dkr.ecr.us-east-1.amazonaws.com/techchallenge1-redo-backend'

        ECS_CLUSTER = 'techchallenge1-redo-ecs-cluster'

        FRONTEND_SERVICE = 'techchallenge1-redo-frontend-service'
        BACKEND_SERVICE  = 'techchallenge1-redo-backend-service'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/phillipoy/TechChallenge1Redo.git'
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin 563332534740.dkr.ecr.us-east-1.amazonaws.com
                    '''
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                sh '''
                docker buildx build \
                --platform linux/amd64 \
                --provenance=false \
                -t $BACKEND_REPO:latest \
                ./backend \
                --load
                '''
            }
        }

        stage('Push Backend Image') {
            steps {
                sh 'docker push $BACKEND_REPO:latest'
            }
        }

        stage('Build Frontend Image') {
            steps {
                sh '''
                docker buildx build \
                --platform linux/amd64 \
                --provenance=false \
                -t $FRONTEND_REPO:latest \
                ./frontend \
                --load
                '''
            }
        }

        stage('Push Frontend Image') {
            steps {
                sh 'docker push $FRONTEND_REPO:latest'
            }
        }

        stage('Deploy to ECS') {
            steps {
                sh '''
                aws ecs update-service \
                  --cluster $ECS_CLUSTER \
                  --service $BACKEND_SERVICE \
                  --force-new-deployment

                aws ecs update-service \
                  --cluster $ECS_CLUSTER \
                  --service $FRONTEND_SERVICE \
                  --force-new-deployment
                '''
            }
        }
    }
}