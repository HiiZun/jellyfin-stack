# jellyfin-stack
My custom torrenting and seeding installation for media server (jellyfin)

## Installation
1. Clone the repository
2. Rename and fill in the `.env.example` file with your own values
3. Run `docker-compose up -d` to start the services

## Requirements
- Docker
- Docker Compose
- External Hard drive (RECOMMENDED for media storage)

## Services
- Jellyfin: Media server to display the media
- Cloudflared: Secure tunneling to your domain
- Radarr: Automatically find movies
- Sonarr: Automatically find TV shows
- Readarr: Download books
- Lidarr: Download music
- Prowlarr: Manage Sonarr, Radarr, and download clients
- Flaresolverr: Proxy server to bypass Cloudflare and DDoS-GUARD protection
- Dozzle: View logs of any container in real time
- Unpacker: Unzip zipped files
- qBittorrent: Torrent client
- Gluetun (Optional): VPN client for secure torrenting
- Requestrr (Optional): Discord bot for requesting media

## Configuration
Rename `.env.example` to `.env` and fill in the following values:
```env
# Jellyfin environment variables
JELLYFIN_URL=http://localhost:8096
PUID=1000
PGID=1000

# Cloudflared environment variables
CLOUDFLARED_TUNNEL_TOKEN=your_tunnel_token_here

# Common environment variables
TZ=Europe/Paris

# Unpacker environment variables
SONARR_KEY=your_sonarr_api_key_here
RADARR_KEY=your_radarr_api_key_here

# Media path
MEDIA_PATH=/path/to/your/media
BASE_PATH=/path/to/your/base

# Enabled profiles (comma-separated). 
# Options: 
# - novpn (default qbittorrent without VPN)
# - vpn (qbittorrent routed through gluetun VPN)
# - discord (requestrr discord bot)
COMPOSE_PROFILES=novpn

# Gluetun VPN environment variables (Optional)
# See https://github.com/qdm12/gluetun-wiki/tree/main/setup/providers for full list of providers
# Common providers: nordvpn, protonvpn, mullvad, expressvpn, surfshark, cyberghost, pia, custom

VPN_SERVICE_PROVIDER=nordvpn
VPN_TYPE=openvpn # or wireguard

# --- OpenVPN Configuration (NordVPN, ExpressVPN, ProtonVPN, etc.) ---
OPENVPN_USER=your_openvpn_username
OPENVPN_PASSWORD=your_openvpn_password

# --- Wireguard Configuration (Mullvad, Custom, etc.) ---
WIREGUARD_PRIVATE_KEY=your_wireguard_private_key_here
WIREGUARD_ADDRESSES=your_wireguard_addresses_here

# --- Server Selection (Optional) ---
# SERVER_COUNTRIES=Switzerland
# SERVER_REGIONS=Europe
# SERVER_CITIES=Zurich
```

### Enabling Optional Services
This stack uses Docker Compose profiles to manage optional services. You can enable them by modifying the `COMPOSE_PROFILES` variable in your `.env` file.

**Gluetun (VPN) & qBittorrent Integration:**
1. Change `COMPOSE_PROFILES=novpn` to `COMPOSE_PROFILES=vpn` in your `.env` file.
2. Fill in the VPN variables in your `.env` file based on your provider (e.g., NordVPN, ProtonVPN, Mullvad, ExpressVPN). You can find the exact variables needed for your provider in the [Gluetun Wiki](https://github.com/qdm12/gluetun-wiki/tree/main/setup/providers).
3. Run `docker-compose up -d` to apply the changes.
*(Note: When using the VPN profile, qBittorrent's traffic is automatically routed through Gluetun, and other services will communicate with it seamlessly).*

**Requestrr (Discord Bot):**
1. Add `discord` to your `COMPOSE_PROFILES` (e.g., `COMPOSE_PROFILES=novpn,discord` or `COMPOSE_PROFILES=vpn,discord`).
2. Run `docker-compose up -d` to apply the changes.
3. Configure the bot via its web interface at `http://localhost:4545`.

## FAQ
**Q: How do I access the Jellyfin server?**
A: Open your browser and go to `http://localhost:8096`, or depending on your tunnel configuration, `https://yourdomain.com`.

**Q: How do I update the services?**
A: Run `docker-compose pull` followed by `docker-compose up -d`.

**Q: How do I view logs?**
A: Access Dozzle at `http://localhost:9999`.

**Q: How do I add media?**
A: Add your media to the `MEDIA_PATH` directory.

## How to Contribute
1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a new Pull Request