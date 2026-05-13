# Orchestratia — Homebrew Tap

Official Homebrew tap for [Orchestratia](https://orchestratia.com) on macOS.

## Install

```bash
brew tap orchestratiahq/tap
brew install orchestratia-agent
orchestratia register <YOUR_TOKEN>
```

Or as a one-liner:

```bash
brew install orchestratiahq/tap/orchestratia-agent
```

Get your registration token from the [Servers page](https://orchestratia.com/servers) → **Add Server** → **Generate Token**.

## Run as a service

The Formula ships a `brew services` integration:

```bash
brew services start orchestratia-agent     # starts now + runs at login
brew services stop  orchestratia-agent
brew services restart orchestratia-agent
```

Logs land in `$(brew --prefix)/var/log/orchestratia.log`.

## Upgrade

```bash
brew update
brew upgrade orchestratia-agent
```

Sessions stay alive across upgrades (tmux preserves them).

## Uninstall

```bash
brew services stop orchestratia-agent
brew uninstall orchestratia-agent
brew untap orchestratiahq/tap          # optional, removes the tap entirely
rm -rf "$HOME/Library/Application Support/Orchestratia"   # removes config + key
```

## Supported macOS versions

Built and tested on macOS Ventura (13) and later, both Apple Silicon and Intel.

## Other platforms

- **Linux**: `curl -fsSL https://install.orchestratia.com/linux | sudo bash -s -- <TOKEN>`
- **Windows**: `irm https://install.orchestratia.com/windows | iex` (with `$env:ORC_TOKEN=...`)

Full docs: <https://orchestratia.com/docs/getting-started>

## Repository

- Agent source: <https://github.com/kumarimlab/orchestratia-agent>
- Issues: <https://github.com/kumarimlab/orchestratia-agent/issues>
- This tap: <https://github.com/orchestratiahq/homebrew-tap>
