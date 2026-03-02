#!/bin/sh

CONFIG_DIR="/app/rmqtt/rmqtt-plugins"
DATA_DIR="/app/rmqtt/data"
JWT_DIR="$DATA_DIR/jwt"
CONFIG_FILE="/app/rmqtt/rmqtt.toml"

mkdir -p "$CONFIG_DIR"
mkdir -p "$JWT_DIR"

if [ -n "$JWT_PUBLIC_KEY_PEM" ]; then
    echo "$JWT_PUBLIC_KEY_PEM" > "$JWT_DIR/jwt_cert.pem"
    chmod 644 "$JWT_DIR/jwt_cert.pem"
fi

if [ -n "$RMQTT_ACL_CONFIG" ]; then
    echo "$RMQTT_ACL_CONFIG" > "$CONFIG_DIR/rmqtt-acl.toml"
fi

if [ -n "$RMQTT_JWT_CONFIG" ]; then
    echo "$RMQTT_JWT_CONFIG" > "$CONFIG_DIR/rmqtt-auth-jwt.toml"
fi

if [ -n "$RMQTT_CONFIG" ]; then
    echo "$RMQTT_CONFIG" > "$CONFIG_FILE"
fi

if [ -f "$CONFIG_FILE" ]; then
    sed -i 's/allow_anonymous = true/allow_anonymous = false/g' "$CONFIG_FILE"
fi

exec "$@"
