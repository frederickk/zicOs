#!/bin/sh
# Bluetooth pairing and connection helper script

show_help() {
    echo "Bluetooth Audio Helper"
    echo "Usage: $0 [scan|pair|connect|disconnect|list|info]"
    echo ""
    echo "Commands:"
    echo "  scan       - Scan for available Bluetooth devices"
    echo "  pair MAC   - Pair with a device (e.g., pair AA:BB:CC:DD:EE:FF)"
    echo "  connect MAC- Connect to a paired device"
    echo "  disconnect - Disconnect current device"
    echo "  list       - List paired devices"
    echo "  info       - Show current Bluetooth status"
    echo "  remove MAC - Remove a paired device"
}

case "$1" in
    scan)
        echo "Scanning for Bluetooth devices (15 seconds)..."
        bluetoothctl --timeout 15 scan on
        ;;
    pair)
        if [ -z "$2" ]; then
            echo "Error: MAC address required"
            echo "Usage: $0 pair AA:BB:CC:DD:EE:FF"
            exit 1
        fi
        echo "Pairing with $2..."
        bluetoothctl pair "$2"
        bluetoothctl trust "$2"
        ;;
    connect)
        if [ -z "$2" ]; then
            echo "Error: MAC address required"
            echo "Usage: $0 connect AA:BB:CC:DD:EE:FF"
            exit 1
        fi
        echo "Connecting to $2..."
        bluetoothctl connect "$2"
        ;;
    disconnect)
        if [ -z "$2" ]; then
            echo "Error: MAC address required"
            echo "Usage: $0 disconnect AA:BB:CC:DD:EE:FF"
            exit 1
        fi
        echo "Disconnecting from $2..."
        bluetoothctl disconnect "$2"
        ;;
    list)
        echo "Paired devices:"
        bluetoothctl paired-devices
        ;;
    info)
        echo "Bluetooth status:"
        bluetoothctl show
        echo ""
        echo "Connected devices:"
        bluetoothctl devices Connected
        ;;
    remove)
        if [ -z "$2" ]; then
            echo "Error: MAC address required"
            echo "Usage: $0 remove AA:BB:CC:DD:EE:FF"
            exit 1
        fi
        echo "Removing device $2..."
        bluetoothctl remove "$2"
        ;;
    *)
        show_help
        exit 1
        ;;
esac

exit 0
