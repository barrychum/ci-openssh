### SSH Server Docker Image

This Docker image provides an SSH server that allows secure file copying via SCP. It is configured to start an SSH daemon, making it ready to accept SCP connections.

![GitHub License](https://img.shields.io/github/license/barrychum/docker-openssh) ![Custom Badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/barrychum/6210ce668e923bd7b478ff9f965debee/raw/8b83476d14cdb3e9c3c0c6e8d39623c4dbf888f7/docker-openssh-build-date-badge.json) 

A docker image is available at [stellarhub/openssh](https://hub.docker.com/r/stellarhub/openssh) on Docker Hub.

1. **Create a Dockerfile**:

   Please use the Dockerfile at the root of this repository.

2. **Build the Docker image**:

   ```bash
   docker build --build-arg USERNAME=myuser --build-arg PASSWORD=mypassword -t my-scp-server .
   ```

   Replace `myuser` and `mypassword` with your desired username and password.

3. **Run the Docker container**:

   ```bash
   docker run -d -p 2222:22 -e USERNAME=myuser -e PASSWORD=mypassword -v /$HOME/mnt:/mnt/data --name scp-server my-scp-server

   docker run -d --rm  -p 22:22  -v .:/mnt/data stellarhub/openssh --name ssh stellarhub/openssh
   ```

   - `-v /path/to/local/disk:/mnt/data` mounts a local directory or disk (`/path/to/local/disk` on the host) to `/mnt/data` inside the container.
   - `-p 2222:22` maps host port 2222 to container port 22 (change `2222` to any desired port on the host).
   - `--name scp-server` assigns a name to the container (`scp-server` in this example).

4. **Access your SCP server**:

   Use an SCP client to connect to your server. For example:

   ```bash
   scp file.txt myuser@localhost:2222:/mnt/data/destination/
   scp -P 2222 ./Dockerfile myuser@localhost:/mnt/data/keyvault
   ```

   Replace `myuser` with your username (`myuser` in this example), `file.txt` with the file you want to transfer, and adjust the destination path (`/mnt/data/destination/` in this example) as needed.

This setup allows you to build and run an SCP server Docker container with a specified mount point for local disk and customizable username/password via build arguments. 