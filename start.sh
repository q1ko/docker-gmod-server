#!/bin/bash
set -e

SERVER_DIR="/gmod/server"
STEAMCMD="/usr/games/steamcmd"


# Change these values to your need
MAXPLAYERS=16
MAP=ttt_minecraft_b5
GAME_MODE=terrortown
COLLECTION=3561782742

echo "=== Updating/Installing Garry's Mod server ==="
"$STEAMCMD" \
  +force_install_dir "$SERVER_DIR" \
  +login anonymous \
  +app_update 4020 validate \
  +quit

# Change flags to your needs
echo "=== Starting Garry's Mod Server ==="
cd "$SERVER_DIR"
exec ./srcds_run -game garrysmod \
    +host_workshop_collection "$COLLECTION" \
    +maxplayers "$MAXPLAYERS" \
    +map "$MAP" \
    +gamemode "$GAME_MODE" 
