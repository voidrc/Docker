#!/bin/bash

set -e

# Accept EULA if environment variable is set
if [ "$EULA" = "true" ]; then
    echo "eula=true" > eula.txt
fi

# Find the forge server jar
FORGE_JAR=$(find . -maxdepth 1 -name "forge-*-shim.jar" -o -name "forge-*.jar" | grep -v installer | head -n 1)

if [ -z "$FORGE_JAR" ]; then
    echo "ERROR: Could not find Forge server jar!"
    echo "Available jars:"
    ls -la *.jar 2>/dev/null || echo "No jar files found"
    exit 1
fi

echo "Starting Minecraft server with $FORGE_JAR"
echo "Memory: ${MEMORY_MIN} to ${MEMORY_MAX}"
echo "Java Options: ${JAVA_OPTS}"

# Start the server (nogui mode)
exec java -Xms${MEMORY_MIN} -Xmx${MEMORY_MAX} ${JAVA_OPTS} -jar "$FORGE_JAR" nogui
