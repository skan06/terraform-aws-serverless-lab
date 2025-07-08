# ☁️ Terraform AWS Serverless Lab

## 📌 Overview

This project provisions a **serverless and container-based AWS infrastructure** using Terraform. It includes:

- A Python-based **AWS Lambda function** that logs messages to **CloudWatch Logs**
- Scheduled invocation with **EventBridge**
- Message storage in an **S3 bucket**
- An **API Gateway** endpoint to trigger the Lambda function manually
- A basic **ECS Fargate cluster** running a demo container

All deployed within a custom **VPC** using **Terraform**, and designed to stay within the **Free Tier** 💸.

---

## 🧱 Architecture Diagram

User/API Gateway → Lambda → CloudWatch Logs
↓
S3 Bucket

ECS Fargate → Logs to CloudWatch

VPC (Public Subnets, IGW, Route Tables)


---

## 📂 Project Structure

| File                  | Description |
|-----------------------|-------------|
| `main.tf`             | AWS provider and global outputs |
| `network.tf`          | VPC, subnets, route tables |
| `security_groups.tf`  | Security group for ECS |
| `iam.tf`              | IAM roles and policies (Lambda, ECS) |
| `ecs.tf`              | ECS cluster, Fargate task and service |
| `lambda.tf`           | Lambda function and environment config |
| `lambda_function.py`  | Python code that logs to CloudWatch and uploads to S3 |
| `eventbridge.tf`      | Scheduled EventBridge trigger for Lambda |
| `apigateway.tf`       | HTTP API Gateway connected to Lambda |
| `s3.tf`               | S3 bucket for Lambda output |
| `README.md`           | Project documentation |
| `.gitignore`          | Git exclusions (state files, keys, zips, etc) |

---

## 🚀 Features

- ✅ **100% Terraform-managed infrastructure**
- ✅ **Event-driven Lambda** (every 5 minutes with EventBridge)
- ✅ **API-triggered Lambda** (via HTTP GET `/log`)
- ✅ **S3 integration** (Lambda saves log file)
- ✅ **CloudWatch Logs** for Lambda and ECS container
- ✅ **ECS Fargate** demo task (logs message in a loop)

---

## 📦 Requirements

- Terraform >= 1.4
- AWS CLI configured with credentials
- Python (to package `lambda_function.py`)
- An AWS Free Tier account

---
🔍 Test the Lab
🧪 1. Check ECS Logs
Go to CloudWatch → Log Groups → /ecs/demo-app
You should see messages like:

Hello from ECS Fargate!

🧪 2. Check Lambda Logs
Go to CloudWatch → Log Groups → /aws/lambda/demo-lambda
You should see:


INFO Hello from Lambda, stored in S3!

🧪 3. Trigger Lambda via API Gateway
Use cURL or a browser:

curl https://your-api-id.execute-api.us-east-1.amazonaws.com/log

Example response:

{
  "statusCode": 200,
  "body": "Logged message and saved to S3: log-2025-07-08T16:20:35.861184.txt"
}

Check the file in your S3 bucket created by Terraform.

## 📌 Notes

🔹 The **S3 bucket name** is auto-generated with a unique suffix to avoid naming conflicts.

🔹 The **Lambda function** is triggered:
   - 🔁 Automatically every 5 minutes via **EventBridge**
   - 🌐 Manually via **API Gateway**

🔹 This lab is ideal for beginners to learn:

   ✅ 🖥️ **Serverless architecture** (Lambda, EventBridge, API Gateway, S3)

   ✅ 📦 **Terraform modules** and infrastructure as code (IaC)

   ✅ ☁️ **AWS Cloud automation** using real services within the Free Tier




🧠 Author
Skander Houidi


