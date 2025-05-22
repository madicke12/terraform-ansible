
terraform {
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 4.16"
    # }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
  required_version = ">= 1.2.0"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
  }
}

resource "null_resource" "run_ansible" {
  depends_on = [kubernetes_namespace.app]
   triggers = {
    manifest_dir_hash = sha256(join("", [for f in fileset("../ansible/manifests", "*.yaml") : filesha256("../ansible/manifests/${f}")]))
  }


  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ../ansible/playbook.yaml -i ../ansible/inventory.ini"
  }
}
