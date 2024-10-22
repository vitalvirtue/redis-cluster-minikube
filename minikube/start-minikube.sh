#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'  # No Color

# Start Minikube with Docker driver
echo -e "${BLUE}Starting Minikube with Docker driver...${NC}"
minikube start --driver=docker

# Check if Minikube started successfully
if [ $? -ne 0 ]; then
  echo -e "${RED}Minikube failed to start. Exiting...${NC}"
  exit 1
fi

# Output success message for Minikube start
echo -e "${GREEN}Minikube started successfully!${NC}"

# Apply the Redis ConfigMap for configuration
echo -e "${BLUE}Applying Redis ConfigMap for configuration...${NC}"
kubectl apply -f ../redis/redis-cluster-configmap.yaml

# Check if the ConfigMap was applied successfully
if [ $? -ne 0 ]; then
  echo -e "${RED}Failed to apply Redis ConfigMap. Exiting...${NC}"
  exit 1
fi
echo -e "${GREEN}Redis ConfigMap applied successfully!${NC}"

# Apply the Persistent Volume Claim for Redis data persistence
echo -e "${BLUE}Applying Persistent Volume Claim for Redis data...${NC}"
kubectl apply -f ../redis/redis-cluster-pv.yaml
kubectl apply -f ../redis/redis-cluster-pvc.yaml

# Check if the PVC was applied successfully
if [ $? -ne 0 ]; then
  echo -e "${RED}Failed to apply Persistent Volume Claim. Exiting...${NC}"
  exit 1
fi
echo -e "${GREEN}Persistent Volume Claim applied successfully!${NC}"

# Apply the StatefulSet for Redis Cluster
echo -e "${BLUE}Deploying Redis Cluster using StatefulSet...${NC}"
kubectl apply -f ../redis/redis-cluster-statefulset.yaml

# Check if the StatefulSet was deployed successfully
if [ $? -ne 0 ]; then
  echo -e "${RED}Failed to deploy Redis Cluster. Exiting...${NC}"
  exit 1
fi
echo -e "${GREEN}Redis Cluster deployed successfully!${NC}"

# Apply the Redis service for internal communication
echo -e "${BLUE}Creating Redis service for internal communication...${NC}"
kubectl apply -f ../redis/redis-cluster-service.yaml

# Check if the service was applied successfully
if [ $? -ne 0 ]; then
  echo -e "${RED}Failed to create Redis service. Exiting...${NC}"
  exit 1
fi
echo -e "${GREEN}Redis service created successfully!${NC}"

# Wait for Redis pods to be ready
echo -e "${YELLOW}Waiting for Redis pods to become ready...${NC}"
kubectl rollout status statefulset/redis-cluster

# Check if the Redis pods are ready
if [ $? -eq 0 ]; then
  echo -e "${GREEN}All Redis pods are up and running!${NC}"
else
  echo -e "${RED}Redis Cluster setup failed.${NC}"
  exit 1
fi

# Optional: Start Minikube dashboard
echo -e "${YELLOW}Do you want to start the Minikube dashboard? (y/n)${NC}"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
  echo -e "${BLUE}Starting Minikube dashboard...${NC}"
  minikube dashboard &
  echo -e "${GREEN}Minikube dashboard started!${NC}"
else
  echo -e "${YELLOW}Dashboard start skipped.${NC}"
fi

# Final message
echo -e "${GREEN}Minikube setup and Redis Cluster deployment completed successfully!${NC}"
