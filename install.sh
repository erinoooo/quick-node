#!/usr/bin/env bash
set -euo pipefail

NVM_VERSION="${NVM_VERSION:-v0.40.3}"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# Need curl or wget, plus git is NOT required for the install script
if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required. On Debian/Ubuntu: sudo apt install -y curl" >&2
  exit 1
fi

# 1. Install nvm (skip if already present)
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  echo "Installing nvm $NVM_VERSION..."
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
else
  echo "nvm already installed, skipping."
fi

# 2. Load nvm into this script's shell
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"

# 3. Install latest LTS Node (npm comes bundled) and make it the default
echo "Installing latest Node LTS..."
nvm install --lts
nvm alias default 'lts/*'
nvm use default >/dev/null

echo
echo "Done!"
echo "  node: $(node -v)"
echo "  npm:  $(npm -v)"
echo
echo "Run 'exec \$SHELL' or open a new terminal to start using it."
