#!/bin/bash

SPUG_DIR="/data"
SPUG_API_DIR="/data/spug_api"

echo "Waiting for database connection..."
sleep 5

if [ -f "$SPUG_DIR/.initialized" ]; then
    echo "Spug already initialized, skipping..."
else
    echo "Initializing Spug database..."
    cd $SPUG_API_DIR
    
    if [ -n "$SPUG_ADMIN_USER" ] && [ -n "$SPUG_ADMIN_PASSWORD" ]; then
        echo "Creating admin user: $SPUG_ADMIN_USER"
        python manage.py initdb
        python manage.py useradd -u $SPUG_ADMIN_USER -p $SPUG_ADMIN_PASSWORD -s -n "管理员"
        touch $SPUG_DIR/.initialized
        echo "Spug initialization completed!"
    else
        echo "Warning: SPUG_ADMIN_USER or SPUG_ADMIN_PASSWORD not set"
        echo "Please run manually: docker exec <container> init_spug <user> <password>"
    fi
fi

exec "$@"
