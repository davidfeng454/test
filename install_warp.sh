#!/bin/bash
set -e

# 检查变量是否存在
: "${WARP_AUTH_CLIENT_ID:?Missing WARP_AUTH_CLIENT_ID}"
: "${WARP_AUTH_CLIENT_SECRET:?Missing WARP_AUTH_CLIENT_SECRET}"
: "${WARP_ORGANIZATION:?Missing WARP_ORGANIZATION}"

function warp() {
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg \
        | sudo gpg --yes --dearmor \
        --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
        | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

    sudo apt-get update -y
    sudo apt-get install -y cloudflare-warp
}

function mdm() {
    sudo mkdir -p /var/lib/cloudflare-warp

    sudo tee /var/lib/cloudflare-warp/mdm.xml >/dev/null <<EOF
<dict>
    <key>auth_client_id</key>
    <string>${WARP_AUTH_CLIENT_ID}</string>

    <key>auth_client_secret</key>
    <string>${WARP_AUTH_CLIENT_SECRET}</string>

    <key>auto_connect</key>
    <integer>1</integer>

    <key>onboarding</key>
    <false/>

    <key>organization</key>
    <string>${WARP_ORGANIZATION}</string>

    <key>service_mode</key>
    <string>warp</string>
</dict>
EOF
}

warp
mdm