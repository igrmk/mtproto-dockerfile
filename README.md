# MTProxy Docker

Minimal Docker image and deploy script for [Telegram MTProxy](https://github.com/TelegramMessenger/MTProxy).

## Prerequisites

- `xxd` — needed locally for secret generation and TLS mode

## Server setup

```bash
apt-get install -y docker.io
```

## Deploy

Run everything below locally. First, generate a secret and save it somewhere safe, like a password manager:

```bash
head -c 16 /dev/urandom | xxd -ps
```

Then deploy. The script builds the image, transfers it via SSH to the specified server, and starts the container there. It will prompt for the secret. Obfuscation modes:

- **standard** — basic MTProto obfuscation, easy to detect and block
- **padding** — random padding, harder to detect via packet size analysis
- **tls** — fake TLS, traffic looks like HTTPS to the given domain (hardest to block)

```bash
./deploy example.com:443 standard
./deploy example.com:443 padding
./deploy example.com:443 tls example.org
```
