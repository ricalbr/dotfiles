#!/bin/sh
set -eu

BIN_DIR="$HOME/.local/bin"
PYZ="$BIN_DIR/virtualenv.pyz"
WRAPPER="$BIN_DIR/virtualenv"
URL="https://bootstrap.pypa.io/virtualenv.pyz"

echo ">> Installing virtualenv (user-local, no pip)"

# ensure bin dir exists
mkdir -p "$BIN_DIR"

# download pyz
echo ">> Downloading virtualenv.pyz"
curl -fsSL "$URL" -o "$PYZ"

# create wrapper
echo ">> Creating wrapper"
cat > "$WRAPPER" << 'EOF'
#!/bin/sh
exec python3 "$HOME/.local/bin/virtualenv.pyz" "$@"
EOF

chmod +x "$WRAPPER"

echo ">> Done."
echo ">> Test with: virtualenv --version"

