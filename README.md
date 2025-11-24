**Producation ready react app to dockerHub**

Deployed React application to a production-ready state using Docker, Jenkins, and AWS.

This project involves deploying a React-based web application in a production environment using a CI/CD pipeline.
The goal was to automate the entire build and deployment process using Docker, Jenkins, and AWS EC2.

Technologies Used

AWS EC2 (Ubuntu 22.04) — Hosting Jenkins and deployment environment

Jenkins — For CI/CD automation

Docker & Docker Hub — For containerization and image management

Git & GitHub — For version control and Jenkins integration

Bash Scripting — For image build and deployment automation
Producation ready react app to dockerHub
🏗️ Project Architecture

Final-project/
│
├── Dockerfile
├── Jenkinsfile
├── build.sh
├── deploy.sh
├── package.json
├── k8s/
│   └── deployment.yml
└── build/

Dockerfile — Defines instructions to build Docker image for React app.

build.sh — Builds and tags Docker images for dev and prod.

deploy.sh — Pushes the images to respective Docker Hub repositories.

Jenkinsfile — Defines the CI/CD pipeline.

k8s/ — Contains Kubernetes deployment YAML.

⚙️ Docker Setup

Dockerfile Highlights:

FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

Build and Run

bash build.sh
bash deploy.sh

🔁 Jenkins CI/CD Setup

Jenkins Multibranch Pipeline

Configured to automatically trigger builds on Dev and Prod branches:

When code is pushed to Dev → Build Docker image → Push to Dev repo (public)

When merged to Prod → Build Docker image → Push to Prod repo (private)

🧩 Docker Hub

Two repositories created:

Public Repo: mahesh0504/devops-project-dev

Private Repo: mahesh0504/devops-project-prod

Images are pushed automatically through Jenkins after every commit.

📈 Monitoring

Prometheus + Node Exporter used to monitor CPU, Muptime.

Configured health checks on port 80 and notifications on downtime.

final deployed webpage

below is ip

http://65.0.56.18/

AWS sg snapshots

