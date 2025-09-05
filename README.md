# Garry's Mod Docker Build

A **customisable, non-persistent Garry's Mod server** built with Docker. Each run downloads a fresh GMod server from the official SteamCMD Docker image and applies configs from `start.sh` and the `garrysmod` folder, allowing for addon configurations.

## Notice

This Docker build uses SteamCMD (© Valve). SteamCMD is not included in this repository and must be used according to Valve's licensing terms: https://store.steampowered.com/steamcmd

This is intended for private/experimental use. This runs SteamCMD as root in the container. 

Feel free to branch and make a pull request to make it safer. I just haven't found the need for it.

## Features

- Fully Dockerised for simple deployment
- Non-persistent: fresh server each run
- Downloads updated server and workshop content automatically
- Configurable via `start.sh` and `garrysmod` folder
- Exposes default Garry's Mod ports (27015 TCP/UDP)
- No manual SteamCMD setup required

## Use case (how it came to be)

- Friends and I only play TTT/Murder occasionally
- Due to the lack of bandwidth and hardware for supporting 15 of us, using a VPS is the next best option
- Developed the build to run on demand, then destroy the vm after we had finished a session
- We didn't need it on 24/7 and VPS provider charges by the hour instead of monthly, effectively only paying a less than a dollar per session

## Getting Started

This assumes you have already have a configuration ready that you made on a local server. 

### Build the Image

#### 1. Clone the repository:

```bash
git clone https://github.com/q1ko/docker-gmod-server.git
cd docker-gmod-server
```

#### 2. Modify garrysmod folder and start.sh

This is where you would place your configurations and addons such as ULX/ULib, following the same folder structure as configured yourself. Drop your garrysmod folder prepared earlier here.
```
garrysmod/
├── addons/
│   ├── ulib/
│   ├── ulix/
├── cfg/
│   ├── server.cfg
├── data/
├── ...
```
Don't forget to change server.cfg ;)

##### Modifying start.sh
Change the flags and values to your needs. Remove/comment collection lines if you don't need workshop collections. 
```
MAXPLAYERS=16
MAP=ttt_minecraft_b5
GAME_MODE=terrortown
COLLECTION=3561782742

exec ./srcds_run -game garrysmod \
    +host_workshop_collection "$COLLECTION" \
    +maxplayers "$MAXPLAYERS" \
    +map "$MAP" \
    +gamemode "$GAME_MODE" 
```
#### 3. Build the image and deploy the container:
```bash
docker build . -t gmodimg
docker run -it -p 27015:27015/udp -p 27015:27015/tcp gmodimg --name gmodserver
```
You will finish with the server running and on the SRCDS command line. Deployment time depends on internet speed of the host.


