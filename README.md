# (Continuous Integration) SSH Server Docker Image
![GitHub License](https://img.shields.io/github/license/barrychum/docker-openssh) ![Custom Badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/barrychum/6210ce668e923bd7b478ff9f965debee/raw/docker-openssh-build-date-badge.json) 

![Custom Badge](https://ghcr-badge.egpl.dev/barrychum/ci-openssh/tags?color=%2344cc11&ignore=&n=1&label=ghcr+tag&trim=) ![Custom Badge](https://ghcr-badge.egpl.dev/barrychum/ci-openssh/size?color=%2344cc11&tag=latest&label=image+size&trim=)

This repository demonstrates a simple Continuous Integration (CI) setup. When the Dockerfile in the main branch is updated, a GitHub Workflow is triggered to perform a series of actions, including building and pushing a Docker image.

## Features
- Uses the `VERSION` variable in the Dockerfile as the Docker image tag.
- Builds and pushes images to Docker Hub.
- Saves build artifacts and reports build status via badges.
- Creates a Docker image for an SSH server, suitable for secure file transfers via SCP.

## Docker Image
The Docker image is available on Docker Hub: [stellarhub/openssh](https://hub.docker.com/r/stellarhub/openssh).

### Steps to Use
1. **Create a Dockerfile**:
   Use the Dockerfile located at the root of this repository.

2. **Build the Docker Image**:
   ```bash
   docker build --build-arg USERNAME=myuser --build-arg PASSWORD=mypassword -t my-scp-server .
   ```
   Replace `myuser` and `mypassword` with your desired username and password.

3. **Run the Docker Container**:
   ```bash
   docker run -d -p 2222:22 -e USERNAME=myuser -e PASSWORD=mypassword -v /$HOME/mnt:/mnt/data --name scp-server my-scp-server
   ```
   - `-v /path/to/local/disk:/mnt/data` mounts a local directory to `/mnt/data` inside the container.
   - `-p 2222:22` maps host port 2222 to container port 22.
   - `--name scp-server` names the container `scp-server`.

4. **Access the SCP Server**:
   Use an SCP client to connect to your server:
   ```bash
   scp -P 2222 file.txt myuser@localhost:/mnt/data/destination/
   ```
   Replace `file.txt` with the file to transfer and adjust the destination path as needed.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

