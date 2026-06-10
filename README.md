# DevOps Gold Path: Automated DevSecOps Pipeline

A high-performance, automated CI/CD pipeline demonstrating modern Infrastructure-as-Code (IaC), Containerization, and "Shift-Left" Security principles.

🚀 Features
Infrastructure as Code: Managed via Terraform for consistent, reproducible environments.
Containerization: Node.js application hardened with slim base images.
DevSecOps: Integrated Trivy scanning to block CRITICAL vulnerabilities before deployment.
Automated Deployment: Continuous Deployment (CD) to Render via secure webhooks.
Private Registry: Hosted on GitHub Container Registry (GHCR) using ephemeral GITHUB_TOKENs.
🛠 Tech Stack
Language: Node.js (Express)
Infrastructure: Terraform
CI/CD: GitHub Actions
Security: Trivy
Container: Docker
Hosting: Render
🛡 Security Policy
This project implements a "Zero Critical" policy. Every build is scanned for vulnerabilities; images containing unpatched CRITICAL flaws are automatically blocked from entering the production registry.

## 🏗 System Architecture

```mermaid
graph TD
    A[Local Code / main.tf] -->|Git Push| B(GitHub Actions)
    
    subgraph "CI/CD Pipeline"
    B --> C{Terraform Check}
    C -->|Success| D[Docker Build]
    D --> E{Trivy Security Scan}
    E -->|Green Light| F[Login to GHCR]
    F --> G[Push Image to GHCR]
    end
    
    subgraph "Production"
    G --> H[Render Deploy Hook]
    H --> I[Running Web Service]
    end
    
    style E fill:#f96,stroke:#333,stroke-width:2px
    style G fill:#bbf,stroke:#333,stroke-width:2px
    style I fill:#9f9,stroke:#333,stroke-width:2px


