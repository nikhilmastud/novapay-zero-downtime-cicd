# NovaPay Zero-Downtime CI/CD Deployment

## Target Architecture

```text
Developer -> GitHub -> Jenkins -> Maven -> Docker -> Amazon ECR -> ECS Fargate -> ALB -> Spring Boot App
```

## Deployment strategy

The ECS service is configured with two tasks and an Application Load Balancer health check on `/health`. ECS rolling deployment settings allow new tasks to become healthy while existing tasks remain available during deployment.

## Deployment steps

1. Provision AWS infrastructure with Terraform.
2. Build the Spring Boot JAR with Maven.
3. Build the Docker image.
4. Authenticate Docker with Amazon ECR.
5. Push the image to ECR.
6. Trigger a new ECS service deployment.
7. Verify `/health` through the Application Load Balancer.
8. Review ECS task and ALB target health.

The repository contains deployment configuration; live AWS deployment and measured results will be added only after actual verification.
