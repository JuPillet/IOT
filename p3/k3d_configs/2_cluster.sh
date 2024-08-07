#!/bin/bash
echo "création du cluster"
sudo k3d cluster create jpillet --api-port 6550 -p "8081:80@loadbalancer"
sudo kubctl port-forward 
sleep 10
echo "cluster créé"

echo "création des namespaces"
sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sleep 10
echo "namespaces créé"

echo "installation d'argocd"
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 10
sudo kubectl wait --for=condition=Ready pods --all -n argocd
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo "argocd installé"


