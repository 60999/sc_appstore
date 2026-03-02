#!/bin/sh

CONFIG_DIR="/app/rmqtt/rmqtt-plugins"
DATA_DIR="/app/rmqtt/data"
JWT_DIR="$DATA_DIR/jwt"

mkdir -p "$CONFIG_DIR"
mkdir -p "$JWT_DIR"

echo "$RMQTT_CONFIG" > "/app/rmqtt/rmqtt.toml"

echo "$RMQTT_ACL_CONFIG" > "$CONFIG_DIR/rmqtt-acl.toml"

echo "$RMQTT_JWT_CONFIG" > "$CONFIG_DIR/rmqtt-auth-jwt.toml"

if [ -n "$JWT_PUBLIC_KEY_PEM" ]; then
    echo "$JWT_PUBLIC_KEY_PEM" > "$JWT_DIR/jwt_cert.pem"
    chmod 644 "$JWT_DIR/jwt_cert.pem"
fi

exec "$@"
