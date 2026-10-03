# NovaPay Zero-Downtime CI/CD

A containerized Spring Boot application demonstrating an automated **CI/CD deployment workflow on AWS** using Jenkins, Docker, Amazon ECR, Amazon ECS Fargate, and an Application Load Balancer.

## Architecture

```text
Developer → GitHub → Jenkins → Maven → Docker → Amazon ECR
                                                |
                                                v
                                      ECS Fargate (2 Tasks)
                                                |
                                                v
                                      Application Load Balancer
                                                |
                                                v
                                        Spring Boot App
```

## Technology Stack

- **AWS:** ECR, ECS Fargate, ALB, IAM, CloudWatch
- **CI/CD:** Jenkins, Maven
- **Containers:** Docker
- **Application:** Java, Spring Boot
- **Infrastructure as Code:** Terraform
- **Version Control:** Git, GitHub

## CI/CD Flow

1. Developer pushes code to GitHub.
2. Jenkins checks out the application.
3. Maven builds the Spring Boot application.
4. Docker packages the application.
5. Jenkins authenticates with Amazon ECR and pushes the image.
6. ECS receives a new deployment.
7. Application Load Balancer routes traffic to healthy ECS tasks.
8. CloudWatch provides operational visibility.

## Project Structure

```text
app/
  novapay-app/
    src/
    Dockerfile
    pom.xml

infra/
  terraform/
    main.tf
    variables.tf
    outputs.tf

docs/
  deployment.md

Jenkinsfile
README.md
```

## Health Check

```text
GET /health
```

Example:

```json
{"status":"UP","service":"novapay-app"}
```

## Deployment Status

The repository contains the application, Jenkins pipeline, Docker configuration, and Terraform infrastructure foundation.

**AWS deployment is still in the learning/deployment phase and should not be considered production deployment until tested end-to-end.**

## Security Notes

- Never commit AWS access keys, passwords, private keys, or secrets.
- Use IAM roles and Jenkins/AWS credential management.
- Review Terraform resources and AWS costs before deployment.

## Learning Outcomes

- Containerizing Java applications
- Building CI/CD pipelines
- Publishing images to Amazon ECR
- Deploying workloads on ECS Fargate
- Using ALB health checks
- Managing AWS infrastructure with Terraform
