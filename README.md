# Kubernetes Application Deployment Automation with Ansible

This project demonstrates a complete workflow for deploying a multi-component application (backend, frontend, PostgreSQL) on Kubernetes using [Ansible](https://www.ansible.com/) for configuration management. It also includes a Jenkins pipeline for CI/CD automation and a secure approach to secrets management.

---

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Configure Variables](#2-configure-variables)
  - [3. Run the Ansible Playbook](#3-run-the-ansible-playbook)
  - [4. Jenkins Pipeline (Optional)](#4-jenkins-pipeline-optional)
- [Secrets Management](#secrets-management)
- [Cleaning Up](#cleaning-up)
- [License](#license)
- [Contact](#contact)

---

## Overview

This repository provides a reproducible, automated solution for deploying a Kubernetes namespace and application stack. It leverages:

- **Ansible** to apply Kubernetes manifests for backend, frontend, PostgreSQL, services, and ingress.
- **Jenkins** for CI/CD pipeline automation.
- **Kubernetes Secrets** for sensitive data management.

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
└── Jenkinsfile
```

---

## Features

- **Declarative Application Deployment:** Ansible applies manifests for all application components.
- **CI/CD Ready:** Jenkins pipeline automates deployment and notifications.
- **Secure Secrets Handling:** Kubernetes secrets are managed separately.
- **Modular Roles:** Ansible roles for backend, frontend, and database for easy maintenance.

---

## Prerequisites

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Access to a Kubernetes cluster (e.g., [minikube](https://minikube.sigs.k8s.io/docs/))
- Properly configured `~/.kube/config`
- [Jenkins](https://www.jenkins.io/) (optional, for CI/CD)

---

## Getting Started

### 1. Clone the Repository

```sh
git clone <repository-url>
cd terraform-ansible
```

### 2. Configure Variables

Edit `ansible/group_vars/all.yaml` to set your desired variables.

### 3. Run the Ansible Playbook

```sh
cd ansible
ansible-playbook playbook.yaml -i inventory.ini
```

This will:
- Create the Kubernetes namespace (if not already present).
- Deploy backend, frontend, PostgreSQL, services, and ingress resources.

### 4. Jenkins Pipeline (Optional)

A Jenkins pipeline is provided in `Jenkinsfile` for CI/CD automation.  
Configure your Jenkins job to use this file for automated deployments and notifications.

---

## Secrets Management

Sensitive data (like database passwords) should be stored in `secrets/k8s-secret.yaml`.  
**Do not commit real secrets to version control.**  
Update this file as needed and reference it in your Kubernetes manifests.

---

## Cleaning Up

To remove deployed resources, you can delete the manifests using `kubectl`:

```sh
kubectl delete -f ansible/manifests/
kubectl delete -f secrets/k8s-secret.yaml
```

Or use Ansible with a teardown playbook if provided.

---

## License

MIT License. See [LICENSE](LICENSE) for details.

---

## Contact

**Author:** Madicke Cisse  
**Email:** cissemadicke8@gmail.com

---