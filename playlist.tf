resource "spotify_playlist" "To_try_playlist" {
  name        = "To try 🎹" # Update if needed
  description = "Managed by Terraform"
  public      = true

  tracks = [
    "1il2TGB3AX2hHxmJNcKtMj",
    "3NMaXxPZjivkYz5fBpTR2I",
    "01UG5VWRhp2gr0swkI05iY",
    "5kWdnGyrVkjqPJPDERYjf0"
  ]
}
