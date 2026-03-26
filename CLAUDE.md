# MTProxy Docker

Docker image for Telegram's MTProxy server.

## Project structure

- `Dockerfile` — multi-stage build that clones https://github.com/TelegramMessenger/MTProxy and compiles it on Ubuntu
- `deploy` — bash script that builds the image, transfers it to the server via SSH, and starts the container
- `entrypoint` — container entrypoint that fetches Telegram configs and runs mtproto-proxy
- `README.md` — usage instructions

## Commits

- Use one-line conventional commits (e.g. `feat: add deploy key setup docs`)

## Style

- Use tabs in shell scripts
- Indent heredoc body one level deeper than the opening line
- Align closing heredoc delimiter with the line that opens it

## Key details

- The upstream MTProxy is a C project using x86-specific instructions (SSE, AES-NI, PCLMUL), so this only builds on x86_64
- The Ubuntu version in the Dockerfile should be pinned to a specific version, not `latest`
