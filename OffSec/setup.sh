#!/bin/bash

echo "== OffSec-21 Linux CTF ==" > /etc/motd
echo "9 real flags hidden in the system" >> /etc/motd
echo "Read TASKs.txt before you start" >> /etc/motd
echo "" >> /etc/motd

### CHAL 01 — navigation
mkdir -p ~/-
echo "school-21{n4v1g4t3_d33p3r_7h4n_y0u_th1nk}" > ~/-/flag.txt

### CHAL 02 — hidden files
echo "5CH00L-21{h1dd3n_1n_pl41n_s1gh7}" > ~/.flag.txt

### CHAL 03 — groups
groupadd secret
usermod -aG secret ctf
mkdir /etc/s21_groups
echo "ScHoOl-21{gr0up_pr1v1l3g3s_unl0ck3d}" > /etc/s21_groups/flag.txt
chgrp secret /etc/s21_groups/flag.txt
chmod 440 /etc/s21_groups/flag.txt

### CHAL 04 — sudo (limited)
echo "ctf ALL=(root) NOPASSWD:/bin/cat" > /etc/sudoers.d/ctf
echo "school-21{sud0_p0w3r_w1th0ut_r00t}" > /root/flag_sudo.txt
chmod 600 /root/flag_sudo.txt

### CHAL 05 — cron
echo "SCHOOL-21{t1m3_b4s3d_4ut0m4t10n}" > /root/flag_cron.txt
echo "* * * * * root cp /root/flag_cron.txt /tmp/flag_cron.txt" > /etc/cron.d/flag
chmod 644 /etc/cron.d/flag
service cron start

### CHAL 06 — services
echo "c2Nob29sLTIxe2wwYzRsaDBzdF9zM3J2MWMzc19jMHVudH0K" > /etc/service_flag.txt
nohup sh -c "nc -lkp 9001 -e /bin/cat /etc/service_flag.txt" &

### CHAL 07 — logs
echo "fpubby-21{y0tf_g3yy_gu3_gehgu}" > /var/log/ctf_secret.log
chmod 644 /var/log/ctf_secret.log

### CHAL 08 — PATH hijack
mkdir /home/ctf/bin
echo 'echo "school-21{p4th_h1j4ck_succ3ss}"' > /home/ctf/bin/ls
chmod +x /home/ctf/bin/ls
echo 'export PATH=/home/ctf/bin:$PATH' >> /home/ctf/.zshrc

### CHAL 09 — symlink
echo "7363686f6f6c2d32317b73796d6230316331635f6c316e6b735f6630316c30773364" > /root/flag_symlink.txt
ln -s /root/flag_symlink.txt /home/ctf/flag_symlink.txt
chmod 777 /home/ctf/flag_symlink.txt

chown -R ctf:ctf /etc/s21_groups /home/ctf

# === PROTECT CHALLENGE DIRECTORIES & FILES ===
# Make flag files immutable (can't be deleted/modified even by root)
chattr +i ~/-/flag.txt
chattr +i ~/.flag.txt
chattr +i /etc/s21_groups/flag.txt
chattr +i /root/flag_sudo.txt
chattr +i /root/flag_cron.txt
chattr +i /etc/service_flag.txt
chattr +i /var/log/ctf_secret.log
chattr +i /home/ctf/bin/ls
chattr +i /root/flag_symlink.txt

# Make directories immutable too
chattr +i ~/-
chattr +i /etc/s21_groups
chattr +i /home/ctf/bin
chattr +i /root

# reset cron
echo "*/15 * * * * root /usr/local/bin/reset_ctf.sh" > /etc/cron.d/ctf_reset
chmod 644 /etc/cron.d/ctf_reset
