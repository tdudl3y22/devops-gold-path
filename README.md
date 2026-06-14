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
