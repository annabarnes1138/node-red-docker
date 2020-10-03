# node-red-for-ha-core

[![Build Status](https://travis-ci.org/stecky/alpine-node-red-docker.svg?branch=master)](https://travis-ci.org/stecky/alpine-node-red-docker)
[![DockerHub Pull](https://img.shields.io/docker/pulls/stecky/node-red.svg)](https://hub.docker.com/r/stecky/node-red/)
[![DockerHub Stars](https://img.shields.io/docker/stars/stecky/node-red.svg?maxAge=2592000)](https://hub.docker.com/r/stecky/node-red/)
[![https://www.buymeacoffee.com/stecky](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffee-orange?style=for-the-badge)](https://www.buymeacoffee.com/noderedhacore)

Essentially a clone of the [official Node-RED image](https://github.com/node-red/node-red-docker/blob/master/docker-custom/Dockerfile.custom), but with a base image of [lsiobase/alpine](https://github.com/linuxserver/docker-baseimage-alpine).
This lets us make [docker-mods](https://github.com/linuxserver/docker-mods) like [this one](https://github.com/stecky/docker-mods/tree/node-red-home-assistant) that adds the Home Assistant related add-ons to Node-RED

## Quick Start

To run in Docker in its simplest form just run:

        docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered stecky/node-red

Let's dissect that command:

        docker run                   - run this container, initially building locally if necessary
        -it                          - attach a terminal session so we can see what is going on
        -p 1880:1880                 - connect local port 1880 to the exposed internal port 1880
        -v node_red_data:/data       - mount the host node_red_data directory to the container /data directory so any changes made to flows are persisted
        --name mynodered             - give this machine a friendly local name
        stecky/node-red              - the image to base it on - currently Node-RED v1.1.3

Running that command should give a terminal window with a running instance of Node-RED.

        Welcome to Node-RED
        ===================

        10 Jul 12:57:10 - [info] Node-RED version: v1.1.3
        10 Jul 12:57:10 - [info] Node.js  version: v10.21.0
        10 Jul 12:57:10 - [info] Linux 4.9.184-linuxkit x64 LE
        10 Jul 12:57:11 - [info] Loading palette nodes
        10 Jul 12:57:16 - [info] Settings file  : /data/settings.js
        10 Jul 12:57:16 - [info] Context store  : 'default' [module=memory]
        10 Jul 12:57:16 - [info] User directory : /data
        10 Jul 12:57:16 - [warn] Projects disabled : editorTheme.projects.enabled=false
        10 Jul 12:57:16 - [info] Flows file     : /data/flows.json
        10 Jul 12:57:16 - [info] Creating new flow file
        10 Jul 12:57:17 - [warn]

        ---------------------------------------------------------------------
        Your flow credentials file is encrypted using a system-generated key.

        If the system-generated key is lost for any reason, your credentials
        file will not be recoverable, you will have to delete it and re-enter
        your credentials.

        You should set your own key using the 'credentialSecret' option in
        your settings file. Node-RED will then re-encrypt your credentials
        file using your chosen key the next time you deploy a change.
        ---------------------------------------------------------------------

        10 Jul 12:57:17 - [info] Starting flows
        10 Jul 12:57:17 - [info] Started flows
        10 Jul 12:57:17 - [info] Server now running at http://127.0.0.1:1880/

        [...]

You can then browse to `http://{host-ip}:1880` to get the familiar Node-RED desktop.

The advantage of doing this is that by giving it a name (mynodered) we can manipulate it
more easily, and by fixing the host port we know we are on familiar ground.
Of course this does mean we can only run one instance at a time... but one step at a time folks...

If we are happy with what we see, we can detach the terminal with `Ctrl-p` `Ctrl-q` - the
container will keep running in the background.

To reattach to the terminal (to see logging) run:

        docker attach mynodered

If you need to restart the container (e.g. after a reboot or restart of the Docker daemon):

        docker start mynodered

and stop it again when required:

        docker stop mynodered

**Healthcheck**: to turn off the Healthcheck add `--no-healthcheck` to the run command.

## Find Us

* [GitHub](https://github.com/stecky/alpine-node-red-docker)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the GNU General License - see the [LICENSE](LICENSE) file for details.
