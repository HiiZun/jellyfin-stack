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
```

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