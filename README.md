# Dockerized Remote SSH Server

This repository provides a Dockerfile and associated files to create a Docker container running a remote SSH server. The objective of this Docker image is to facilitate the setup of a secure SSH server environment for remote access to a containerized environment.

## Features

- **Base Image**: The Dockerfile is based on `phusion/baseimage:0.11`, which provides a minimal, but complete, Ubuntu-based image for running applications within containers.
- **Customization**: The Dockerfile allows for customization by specifying environment variables, enabling non-interactive mode, and setting the locale to `en_US.UTF-8`.
- **Volume Mounting**: It supports volume mounting to `/home/project`, allowing users to easily map host directories or data volumes into the container.
- **SSH Server**: The Docker image sets up and runs an SSH server, making it accessible for remote SSH connections.

## Usage

To use this Docker image and run a remote SSH server inside a container, follow these steps:

- **Clone this repo**
- **Build the Docker Image**: docker build -t ssh-server .
- **Run the Docker Container**: docker run -d -p 2222:22 --name my-ssh-server ssh-server
