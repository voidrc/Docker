#!/bin/bash

set -e

# Accept EULA if environment variable is set
if [ "$EULA" = "true" ]; then
    echo "eula=true" > eula.txt
fi

echo "Starting DeceasedCraft Minecraft server..."
echo "Memory: ${MEMORY_MIN} to ${MEMORY_MAX}"

# Update JVM arguments with memory settings
cat > user_jvm_args.txt << EOF
# Xms and Xmx set the minimum and maximum RAM usage, respectively.
-Xms${MEMORY_MIN}
-Xmx${MEMORY_MAX}
# Additional JVM optimization flags
${JAVA_OPTS}
EOF

echo "Starting server (nogui mode)..."

# Use the run.sh script created by Forge installer
exec /bin/bash ./run.sh nogui
