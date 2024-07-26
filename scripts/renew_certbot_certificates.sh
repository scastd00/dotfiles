#!/bin/bash

stop_nextcloud() {
    echo "Stopping Nextcloud..."
    sudo snap stop nextcloud
}

renew_certificates() {
    echo "Renewing certificates..."
    sudo certbot renew
}

start_nextcloud() {
    echo "Starting Nextcloud..."
    sudo snap start nextcloud
}

main() {
    stop_nextcloud
    renew_certificates
    start_nextcloud
}

main "$@"
