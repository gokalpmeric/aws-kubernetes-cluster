# AWS Kubernetes Cluster Setup

This repository contains a Terraform script that sets up a Kubernetes cluster on AWS using EKS, and deploys Cert-Manager and Envoy using Helm charts.

## Prerequisites

- Terraform v0.15.0 or later
- AWS account with necessary permissions to create EKS cluster and related resources
- kubectl and Helm installed on your local machine

## Setup

1. **Clone the repository**
   
    ```sh
    git clone https://github.com/gokalpmeric/aws-kubernetes-cluster.git
    cd aws-kubernetes-cluster
    ```

2. **Initialize Terraform**

    Run the following command to download the necessary Terraform providers.

    ```sh
    terraform init
    ```

3. **Create a plan**

    Modify the variables in the Terraform scripts as needed, then run the following command to create a Terraform plan.

    ```sh
    terraform plan -out=tfplan
    ```

4. **Apply the plan**

    Run the following command to create the resources in AWS.

    ```sh
    terraform apply "tfplan"
    ```

## Components

The Terraform script will set up the following components:

- **AWS EKS Cluster**: A managed Kubernetes service provided by AWS.
- **Cert-Manager**: A native Kubernetes certificate management controller which helps with issuing certificates.
- **Envoy**: An open-source edge and service proxy, designed for cloud-native applications.

## Cleaning Up

When you're done, you can destroy the resources that were created with the following command:

```sh
terraform destroy

