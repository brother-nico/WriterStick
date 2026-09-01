#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Starting WriterStick Setup Script"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# Safety check: don't run the whole script as root.
# $HOME needs to point at the real user's home directory for the autostart file, so this must run as a normal user, with sudo prompting per the command below. 
# If invoked as `sudo bash script.sh`, $HOME becomes /root and the autostart file ends up somewhere the desktop session won't look.
if [ "$(id -u)" -eq 0 ] && [ -z "$SUDO_USER" ]; then
    echo "Error: please run this script as your normal user (it will call"
    echo "sudo itself when needed), e.g.:"
    echo "    bash $0"
    echo "Do not run it with 'sudo bash $0'."
    exit 1
fi

# Resolve the target username dynamically instead of assuming 'pi'. (Mostly because Pi OS setup now requires you to set up username and PW.)
# Works whether the script is run directly or via sudo. (Unfortunately.)
TARGET_USER="${SUDO_USER:-$(whoami)}"
echo "--> Configuring for user: $TARGET_USER"

# 1. Update system packages
echo "--> Updating system package lists..."
sudo apt update

# 2. Install FocusWriter
echo "--> Installing FocusWriter..."
sudo apt install -y focuswriter

# 3. Enable Auto-Login (Skip login prompt on boot)
# Uses raspi-config's own non-interactive interface instead of hand-editing lightdm.conf which is apparently very inappropriate.
# This is the officially supported path and SHOULD stay correct across Raspberry Pi OS versions.
echo "--> Configuring desktop auto-login for $TARGET_USER..."
if command -v raspi-config >/dev/null 2>&1; then
    # B4 = Desktop Autologin, for the current/target user
    sudo raspi-config nonint do_boot_behaviour B4
else
    echo "Warning: raspi-config not found. This doesn't look like a"
    echo "standard Raspberry Pi OS install — set up auto-login manually."
fi

# 4. Configure FocusWriter auto-startup
echo "--> Setting up FocusWriter autostart..."
AUTOSTART_DIR="$HOME/.config/autostart"
mkdir -p "$AUTOSTART_DIR"
cat << 'EOF' > "$AUTOSTART_DIR/focuswriter.desktop"
[Desktop Entry]
Type=Application
Name=FocusWriter
Exec=focuswriter
X-GNOME-Autostart-enabled=true
EOF

# That stupid EOF at line 49 wasn't in quotes and was driving me crazy until I noticed it.

# 5. Fix permissions for the autostart file. (Keep your station clean, or I WILL KILL YOU.)
chmod +x "$AUTOSTART_DIR/focuswriter.desktop"

echo "=========================================="
echo " Setup Complete!"
echo ""
echo " One more manual step: open FocusWriter once, enable fullscreen"
echo " distraction-free mode (F11), and close it. FocusWriter remembers"
echo " its last window state, so the autostarted launch will come up"
echo " fullscreen too."
echo ""
echo " Then reboot to test auto-login + autostart:"
echo "     sudo reboot"
echo "=========================================="
