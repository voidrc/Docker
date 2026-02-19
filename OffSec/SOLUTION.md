# OffSec-21 CTF Solutions

## Challenge 01: Navigation

**Flag:** `school-21{n4v1g4t3_d33p3r_7h4n_y0u_th1nk}`

```bash
cd ~/-
cat flag.txt
```

The directory name `-` is unusual and requires proper escaping or path specification.

---

## Challenge 02: Hidden Files

**Flag:** `5CH00L-21{h1dd3n_1n_pl41n_s1gh7}`

```bash
ls -la ~
cat ~/.flag.txt
```

Files starting with `.` are hidden by default in Linux.

---

## Challenge 03: Groups

**Flag:** `ScHoOl-21{gr0up_pr1v1l3g3s_unl0ck3d}`

```bash
groups
find / -group secret 2>/dev/null
cat /etc/s21_groups/flag.txt
```

The user is member of the `secret` group, which has read access to the flag.

---

## Challenge 04: Sudo

**Flag:** `school-21{sud0_p0w3r_w1th0ut_r00t}`

```bash
sudo -l
sudo ls /root
sudo cat /root/flag_sudo.txt
```

Limited sudo access allows reading specific files as root.

---

## Challenge 05: Cron

**Flag:** `SCHOOL-21{t1m3_b4s3d_4ut0m4t10n}`

```bash
ps aux | grep [c]ron
cat /etc/cron.d/flag
# Wait for cron to run (every minute)
cat /tmp/flag_cron.txt
```

Automated task copies the flag to a readable location.

---

## Challenge 06: Services

**Flag:** `school-21{l0c4lh0st_s3rv1c3s_c0unt}`

```bash
ss -tlnp  # or netstat -tlnp
nc localhost 9001
# Decode base64 output
echo "c2Nob29sLTIxe2wwYzRsaDBzdF9zM3J2MWMzc19jMHVudH0K" | base64 -d
```

Service listens on localhost port 9001, returns base64-encoded flag.

---

## Challenge 07: Logs

**Flag:** `school-21{l0gs_t3ll_th3_truth}`

```bash
ls /var/log/
cat /var/log/ctf_secret.log
# Decode ROT13
echo "fpubby-21{y0tf_g3yy_gu3_gehgu}" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

Flag stored in logs with ROT13 encoding.

---

## Challenge 08: PATH

**Flag:** `school-21{p4th_h1j4ck_succ3ss}`

```bash
# Check .zshrc for PATH manipulation
cat ~/.zshrc
# Run the hijacked ls
ls
# Or use full path to see real directory
/bin/ls
```

Custom `ls` in user's bin directory is found first in PATH.

---

## Challenge 09: Symlinks

**Flag:** `school-21{symb0l1c_l1nks_f0ll0w3d}`

```bash
ls -la ~/flag_symlink.txt
cat ~/flag_symlink.txt
# Decode hex
echo "7363686f6f6c2d32317b73796d6230316331635f6c316e6b735f6630316c30773364" | xxd -r -p
```

Symlink points to root-owned file, but can be read. Flag is hex-encoded.

---

## Flag Summary

1. `school-21{n4v1g4t3_d33p3r_7h4n_y0u_th1nk}`
2. `5CH00L-21{h1dd3n_1n_pl41n_s1gh7}`
3. `ScHoOl-21{gr0up_pr1v1l3g3s_unl0ck3d}`
4. `school-21{sud0_p0w3r_w1th0ut_r00t}`
5. `SCHOOL-21{t1m3_b4s3d_4ut0m4t10n}`
6. `school-21{l0c4lh0st_s3rv1c3s_c0unt}`
7. `school-21{l0gs_t3ll_th3_truth}`
8. `school-21{p4th_h1j4ck_succ3ss}`
9. `school-21{symb0l1c_l1nks_f0ll0w3d}`

All flags use variations of "school-21" branding with different capitalizations to prevent simple grep searches.
