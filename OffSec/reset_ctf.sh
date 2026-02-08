#!/bin/bash

echo "[*] resetting ctf environment"

# Remove immutability before reset
chattr -i ~/-/flag.txt 2>/dev/null || true
chattr -i ~/.flag.txt 2>/dev/null || true
chattr -i /etc/s21_groups/flag.txt 2>/dev/null || true
chattr -i /root/flag_sudo.txt 2>/dev/null || true
chattr -i /root/flag_cron.txt 2>/dev/null || true
chattr -i /etc/service_flag.txt 2>/dev/null || true
chattr -i /var/log/ctf_secret.log 2>/dev/null || true
chattr -i /home/ctf/bin/ls 2>/dev/null || true
chattr -i /root/flag_symlink.txt 2>/dev/null || true
chattr -i ~/- 2>/dev/null || true
chattr -i /etc/s21_groups 2>/dev/null || true
chattr -i /home/ctf/bin 2>/dev/null || true
chattr -i /root 2>/dev/null || true

# kill user processes
pkill -u ctf || true

# restore environment
/bin/bash /setup.sh

echo "[*] reset complete"
