This repository contains Terraform code to manage Spotify playlists, including automation of playlist creation, updating, and management of tracks. The goal of this setup is to allow seamless integration and automation for managing Spotify playlists directly through Terraform.

## Setup

Prerequisites: 
1. Docker Desktop (if you are windows user)
2. Terraform
3. Spotify Account ( You need to generate your client ID and secret key from Spotify developer account)
4. VSCode

### 1. Spotify API Access

To use this automation, you need to generate credentials from the Spotify Developer Dashboard:

- Go to the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/applications).
- Create a new app to obtain your **Client ID** and **Client Secret**.
- Set the **Redirect URI** in the Spotify Developer Dashboard (use a local URL like `http://localhost:27228/spotify_callback`).


Now that you created the Spotify app, you are ready to configure and start the authorization proxy server, which allows Terraform to interact with Spotify.

Click Show client secret and copy the value displayed into .env as your SPOTIFY_CLIENT_ID & SPOTIFY_CLIENT_SECRET.

Make sure Docker Desktop is running, and start the server. It will run in your terminal's foreground.

```docker run --rm -it -p 27228:27228 --env-file .env ghcr.io/conradludgate/spotify-auth-proxy

Visit the authorization server's URL provided in the terminal output after the "Auth:" message.

Once there, you'll be redirected to Spotify to authenticate. After completing the authentication, the server will confirm with "Authorization successful," indicating that the Terraform provider can now retrieve access tokens.

Keep the server running during this process.

Now clone the code using another terminal 

Locate the terminal window where the Spotify authorization proxy server is running and copy the API key displayed in the output.

Next, open the terraform.tfvars file and replace the placeholder (...) with the copied API key so that Terraform can authenticate with Spotify. Remember to save the file after making the changes.

## Note
### Create the playlist
Now you are ready to create your playlist. Apply your Terraform configuration. Terraform will show you the changes it plans to make and prompt for your approval.

To create a playlist, select the create_playlist.tf file.  find the song url you want to add, add name, description and put the song name in track.id so that the song can easily identify for example "data.spotify_track.thankyou.id", song (https://open.spotify.com/track/3yUcJwYu7fXAfqMj9krY6l) paste it  url = "<song url>"

To create a playlist, open the create_playlist.tf file. Then set the Playlist name, description, and use the song's name in the track.id field for easy identification. 
For example, for the song "Thank You," data.spotify_track.thankyou.id.
the URL would be https://open.spotify.com/track/3yUcJwYu7fXAfqMj9krY6l, and you would place it in the url field like this: url = "<song url>".

When creating a playlist, make sure to comment out the content in the import_playlist.tf section, otherwise, it will result in an error.

in your terminal, initialize Terraform, which will install the Spotify provider.

``` terraform init
``` terraform plan
``` terraform apply --auto-approve

### Import the exisitng playlist
To proceed with importing your playlist in Terraform, you need to Comment out create_playlist.tf: In your create_playlist.tf file, you should comment out the resource definition that creates a new playlist and Uncomment the import_playlist.tf and save the file

Now that the playlist import block is uncommented, you'll need to use the terraform import command to import the existing playlist. If your playlist URL is something like https://open.spotify.com/playlist/15XJBjesNNIGyhC5smKPqJ, the ID is 15XJBjesNNIGyhC5smKPqJ.


``` terraform import spotify_playlist.imported_playlist 15XJBjesNNIGyhC5smKPqJ

This will import the playlist into Terraform, so you can manage it as a Terraform resource.

After importing the playlist, you can check the state by running terraform show to confirm that the playlist has been successfully imported.

Once you import the playlist, Terraform will display the track IDs for all the songs in that playlist. Copy these track IDs and paste them into your playlist.tf file, where you define the playlist resource.


Now, run the following commands:

terraform init – This will initialize your Terraform configuration.
terraform plan – This will show the execution plan, giving you a preview of the changes that will be made.
terraform apply --auto-approve – This will apply the changes.

Note: Before applying the terraform apply command, double-check that all the songs, the correct number of songs, and their duration are included in the plan. This ensures that the new playlist matches your expectations, as the command will delete the existing playlist and create a new one with the track IDs you've pasted.