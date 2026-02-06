# Multi-stage build for DeceasedCraft Minecraft Server
FROM amazoncorretto:17-alpine AS builder

WORKDIR /setup

# Install necessary tools
RUN apk add --no-cache \
    bash \
    curl \
    unzip

# Copy and extract server pack
COPY DeceasedCraft_Server_*.zip /setup/
RUN unzip DeceasedCraft_Server_*.zip && \
    rm DeceasedCraft_Server_*.zip

# Move to the extracted folder (nested structure)
WORKDIR /setup/DeceasedCraft_Server_v5.5.5

# Install Forge server
RUN java -jar forge-*-installer.jar --installServer && \
    rm -f forge-*-installer.jar

# Runtime stage
FROM amazoncorretto:17-alpine

# Install bash for server scripts
RUN apk add --no-cache bash

WORKDIR /minecraft

# Copy server files from builder
COPY --from=builder /setup/DeceasedCraft_Server_v5.5.5 /minecraft/

# Copy startup script
COPY start-server.sh /minecraft/

# Make startup script executable
RUN chmod +x /minecraft/start-server.sh

# Accept EULA by default
ENV EULA=true \
    MEMORY_MIN=2G \
    MEMORY_MAX=10G \
    JAVA_OPTS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200"

# Expose Minecraft port
EXPOSE 25565

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD pgrep -f "java.*minecraft" || exit 1

# Run the server
CMD ["/bin/bash", "/minecraft/start-server.sh"]
