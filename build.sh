#!/usr/bin/env bash
# Build script for Hugo on Cloudflare Workers

main() {
    HUGO_VERSION="0.152.2"
    export TZ=Europe/Helsinki

    echo "Installing Hugo v${HUGO_VERSION}"
    curl -LJO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
    tar -xf "hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
    cp hugo /opt/buildhome/
    rm LICENSE README.md "hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
    export PATH="/opt/buildhome:$PATH"

    echo "Verifying installations"
    echo "Hugo: $(hugo version)"
    echo "Node.js: $(node --version || echo 'Not available')"
    echo "Go: $(go version || echo 'Not available')"

    echo "Cloning Blowfish"
    git submodule update --init --recursive
    git config core.quotepath false

    echo "Building Hugo"
    hugo --gc --minify

    echo "Build completed successfully!"
}

set -euo pipefail
main "$@"
