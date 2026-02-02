# Docker-Craft

Unified Docker Compose setup for managing Minecraft servers and hosting services.

## Usage

⚠️ **Important**: Only one server runs at a time. Use profiles to choose which server to run.

### Start ATM-10 Server

```bash
cd Docker-Craft
docker-compose --profile atm10 up -d
```

### Start School-21 Server

```bash
cd Docker-Craft
docker-compose --profile school21 up -d
```

### Stop All Services

```bash
docker-compose down
```

### Switch Servers

```bash
# Stop current server
docker-compose down

# Start different server
docker-compose --profile school21 up -d
```

### View Logs

```bash
# All running services
docker-compose logs -f

# Specific service
docker-compose logs -f atm10-server
docker-compose logs -f school21-server
```

## Environment Variables

The `.env` file contains:

- `CF_API_KEY` - CurseForge API key for mod downloads

## Servers

### ATM-10 (All The Mods 10)

- **Profile**: `atm10`
- **Port**: 25565
- **Memory**: 10GB (9GB limit)
- **Version**: 1.21.1
- **Difficulty**: Hard (3)

### School-21 (Deceased Craft)

- **Profile**: `school21`
- **Port**: 25565
- **Memory**: 9GB
- **Java**: 17
- **Difficulty**: Easy (1)
- **Features**: Flight enabled, PVP disabled

## Quick Reference

| Profile    | Server          | Port  | Command                                   |
| ---------- | --------------- | ----- | ----------------------------------------- |
| `atm10`    | All The Mods 10 | 25565 | `docker-compose --profile atm10 up -d`    |
| `school21` | Deceased Craft  | 25565 | `docker-compose --profile school21 up -d` |

## Adding a New Server

Follow these steps to add a new Minecraft server to Docker-Craft:

### 1. Create Server Directory

```bash
cd Docker-Craft
mkdir NewServer-Name
mkdir NewServer-Name/data
```

### 2. Add Server to docker-compose.yml

Add a new service definition to `docker-compose.yml`:

```yaml
# NewServer Minecraft Server
newserver-name:
  image: itzg/minecraft-server:latest # or :java17, :java21, etc.
  container_name: newserver-minecraft
  profiles: ["newserver"] # Important: Add unique profile name
  tty: true
  stdin_open: true
  ports:
    - "25565:25565" # Always use 25565 since only one runs at a time
  environment:
    EULA: "TRUE"
    TYPE: "AUTO_CURSEFORGE" # or VANILLA, FORGE, FABRIC, etc.
    CF_PAGE_URL: "https://www.curseforge.com/minecraft/modpacks/your-pack/files/xxxxx"
    CF_API_KEY: ${CF_API_KEY} # Use the centralized API key
    MEMORY: "8G"
    ONLINE_MODE: "false"
    DIFFICULTY: "2"
    OPS: "KaYdZyU_1"
    # Add any other environment variables you need
  volumes:
    - "./NewServer-Name/data:/data"
  restart: unless-stopped
```

### 3. Update README

Add your new server to the documentation:

- Add server details to the **Servers** section
- Add profile command to the **Quick Reference** table

### 4. Test Your New Server

```bash
# Start the new server
docker-compose --profile newserver up -d

# Check logs
docker-compose logs -f newserver-name

# Stop when done
docker-compose down
```

### Key Points

- ✅ Always use a unique `profiles: ["name"]` for each server
- ✅ Always use port `25565:25565` (since only one runs at a time)
- ✅ Reference `${CF_API_KEY}` from the central `.env` file
- ✅ Use consistent naming: `./ServerName/data:/data`
- ✅ Add `restart: unless-stopped` for auto-restart
- ✅ **You only need the data folder** - individual compose.yml files are optional

### Can I Remove Individual compose.yml Files?

**Yes!** If you're only using the main `docker-compose.yml`, you can safely remove:

- `ATM-10/compose.yml`
- `School-21/compose.yml`

Keep them only if you want the option to run servers standalone (e.g., `cd ATM-10 && docker-compose up`).

## Notes

- Only one Minecraft server runs at a time (selected by profile)
- PlayIt hosting agent runs automatically with any server
- Both servers use the same port (25565) since only one runs at a time
- All servers run in offline mode
- Operator: KaYdZyU_1
