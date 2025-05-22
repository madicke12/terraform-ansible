# Kubernetes Deployment Automation with Terraform & Ansible

This project provides a complete automation pipeline for deploying a Kubernetes-based application stack using [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/). It provisions a Kubernetes namespace, applies application manifests (backend, frontend, PostgreSQL, services, ingress), and manages secrets, all orchestrated via infrastructure-as-code and configuration management best practices.

---

## Table of Contents

- [Project Structure](#project-structure)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Setup & Usage](#setup--usage)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Configure Variables](#2-configure-variables)
  - [3. Initialize and Apply Terraform](#3-initialize-and-apply-terraform)
  - [4. Ansible Playbook](#4-ansible-playbook)
  - [5. Jenkins Pipeline (Optional)](#5-jenkins-pipeline-optional)
- [Secrets Management](#secrets-management)
- [Cleaning Up](#cleaning-up)
- [Project Details](#project-details)
- [License](#license)
- [Contact](#contact)

---

## Project Structure

```
.
├── .gitignore
├── ansible/
│   ├── inventory.ini
│   ├── playbook.yaml
│   ├── group_vars/
│   │   └── all.yaml
│   ├── manifests/
│   │   ├── backend.yaml
│   │   ├── frontend.yaml
│   │   ├── ingress.yaml
│   │   ├── postgres.yaml
│   │   └── services.yaml
│   └── roles/
│       ├── backend/
│       │   └── tasks/main.yaml
│       ├── frontend/
│       │   └── tasks/main.yaml
│       └── postgres/
│           └── tasks/main.yaml
├── secrets/
│   └── k8s-secret.yaml
└── terraform/
    ├── Jenkinsfile
    ├── main.tf
    ├── variables.tf
    ├── .terraform.lock.hcl
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── .terraform/
```

---

## Features

- **Infrastructure as Code:** Uses Terraform to provision Kubernetes namespaces and trigger configuration management.
- **Configuration Management:** Uses Ansible to apply Kubernetes manifests and configure application components.
- **CI/CD Integration:** Includes a Jenkins pipeline for automated deployment and notifications.
- **Secrets Management:** Supports Kubernetes secrets for sensitive data.
- **Modular Design:** Separate roles for backend, frontend, and database.

---

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.2.0
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Access to a Kubernetes cluster (e.g., [minikube](https://minikube.sigs.k8s.io/docs/))
- Properly configured `~/.kube/config` with the correct context (default: `minikube`)
- [Jenkins](https://www.jenkins.io/) (optional, for CI/CD)

---

## Setup & Usage

### 1. Clone the Repository

```sh
git clone <repository-url>
cd terraform-ansible
```

### 2. Configure Variables

Edit [`terraform/variables.tf`](terraform/variables.tf) to set your desired namespace and other variables.

### 3. Initialize and Apply Terraform

```sh
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

- **What happens:**  
  - Provisions the Kubernetes namespace.
  - Triggers the Ansible playbook to apply manifests and configure components.

### 4. Ansible Playbook

The playbook [`ansible/playbook.yaml`](ansible/playbook.yaml) is executed automatically by Terraform using a `local-exec` provisioner (see [`main.tf`](terraform/main.tf)).  
You can also run it manually:

```sh
cd ansible
ansible-playbook playbook.yaml -i inventory.ini
```

### 5. Jenkins Pipeline (Optional)

A Jenkins pipeline is provided in [`terraform/Jenkinsfile`](terraform/Jenkinsfile):

- **Stages:**  
  - `Terraform Init`
  - `Terraform Plan`
  - `Terraform Apply`
- **Notifications:**  
  - Sends email on build success or failure.

To use, configure your Jenkins job to use this Jenkinsfile.

---

## Secrets Management

Sensitive data (e.g., database passwords) should be stored in [`secrets/k8s-secret.yaml`](secrets/k8s-secret.yaml).  
**Do not commit real secrets to version control.**  
Update this file as needed and ensure it is referenced in your manifests.

---

## Cleaning Up

To destroy all resources created by Terraform:

```sh
cd terraform
terraform destroy
```

---

## Project Details

- **Terraform:**  
  - Provisions Kubernetes namespace ([`main.tf`](terraform/main.tf))
  - Triggers Ansible playbook after namespace creation

- **Ansible:**  
  - Applies manifests for backend, frontend, PostgreSQL, services, and ingress ([`ansible/manifests/`](ansible/manifests/))
  - Uses roles for modular configuration ([`ansible/roles/`](ansible/roles/))

- **Jenkins:**  
  - Automates deployment pipeline ([`Jenkinsfile`](terraform/Jenkinsfile))

---

## License

MIT License. See LICENSE for details.

---

## Contact

**Author:** Madicke Cisse  
**Email:** cissemadicke8@gmail.com

---