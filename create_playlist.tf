resource "spotify_playlist" "playlist" {
  name        = "New Playlist" # Your playlist name here
  description = "Playlist created using Terraform"
  public      = true # or false

  tracks = [
    data.spotify_track.thankyou.id,
    data.spotify_track.poneepo.id,
    data.spotify_track.neepaarthavizhigal.id,
  ]
}

data "spotify_track" "thankyou" {
  url = "https://open.spotify.com/track/3yUcJwYu7fXAfqMj9krY6l"
}
data "spotify_track" "poneepo" {
  url = "https://open.spotify.com/track/4tC9EKLTfmLEryGR2f7Wjc"
}
data "spotify_track" "neepaarthavizhigal" {
  url = "https://open.spotify.com/track/0xttqqTj7ZAGyVkfOYxQ4F"
}

