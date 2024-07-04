# Use a smaller base image
FROM alpine:latest

# Define built-time variables
# Retrieved in action yaml
ARG VERSION=1.0.0

# Install OpenSSH server and sudo in a single layer
RUN apk add --no-cache openssh-server sudo && \
    ssh-keygen -A && \
    mkdir /var/run/sshd

# Arguments for username and password
ARG USERNAME=user
ARG PASSWORD=password
ARG USER_ID=1001
ARG GROUP_ID=1001

# Create a user for SCP access in a single layer
RUN addgroup -g $GROUP_ID $USERNAME && \
    adduser -D -u $USER_ID -G $USERNAME -s /bin/ash $USERNAME && \
    echo "$USERNAME:$PASSWORD" | chpasswd && \
    adduser $USERNAME wheel && \
    echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel

# Configure SSH and create mount point in a single layer
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    mkdir /data

# Set volume and expose port
VOLUME /data
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]

