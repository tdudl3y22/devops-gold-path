# DevOps Gold Path: Production-Grade Node.js 🚀

A high-availability, security-hardened Node.js application pipeline. This project demonstrates industry-standard DevOps practices, moving from a simple container to a self-healing, multi-stage production environment.

## 🏗 Architecture Overview

This project utilizes a **Multi-Stage Docker Build** to minimize attack surface and optimize deployment speed.

🛡 Security & Hardening
Trivy Vulnerability Scanning: Integrated into the CI/CD pipeline to block any image with CRITICAL vulnerabilities.
OS Patching: The Dockerfile manually upgrades libgnutls30 and other critical libraries during the build.
Multi-Stage Builds: Removes npm cache and build tools from the final production image.
🩺 Self-Healing & Reliability
The container includes a native Healthcheck that monitors the application's responsiveness every 30 seconds.

Liveness Probe: curl -f http://localhost:3000/
Auto-Recovery: Integrated with cloud platforms (like Render) to automatically reboot the container if the app becomes unresponsive.
⚡ Technical Specifications
Base Image: node:lts-slim (Debian-based)
Memory Limit: --max-old-space-size=2048 (Hardened against Exit 254 errors)
Port: 3000 (Exposed & Mapped)
🛠 Local Development
To run this project locally with full health monitoring:
# Build the production image
docker build -t devops-gold-path:pro .

# Run with port mapping
docker run -d -p 3000:3000 --name web-app devops-gold-path:pro

# Monitor health status
docker ps

## 🤖 CI/CD Pipeline (GitHub Actions)
The project utilizes a fully automated **Continuous Integration and Deployment** pipeline. Every push to the `main` branch triggers a multi-stage validation process:

1. **Lint & Build:** Validates the Dockerfile and builds the "Builder" stage.
2. **Security Gate (Trivy):** Scans the image for vulnerabilities. The pipeline is configured to **fail the build** if `CRITICAL` issues are detected.
3. **Registry Push:** Upon a successful scan, the image is tagged and pushed to the **GitHub Container Registry (GHCR)**.
4. **Automated Deploy:** Sends a webhook to the production environment to trigger a rolling update.

## 🌍 Infrastructure as Code (Terraform)
To ensure the environment is reproducible and "vendor-neutral," the infrastructure is defined using **Terraform**.

- **Provider:** Managed via standard cloud providers (Render/AWS/OCI).
- **State Management:** Terraform tracks the current state of the infrastructure, allowing for incremental updates without manual intervention.
- **Declarative Design:** Instead of clicking buttons in a dashboard, we define the desired state (e.g., "I need a Node.js service with 2GB RAM") and Terraform handles the provisioning.

### Key DevOps Philosophies Applied:
- **Immutable Infrastructure:** We never "patch" a running server; we use Terraform and Docker to replace it with a fresh, perfect version.
- **Shifting Left:** Security scanning (Trivy) happens at the earliest possible stage in the CI/CD pipeline.
- **GitOps:** The Git repository is the "Single Source of Truth" for both the application code and the server configuration.


```mermaid
graph TD
    subgraph Build_Stage [Stage 1: The Builder]
        A[node:lts-slim] --> B[Security Patching: apt upgrade]
        B --> C[npm install: production only]
    end

    subgraph Run_Stage [Stage 2: The Runner]
        D[node:lts-slim] --> E[Install curl for Healthchecks]
        E --> F[COPY --from=builder /app]
        F --> G[Liveness Probe: HEALTHCHECK]
    end

    C -- "Copy cleaned app only" --> F
