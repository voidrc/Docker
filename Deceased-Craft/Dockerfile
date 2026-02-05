# Multi-stage build for DeceasedCraft Minecraft Server
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /setup

# Install necessary tools
RUN apk add --no-cache \
    bash \
    curl \
    unzip

# The server files should be placed in the build context
# Copy server pack (user needs to download and place it)
COPY DeceasedCraft_Server_*.zip /setup/

# Extract server pack
RUN unzip DeceasedCraft_Server_*.zip -d /server && \
    rm DeceasedCraft_Server_*.zip

# Install Forge
WORKDIR /server
RUN if [ -f forge-*.jar ]; then \
        java -jar forge-*.jar --installServer; \
    fi

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

# Install bash for run.bat compatibility
RUN apk add --no-cache bash

WORKDIR /minecraft

# Copy server files from builder
COPY --from=builder /server /minecraft

# Copy startup script
COPY start-server.sh /minecraft/

# Make scripts executable
RUN chmod +x /minecraft/start-server.sh

# Accept EULA by default (can be overridden via environment variable)
ENV EULA=true \
    MEMORY_MIN=2G \
    MEMORY_MAX=4G \
    JAVA_OPTS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200"

# Expose Minecraft port
EXPOSE 25565

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD pgrep -f "java.*minecraft" || exit 1

# Run the server
CMD ["/bin/bash", "/minecraft/start-server.sh"]
