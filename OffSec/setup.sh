#!/bin/bash

echo "== OffSec-21 Linux CTF ==" > /etc/motd
echo "9 flags and 20 decoys" >> /etc/motd
echo "read TASKs.txt before you hunt" >> /etc/motd

### CHAL 01 — navigation
mkdir -p ~/-
echo "S21{wwwf88adgy6cg6a5r}" > ~/-/flag.txt

### CHAL 02 — hidden files
echo "School{www07h898c8e87ch7qsycb8wy}" > ~/.flag.txt

### CHAL 03 — groups
groupadd secret
usermod -aG secret ctf
mkdir /etc/s21_groups
echo "21{987gb dwauf wds}" > /etc/s21_groups/flag.txt
chgrp secret /etc/s21_groups/flag.txt
chmod 440 /etc/s21_groups/flag.txt

### CHAL 04 — sudo (limited)
echo "ctf ALL=(root) NOPASSWD:/bin/cat" > /etc/sudoers.d/ctf
echo "Sch0ol{jadwubsuwdceucajbdue}" > /root/flag_sudo.txt
chmod 600 /root/flag_sudo.txt

### CHAL 05 — cron
echo "Sch00121{are you sure?}" > /root/flag_cron.txt
echo "* * * * * root cp /root/flag_cron.txt /tmp/flag_cron.txt" > /etc/cron.d/flag
chmod 644 /etc/cron.d/flag
service cron start

### CHAL 06 — services
echo "S{21}" > /etc/service_flag.txt
nohup sh -c "nc -lkp 9001 -e /bin/cat /etc/service_flag.txt" &

### CHAL 07 — logs
echo "weasel{https://www.youtube.com/watch?v=MkMJYmnGwHs&list=RDMkMJYmnGwHs&start_radio=1}" > /var/log/ctf_secret.log
chmod 644 /var/log/ctf_secret.log

### CHAL 08 — PATH hijack
mkdir /home/ctf/bin
echo 'echo TG{https://t.me/OffSec_21}' > /home/ctf/bin/ls
chmod +x /home/ctf/bin/ls
echo 'export PATH=/home/ctf/bin:$PATH' >> /home/ctf/.bashrc

### CHAL 9 — symlink
echo "FLaG{.-.-.}" > /root/flag_symlink.txt
ln -s /root/flag_symlink.txt /home/ctf/flag_symlink.txt
chmod 777 /home/ctf/flag_symlink.txt

chown -R ctf:ctf /etc/s21_groups /home/ctf

# reset cron
echo "*/15 * * * * root /usr/local/bin/reset_ctf.sh" > /etc/cron.d/ctf_reset
chmod 644 /etc/cron.d/ctf_reset


################## DECOY

### DECOY FLAGS (DO NOT SCORE)

echo "FLAG{welcome_to_ctf}" > /home/ctf/FLAG_README.txt
echo "FLAG{first_flag_found}" > /home/ctf/.flag
echo "FLAG{easy_mode_enabled}" > /challenges/flag.txt
echo "FLAG{root_access_granted}" > /tmp/flag.txt
echo "FLAG{you_are_done}" > /var/tmp/flag
echo "FLAG{nothing_to_see_here}" > /etc/flag.conf
echo "FLAG{good_job}" > /home/ctf/Documents/flag.txt
echo "FLAG{training_complete}" > /opt/flag.txt
echo "FLAG{keep_going}" > /srv/flag
echo "FLAG{almost_there}" > /home/ctf/flag_old.txt

echo "FLAG{this_is_fake}" > /home/ctf/.cache/flag
echo "FLAG{try_harder}" > /usr/local/share/flag.txt
echo "FLAG{decoy_detected}" > /home/ctf/.local/flag
echo "FLAG{not_the_flag}" > /var/log/flag.log
echo "FLAG{example_flag}" > /home/ctf/Desktop/flag.txt
echo "FLAG{debug_flag}" > /tmp/.hidden_flag
echo "FLAG{test_submission}" > /home/ctf/Downloads/flag.txt
echo "FLAG{dummy_flag}" > /run/flag
echo "FLAG{sample_only}" > /home/ctf/flag.bak
echo "FLAG{looks_real_right}" > /home/ctf/README_FLAG.txt

chown -R ctf:ctf /home/ctf /tmp /var/tmp /home/ctf/.cache /home/ctf/.local 2>/dev/null
