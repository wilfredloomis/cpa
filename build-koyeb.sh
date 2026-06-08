#!/bin/bash
set -e
echo "=== CPA Koyeb Image Builder ==="

TOKEN_DIR="/storage/emulated/0/AAAAAAAAAA/cpa"
CPA_DIR="/storage/emulated/0/AAAAAAAAAA/cpa-proxy/CPA-main"
TOKENS_OUT="$CPA_DIR/cpa-tokens"

rm -rf "$TOKENS_OUT"
mkdir -p "$TOKENS_OUT"

echo "Copying tokens..."
cp "$TOKEN_DIR"/*.json "$TOKENS_OUT/" 2>/dev/null || true

COUNT=$(ls "$TOKENS_OUT"/*.json 2>/dev/null | wc -l)
echo "Copied $COUNT token files"

cd "$CPA_DIR"
echo "Building Docker image..."
docker build -f Dockerfile.koyeb -t cpa-koyeb .

echo "=== Done ==="
echo "Push with: docker tag cpa-koyeb <your-registry>/cpa:latest && docker push <your-registry>/cpa:latest"
# For Koyeb free tier, the easiest way is:
# echo "Or push to a public Docker Hub repo"
