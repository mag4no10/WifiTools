#!/usr/bin/env bash

set -e

echo "[+] Updating apt package lists..."
sudo apt update

echo "[+] Installing dependencies"
if [ -f "dependencies.txt" ]; then
    grep -vE '^\s*#|^\s*$' dependencies.txt | xargs sudo apt install -y
else
    echo "[-] dependencies.txt not found!"
fi

echo "[+] Initializing and updating tools"
git submodule update --init --recursive
git submodule update --remote --merge
unzip xato-net-10-million-passwords.zip

echo "[+] Setup complete!"