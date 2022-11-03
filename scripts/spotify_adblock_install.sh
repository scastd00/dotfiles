#!/bin/bash

# Install spotify from debian repository
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

## Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Download the adblock and install it
git clone https://github.com/abba23/spotify-adblock.git
cd spotify-adblock && make && sudo make install

# Add desktop file
echo '[Desktop Entry]
Type=Application
Name=Spotify (adblock)
GenericName=Music Player
Icon=spotify-client
TryExec=spotify
Exec=env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify %U
Terminal=false
MimeType=x-scheme-handler/spotify;
Categories=Audio;Music;Player;AudioVideo;
StartupWMClass=spotify' >> ~/.local/share/applications/spotify-adblock.desktop
