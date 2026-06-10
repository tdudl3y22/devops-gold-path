# DevOps Gold Path: Automated DevSecOps Pipeline

A high-performance, automated CI/CD pipeline demonstrating modern Infrastructure-as-Code (IaC), Containerization, and "Shift-Left" Security principles.

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
