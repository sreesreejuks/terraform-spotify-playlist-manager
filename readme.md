
# Terraform Spotify Playlist Manager

This repository contains Terraform code to manage Spotify playlists, including automation of playlist creation, updating, and management of tracks. The goal of this setup is to allow seamless integration and automation for managing Spotify playlists directly through Terraform.

## Setup

### Prerequisites
1. **Docker Desktop** (for Windows users)
2. **Terraform**
3. **Spotify Account** (You need to generate your client ID and secret key from Spotify Developer account)
4. **VSCode** (or any preferred editor)

### 1. Spotify API Access

To use this automation, you need to generate credentials from the Spotify Developer Dashboard:

- Go to the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/applications).
- Create a new app to obtain your **Client ID** and **Client Secret**.
- Set the **Redirect URI** in the Spotify Developer Dashboard (use a local URL like `http://localhost:27228/spotify_callback`).

Now that you’ve created the Spotify app, configure and start the authorization proxy server, which allows Terraform to interact with Spotify.

1. Add the **Client ID** and **Client Secret** values to a `.env` file as `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET`.
2. Ensure Docker Desktop is running, then start the server:
   ```bash
   docker run --rm -it -p 27228:27228 --env-file .env ghcr.io/conradludgate/spotify-auth-proxy
   ```
3. Visit the authorization URL provided in the terminal after "Auth:" to authenticate. 
4. After authentication, the terminal will display "Authorization successful." Leave the server running.

### 2. Clone This Repository

In a separate terminal, clone this repository:
```bash
git clone https://github.com/sreesreejuks/terraform-spotify-playlist-manager.git
```

Locate the Spotify proxy server's terminal, copy the API key displayed, and add it to the `terraform.tfvars` file:
```hcl
spotify_api_key = "YOUR_API_KEY"
```

### Create a Playlist

To create a new playlist:
1. Open `create_playlist.tf`.
2. Add the playlist name, description, and song URLs. For example:
   ```hcl
   url = "https://open.spotify.com/track/3yUcJwYu7fXAfqMj9krY6l"
   ```
3. Comment out the content in `import_playlist.tf` to avoid conflicts.

Run the following commands to apply the configuration:
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

### Import an Existing Playlist

To import an existing playlist:
1. Comment out the `create_playlist.tf` content.
2. Uncomment the `import_playlist.tf` file.
3. Use the following command, replacing the playlist ID with your own:
   ```bash
   terraform import spotify_playlist.imported_playlist YOUR_PLAYLIST_ID
   ```
4. Once imported, Terraform will display track IDs for all songs in the playlist. Copy these IDs and paste them into the `playlist.tf` file.

Run the following commands to update the playlist:
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

### Notes

- Always verify the number of songs, song durations, and track details before running `terraform apply` to ensure the playlist is correct.
- Applying changes will delete the existing playlist and create a new one with the defined tracks.

---

For more details, visit [Terraform Spotify Provider Documentation](https://github.com/conradludgate/terraform-provider-spotify) 
