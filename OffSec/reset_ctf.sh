#!/bin/bash

echo "[*] resetting ctf environment"

# kill user processes
pkill -u ctf || true

# restore environment
/bin/bash /setup.sh

echo "[*] reset complete"
