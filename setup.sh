#!/usr/bin/env bash

set -e

echo "[+] Updating apt package lists..."
sudo apt update

# -------------------------------------------------------------------------------------- #

echo "[+] Installing dependencies"
if [ -f "dependencies.txt" ]; then
    grep -vE '^\s*#|^\s*$' dependencies.txt | xargs sudo apt install -y
else
    echo "[-] dependencies.txt not found!"
fi

# -------------------------------------------------------------------------------------- #

echo "[+] Initializing and updating tools"
git submodule update --init --recursive
git submodule update --remote --merge
unzip xato-net-10-million-passwords.zip

# -------------------------------------------------------------------------------------- #

echo "[+] Installing tools"

python3 -m pip install --user pipx
python3 -m pipx ensurepath

echo "[*] Installing aircrack-ng"
cd ./aircrack-ng/ && make install
cd ..
echo "[*] aircrack-ng suite installed"

echo "[*] Installing airgeddon and its plugins"
cp ./dragon-drain-wpa3-airgeddon-plugin/wpa3_dragon_drain.sh ./dragon-drain-wpa3-airgeddon-plugin/wpa3_dragon_drain_attack.py ./airgeddon/plugins
echo "[*] airgeddon installed"

echo "[*] Installing bully"
cd ./bully/src
sudo make install
cd ..
echo "[*] bully installed"

echo "[*] Installing eapeak"
python3 -m pipx install ./eapeak
echo "[*] eapeak installed"

echo "[*] Installing eaphammer"
cd ./eaphammer
bash kali-setup
echo "[*] eaphammer installed"

echo "[*] Installing ettercap"
cd ./ettercap && mkdir build && cd build
cmake ..
sudo make install
cd ../../
echo "[*] ettercap installed"

echo "[*] Installing fragattacks"
cd ./fragattacks/research
bash build.sh
bash pysetup.sh
cd ../..
echo "[*] fragattacks installed"

echo "[*] Installing hcxtools"
cd ./hcxtools
make -j $(nproc)
cd ..
echo "[*] hcxtools installed"

echo "[*] Installing hostapd-mana"
cd hostapd-mana
make -C hostapd
cd ..
echo "[*] hostapd-mana installed"

echo "[*] Installing krackattacks-scripts"
cd ./krackattacks-scripts/krackattack
bash build.sh
bash pysetup.sh
cd ../..
echo "[*] krackattacks-scripts installed"

echo "[*] Installing macchanger"
cd ./macchanger
sudo make install
cd ..
echo "[*] macchanger installed"

echo "[*] Installing mdk4"
cd ./mdk4
make
sudo make install
cd ..
echo "[*] mdk4 installed"

echo "[*] Installing pcapfix"
cd ./pcapfix
make
sudo make install
cd ..
echo "[*] pcapfix installed"

echo "[*] Installing reaver"
cd ./reaver-wps-fork-t6x/src
bash configure
make
sudo make install
cd ../..
echo "[*] reaver installed"

echo "[*] Installing wifiphisher"
python3 -m pipx install ./wifiphisher
echo "[*] wifiphisher installed"

echo "[*] Installing wifite2"
python3 -m pipx install ./wifite2
echo "[*] wifite2 installed"

echo "[*] Installing wpa_sycophant"
cd wpa_sycophant
make -C wpa_supplicant
echo "[*] wpa_sycophant installed"

echo "[+] Setup complete!"