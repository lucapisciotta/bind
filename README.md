# lucapisciotta/bind
[![CI](https://github.com/lucapisciotta/bind/actions/workflows/main.yml/badge.svg)](https://github.com/lucapisciotta/bind/actions/workflows/main.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/lucapisciotta/bind)
![GitHub](https://img.shields.io/github/license/lucapisciotta/bind)
------------------------
BIND is a suite of software for interacting with the Domain Name System (DNS). Its most prominent component, named, performs both of the main DNS server roles, acting as an authoritative name server for DNS zones and as a recursive resolver in the network

The image is based on the official `alpine:latest` image and the bind package from the official repository

### Supported architectures
------------------------
This image supports different architecture: `linux/amd64`, `linux/arm64`, `linux/arm/v7`.

### Application Setup
------------------------
The setup is quite simple, you can simply run the docker using the command in the `Usage` section and reach it using its IP on the standard dns ports.
I've insered a sample domain `example.int` with a single record pointing to `192.168.1.10` that point to `console.example.int`, you can find the configuration in the [GitHub repository](https://github.com/lucapisciotta/bind).

All requests that not correspond to anything are forwarded to `208.67.222.222` and `208.67.220.220`.

If you already have a bind configuration you can simply mount the volume in `/etc/bind`.
If you want to customize your configuration, you can simply modify these files:

| File | Scope |
| :---: | :---: |
| **named.conf** | For adding new file configurations |
| **named.conf.local** | To define your custom domains |
| **named.conf.options** | To edit bind configuration |
| **zones/db.your_domain** | To configure your domain records |

### Usage
------------------------
Here are some example snippets to help you get started creating a container.

**docker-compose**
```
---
version: '3.8'
services:
  bind:
    image: lucapisciotta/bind
    volumes:
      - /path/to/your/named.conf:/etc/bind
      - /path/to/your/named.conf.local:/etc/bind
      - /path/to/your/named.conf.options:/etc/bind
      - /path/to/your/zones:/etc/bind/zones
      - bind_cache/:/var/cache/bind
    ports:
      - 53:53/tcp
      - 53:53/udp
      - 953:953/tcp
      - 953:953/udp

volumes:
    bind_cache:

```
**docker-cli**
```
docker run -d \
    --name=bind \
    -p 53:53/tcp \
    -p 53:53/udp \
    -p 953:953/tcp \
    - 953:953/udp \
    -v /path/to/your/named.conf:/etc/bind \
    -v /path/to/your/named.conf.local:/etc/bind \
    -v /path/to/your/named.conf.options:/etc/bind \
    -v /path/to/your/zones:/etc/bind/zones \
    -v bind_cache/:/var/cache/bind \
    --restart unless-stopped \
    lucapisciotta/bind
```

### Sources
------------------------
Docker image repository: https://github.com/lucapisciotta/samba
