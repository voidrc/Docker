# OffSec-21 Linux CTF

A Docker-based Linux privilege escalation and enumeration CTF challenge with 9 real flags.

## Features

- 9 progressive challenges covering essential Linux security concepts
- All flags follow school-21 branding pattern (with variations to prevent grep)
- Some flags are encoded (base64, hex, ROT13) for extra difficulty
- No decoy flags - only real challenges
- Auto-reset every 15 minutes to maintain challenge integrity

## Quick Start

```bash
# Build and start the CTF
./run.sh

# Connect to the challenge
ssh ctf@localhost -p 2222
# Password: ctf

# Read the challenges
cat TASKs.txt
```

## Challenge Topics

1. **Navigation** - Working with unusual directory names
2. **Hidden Files** - Finding dot files
3. **Groups** - Leveraging group memberships
4. **Sudo** - Limited privilege escalation
5. **Cron** - Automated task exploitation
6. **Services** - Local network services
7. **Logs** - Log file analysis
8. **PATH** - PATH hijacking
9. **Symlinks** - Symbolic link abuse

## Reset

The environment automatically resets every 15 minutes, or manually:

```bash
docker restart offsec21
```

## Architecture

- Based on Ubuntu 22.04
- SSH access on port 2222 (host)
- User: ctf / Password: ctf
- All challenges reset to original state automatically

## Files

- `TASKs.txt` - Challenge descriptions and hints
- `setup.sh` - Challenge environment setup
- `reset_ctf.sh` - Reset script for maintaining clean state
- `run.sh` - Build and run the container
- `SOLUTION.md` - Complete solutions (for instructors)

## Flag Format

All flags follow the pattern: `school-21{...}` with various capitalizations:
- `school-21{...}`
- `SCHOOL-21{...}`
- `ScHoOl-21{...}`
- `5CH00L-21{...}`

Some flags are encoded and require decoding before submission.

## Educational Goals

This CTF teaches:
- Linux filesystem navigation
- File permissions and ownership
- User and group privileges
- Service enumeration
- Log analysis
- PATH environment manipulation
- Symbolic links and their security implications
- Basic encoding/decoding techniques

Good luck!
