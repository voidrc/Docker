# DeceasedCraft Minecraft Server in Docker

## Quick Start

### 1. Download Server Pack
- Download `DeceasedCraft_Server_vX.X.X.zip` from the official source
- Place the zip file in this folder (same location as `Dockerfile`)

### 2. Build and Start
```bash
docker compose build
docker compose up -d
```

### 3. Check if Running
```bash
docker compose logs -f
```
Press `Ctrl+C` to stop viewing logs (server keeps running).

---

## Connecting to Your Server

### Local Network (Same WiFi/Network)
1. Open Command Prompt on Windows
2. Type: `ipconfig`
3. Find **IPv4 Address** (looks like `192.168.x.x`)
4. In Minecraft, add server with that IP address
5. Port: `25565` (default)

### From Outside Your Network
Choose one option:

**Option A: Port Forwarding** (most direct)
- Forward port `25565` on your router to your computer
- Use your public IP (search "what's my ip")
- Others use: `your-public-ip:25565`

**Option B: ngrok** (easiest, no router access)
- Sign up at ngrok.com
- Run: `ngrok tcp 25565`
- Share the provided address with friends

**Option C: VPN** (safest)
- Use Hamachi, Radmin VPN, or similar
- Everyone connects through the VPN

---

## Basic Server Management

### Stop Server
```bash
docker compose down
```

### Restart Server
```bash
docker compose restart
```

### View Logs
```bash
docker compose logs -f
```

### Access Server Console
```bash
docker attach deceased-craft-server
```
Then type commands like `say hello` or `list`

To exit console without stopping server: Press `Ctrl+P` then `Ctrl+Q`

---

## Allow Cracked Clients (Pirated Minecraft)

If you want players with cracked/pirated Minecraft to join:

1. Access the running container:
```bash
docker compose exec deceased-craft sh
```

2. Edit server.properties:
```bash
sed -i 's/online-mode=true/online-mode=false/' server.properties
```

3. Exit and restart:
```bash
exit
docker compose restart
```

**Security tip:** Use a whitelist so only your friends can join (see below).

---

## Add Server Admins (Operators)

### Quick Method (Using Console)
```bash
docker attach deceased-craft-server
```

Type (replace `PlayerName` with actual name):
```
op PlayerName
```

Press `Ctrl+P` then `Ctrl+Q` to exit console.

### Manual Method (Edit File)
1. Stop server: `docker compose down`
2. Open: `server-data/ops.json`
3. Add this (replace `PlayerName`):
```json
[
  {
    "uuid": "00000000-0000-0000-0000-000000000000",
    "name": "PlayerName",
    "level": 4,
    "bypassesPlayerLimit": false
  }
]
```
4. Save and restart: `docker compose up -d`

---

## Turn Off PvP (Player vs Player Combat)

1. Access the running container:
```bash
docker compose exec deceased-craft sh
```

2. Edit server.properties:
```bash
sed -i 's/pvp=true/pvp=false/' server.properties
```

3. Exit and restart:
```bash
exit
docker compose restart
```

Players can still hit each other but won't take damage.

---

## Allow Flight (Creative Mode Flying)

1. Access the running container:
```bash
docker compose exec deceased-craft sh
```

2. Edit server.properties:
```bash
sed -i 's/allow-flight=false/allow-flight=true/' server.properties
```

3. Exit and restart:
```bash
exit
docker compose restart
```

Now players in Creative or with flight mods can fly.

---

## Change World Difficulty

### Quick Method (Using Console)
```bash
docker attach deceased-craft-server
```

Type one of these:
```
difficulty peaceful
difficulty easy
difficulty normal
difficulty hard
```

Press `Ctrl+P` then `Ctrl+Q` to exit.

### Manual Method (Edit File)
1. Open: `server-data/server.properties`
2. Find or add this line:
```
difficulty=1
```

Difficulty values:
- `0` = Peaceful (no monsters)
- `1` = Easy (weak monsters)
- `2` = Normal (medium monsters)
- `3` = Hard (strong monsters)

3. Save and restart:
```bash
docker compose restart
```

---

## Player Whitelist (Only Specific Players Can Join)

### Enable Whitelist
1. Attach to console:
```bash
docker attach deceased-craft-server
```

2. Type:
```
whitelist on
```

3. Add players (replace `PlayerName`):
```
whitelist add PlayerName
whitelist add PlayerName2
```

4. Exit with `Ctrl+P` then `Ctrl+Q`

### Remove Players
```bash
docker attach deceased-craft-server
whitelist remove PlayerName
```

---

## Memory & Performance

The server uses 2GB-4GB RAM by default. For better performance:

1. Open: `docker-compose.yml`
2. Find these lines:
```yaml
- MEMORY_MIN=2G
- MEMORY_MAX=4G
```

3. Change to your needs:
   - **2-4 players:** 2G-4G (default)
   - **5-10 players:** 4G-6G
   - **10+ players:** 6G-8G+

4. Restart server:
```bash
docker compose restart
```

---

## Backup Your World

### One-Time Backup
```bash
docker compose exec deceased-craft tar -czf /minecraft/backups/world-backup-$(date +%Y%m%d-%H%M%S).tar.gz /minecraft/world
```

Backups are saved in: `server-data/backups/`

---

## Troubleshooting

**Server won't start:**
- Check logs: `docker compose logs`
- Make sure server pack zip is in the folder
- Verify it's named `DeceasedCraft_Server_vX.X.X.zip`

**Can't connect:**
- Make sure server is running: `docker compose ps`
- Check if using correct IP address
- Check if port 25565 is open on your firewall
- Try `localhost` if connecting from same computer

**Server is slow:**
- Increase memory in `docker-compose.yml`
- Reduce draw distance on client side
- Check logs for errors: `docker compose logs -f`

**Players lag:**
- Increase memory allocation
- Reduce number of mods
- Lower world difficulty
- Reduce player render distance

---

## File Locations

All server data is in `server-data/` folder:
- **World files:** `server-data/world/`
- **Logs:** `server-data/logs/`
- **Backups:** `server-data/backups/`

**Mods and Config:**
- Mods and configs are **built into the Docker image** from the server pack
- To customize mods: Stop server, modify files in image, rebuild:
  ```bash
  docker compose down
  docker compose build
  docker compose up -d
  ```
- To extract current config for reference:
  ```bash
  docker cp deceased-craft-server:/minecraft/config ./extracted-config/
  ```

---

## Common Server Commands

Use these in console (via `docker attach deceased-craft-server`):

```bash
say message             # Broadcast message to all players
list                    # Show all online players
op PlayerName           # Make someone admin
deop PlayerName         # Remove admin status
ban PlayerName          # Ban a player
unban PlayerName        # Unban a player
kick PlayerName         # Kick a player from server
tp PlayerName x y z     # Teleport player
give PlayerName item 64 # Give items to player
difficulty 0-3          # Change difficulty
gamemode creative PlayerName  # Give creative mode
gamemode survival PlayerName  # Give survival mode
stop                    # Shutdown server gracefully
```

---

## Need Help?

- **Server won't start:** Check `docker compose logs` for error messages
- **Connection issues:** Verify IP with `ipconfig` and check firewall
- **Performance issues:** Increase memory and check server logs
- **Command syntax:** Type `help` in console for full command list

Enjoy your server!
