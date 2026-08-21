FROM ubuntu:latest

# Pull Keyring
ADD https://repository.mullvad.net/deb/mullvad-keyring.asc /usr/share/keyrings/mullvad-keyring.asc

RUN <<EOF
set -ex
# Install Prereqs
apt-get update
apt-get install -y ca-certificates

# Add Repo
chmod 777 /usr/share/keyrings/mullvad-keyring.asc
cat <<REPO > /etc/apt/sources.list.d/mullvad.list
deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=amd64] https://repository.mullvad.net/deb/stable stable main
REPO

# Install the package
apt-get update
apt-get install -y mullvad-vpn nftables
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF
