
# Redis Cluster on Minikube with Kubernetes

This project automates the setup of a Redis Cluster on a local Minikube environment using Kubernetes manifests. The Redis Cluster is deployed using a StatefulSet, ConfigMap, Persistent Volumes (PV), and Persistent Volume Claims (PVC).

## Table of Contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Setup and Deployment](#setup-and-deployment)
- [Files and Directories](#files-and-directories)
- [Running the Project](#running-the-project)
- [Known Issues](#known-issues)
- [Optional Dashboard Setup](#optional-dashboard-setup)
- [Contact](#contact)

## Project Overview

This project sets up a 6-node Redis Cluster on Minikube with persistent data storage and headless service for internal communication between Redis nodes. It uses Kubernetes resources like ConfigMap for Redis configuration, StatefulSet for deploying Redis pods, and Persistent Volume Claims to retain data across pod restarts.

## Prerequisites

Before starting the deployment, ensure that the following tools are installed:

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) (with Docker driver)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- A working Docker installation (for Minikube)
- Basic knowledge of Kubernetes and Redis clustering

## Setup and Deployment

1. Clone this repository or download the files to your local machine.

   ```bash
   git clone https://github.com/vitalvirtue/redis-cluster-minikube.git
   cd redis-cluster-minikube
   ```

2. Start The Docker Desktop and ensure that it is running.

3. Make the startup script executable:

   ```bash
   chmod +x /minikube/start-minikube.sh
   ```

4. Run the script to start Minikube and deploy the Redis Cluster:

   ```bash
   ./minikube/start-minikube.sh
   ```

5. During deployment, you will be prompted to start the Minikube dashboard. You can choose `y` or `n` based on your preference.

## Files and Directories

- `/minikube/start-minikube.sh`: Bash script that automates the Minikube startup and Redis Cluster deployment.
- `/redis/redis-cluster-configmap.yaml`: Defines the Redis cluster configuration.
- `/redis/redis-cluster-pv.yaml`: Persistent Volume for Redis data.
- `/redis/redis-cluster-pvc.yaml`: Persistent Volume Claim to link Redis data to the PV.
- `/redis/redis-cluster-service.yaml`: Kubernetes Service for Redis internal communication.
- `/redis/redis-cluster-statefulset.yaml`: StatefulSet definition to deploy Redis Cluster with 6 nodes.

## Running the Project

1. **Start Minikube:**
   - The script will automatically start Minikube using the Docker driver. If Minikube fails to start, the script will terminate with an error message.

2. **Deploy Redis Cluster:**
   - The Redis configuration and StatefulSet will be applied, along with the necessary PV and PVC for persistent data storage.
   - The Redis pods will be deployed and the rollout status will be checked to ensure all pods are up and running.

3. **Access Redis Cluster:**
   - Once all Redis pods are ready, you can interact with the Redis Cluster using the internal Kubernetes service.

## Known Issues

- Ensure you have sufficient disk space and memory allocated for Minikube, especially when running a 6-node Redis Cluster.
- If the Minikube dashboard doesn't start automatically, you can manually start it using `minikube dashboard`.

## Optional Dashboard Setup

After the cluster is deployed, you can choose to start the Minikube dashboard for better visibility and management of Kubernetes resources. The script will ask for confirmation before starting the dashboard.

## Contact

For questions or feedback, feel free to reach out via the project repository or email: [ozkherdem@gmail.com](mailto:ozkherdem@gmail.com)
