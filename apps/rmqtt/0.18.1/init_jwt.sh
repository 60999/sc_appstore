#!/bin/sh

JWT_PLUGIN_DIR="/app/rmqtt/rmqtt-plugins"
JWT_CONFIG_FILE="$JWT_PLUGIN_DIR/rmqtt-auth-jwt.toml"
JWT_KEY_DIR="/app/rmqtt/data/jwt"
JWT_KEY_FILE="$JWT_KEY_DIR/public_key.pem"

mkdir -p "$JWT_KEY_DIR"

if [ "$JWT_AUTH_ENABLED" = "true" ]; then
    if [ -n "$JWT_PUBLIC_KEY_PEM" ]; then
        echo "$JWT_PUBLIC_KEY_PEM" > "$JWT_KEY_FILE"
    fi
    
    cat > "$JWT_CONFIG_FILE" << EOF
## JWT Auth Plugin Configuration

## Enable JWT authentication
jwt_enable = true

## JWT public key file path (PEM format)
jwt_public_key = "$JWT_KEY_FILE"

## JWT from field: password or username
jwt_from = "${JWT_FROM:-password}"

## Disconnect client if JWT expired
jwt_disconnect_if_expiry = ${JWT_DISCONNECT_IF_EXPIRY:-true}

## JWT issuer (optional)
EOF

    if [ -n "$JWT_ISSUER" ]; then
        echo "jwt_issuer = \"$JWT_ISSUER\"" >> "$JWT_CONFIG_FILE"
    else
        echo "# jwt_issuer = \"\"" >> "$JWT_CONFIG_FILE"
    fi

    if [ -n "$JWT_CLAIMS_CONFIG" ]; then
        echo "" >> "$JWT_CONFIG_FILE"
        echo "$JWT_CLAIMS_CONFIG" >> "$JWT_CONFIG_FILE"
    fi
fi

exec "$@"
