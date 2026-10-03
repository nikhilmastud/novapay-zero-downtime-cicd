pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        ECR_REPOSITORY = "novapay-app"
        ECS_CLUSTER = "novapay-cluster"
        ECS_SERVICE = "novapay-service"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage("Checkout") {
            steps { checkout scm }
        }
        stage("Build") {
            steps {
                dir("app/novapay-app") {
                    sh "./mvnw clean package -DskipTests"
                }
            }
        }
        stage("Docker Build") {
            steps {
                dir("app/novapay-app") {
                    sh "docker build -t ${ECR_REPOSITORY}:${IMAGE_TAG} ."
                }
            }
        }
        stage("Push to ECR") {
            steps {
                sh """
                    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
                    ECR_URI=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI
                    docker tag $ECR_REPOSITORY:$IMAGE_TAG $ECR_URI:$IMAGE_TAG
                    docker push $ECR_URI:$IMAGE_TAG
                """
            }
        }
        stage("Deploy") {
            steps {
                sh "aws ecs update-service --cluster ${ECS_CLUSTER} --service ${ECS_SERVICE} --force-new-deployment --region ${AWS_REGION}"
            }
        }
    }
}
