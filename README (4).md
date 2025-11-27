
# CS 554 - Cloud Computing Project-2 
# Part 1: Docker + Terraform
# Part 2: Kubernetes + Terraform  
# Full Detailed Documentation - Steps, Explanations, Modules, Enhancements

===========
Clone Repo
===========

https://github.com/nagasandeepg/Terraform.git

# ============================================
# PART 1 - DOCKER + TERRAFORM PROJECT
# ============================================

# Objective

Use Terraform to provision a complete microservices stack locally using Docker:
- **Frontend** (Nginx)
- **Backend** (Python/Flask or Node)
- **Database** (PostgreSQL)
- All running inside containers
- All connected through **custom Docker network**
- Provisioned entirely via **Terraform providers & modules**

# Requirements Checklist (Part 1)

| Requirement| Explanation |
|------------|--------|-------------|
| 3 Services (Frontend, Backend, DB) | All deployed via modules |
| Docker Provider usage | `kreuzwerker/docker` used |
| `docker_image` resources | For backend & frontend |
| `docker_container` resources | All services |
| Custom Docker network | Configured via Terraform |
| Secrets via variable + tfvars | DB password stored securely |
| Frontend exposed on localhost:8080 | Verified working |
| Enhancement | Custom images + Terraform modularization |

All services run inside a **single Docker network**, enabling container-to-container communication.


# **Terraform Project Structure (Part 1)**

docker-terraform/
│── main.tf
│── variables.tf
│── terraform.tfvars
│── modules/
│     ├── frontend/
│     ├── backend/
│     └── database/


#  **Explanation of Terraform Files**

## **main.tf**
- Declares Docker provider  
- References 3 modules  
- Outputs frontend URL

## **variables.tf**
Defines all required inputs:
- Network name  
- Images  
- Secrets (DB password)

## **modules/**  
Each module contains:
- `docker_image`
- `docker_container`
- network attachments
- environment variables
- port mapping


# **Steps to Deploy Part 1**

### ** Move to project folder**

cd docker-terraform


### ** Initialize Terraform**

terraform init


### ** Apply configuration**

terraform apply -auto-approve


### ** Verify Containers**

docker ps

Should see:
- `tf-frontend`
- `tf-backend`
- `tf-postgres`

### ** Test Application**

- Frontend → http://localhost:8080  
- Backend → http://localhost:5000  



# **Enhancement (Part 1)**  
# Custom Docker images for backend & frontend  
# Modular Terraform design (3 fully independent modules)

This increases:
- Maintainability  
- Scalability  
- Version control of images  
- CI/CD readiness  


# ============================================
# PART 2 — KUBERNETES + TERRAFORM PROJECT
# ============================================

## **Objective**
Deploy an application to Kubernetes using Terraform:
- Local Kubernetes cluster (Docker Desktop Kubernetes)
- Namespace
- Deployment
- Service (NodePort)
- Ingress (Enhancement)


# Requirements Checklist (Part 2)

| Requirement | Explanation |
|------------|--------|-------------|
| Install k3d/kind OR Docker Desktop K8s | Using Docker Desktop Kubernetes |
| Configure kubectl | Context set to docker-desktop |
| Kubernetes provider in Terraform | `hashicorp/kubernetes` |
| Namespace | `demo-namespace` created |
| Deployment | Nginx deployment |
| Service | NodePort service (30001) |
| Enhancement | Ingress resource created |


# Terraform Files (Part 2)

### **provider.tf**
Configures Kubernetes provider:

config_context = "docker-desktop"


### **namespace.tf**
Creates namespace:

demo-namespace


### **deployment.tf**
Creates nginx deployment.

### **service.tf**
Creates NodePort service:

node_port = 30001


### **ingress.tf**
Defines ingress routing **(enhancement)**.


# Deploying Part 2

### ** Verify Kubernetes is enabled**

kubectl get nodes


### ** Navigate to project folder**

cd k8s-terraform


### ** Initialize Terraform**

terraform init -reconfigure


### ** Apply configuration**

terraform apply -auto-approve


### **Validate**

kubectl get pods -n demo-namespace
kubectl get svc -n demo-namespace
kubectl get ingress -n demo-namespace


### ** Test Application**

http://localhost:30001


# Enhancement (Part 2)
### Ingress Routing  
Terraform created an Ingress that:
- Provides HTTP routing  
- Simulates cloud load balancer  
- Works like production-grade ingress controllers  


# **Conclusion**
This project demonstrates:
- Infrastructure as Code (IaC)
- Container orchestration using Docker
- Kubernetes resource orchestration using Terraform
- Fully automated microservices deployment
- Troubleshooting, debugging, and deep understanding of cloud-native tools



