#!/bin/bash

IMAGE_NAME="offsec21-linux-ctf"
CONTAINER_NAME="offsec21"
HOST_PORT=2222
CONTAINER_PORT=22

echo "[*] building image..."
docker build -t $IMAGE_NAME .

echo "[*] stopping old container (if any)..."
docker rm -f $CONTAINER_NAME 2>/dev/null

echo "[*] starting new container..."
docker run -d \
    --name $CONTAINER_NAME \
    -p ${HOST_PORT}:${CONTAINER_PORT} \
    $IMAGE_NAME

echo ""
echo "[+] lab is up"
echo "[+] connect with:"
echo "    ssh ctf@localhost -p ${HOST_PORT}"
echo "    password: ctf"
echo ""
echo "[+] to reset:"
echo "    docker restart ${CONTAINER_NAME}"
