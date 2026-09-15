#!/bin/bash

ok_zenity() {
    if command -v zenity >/dev/null 2>&1; then
        return 0
    fi

    echo "[-] The 'zenity' tool(GUI) was not found." >&2
    read -rp "[?] Would you like install it now to continue by Graphic Interface?(Y/n) " resp

    if [[ "$resp" =~ ^[Yy]$ ]] || [ -z "$resp" ]; then
        echo "[+] Installing zenity..."
        
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y zenity >&2
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y zenity >&2
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -S --noconfirm zenity >&2
        else
            echo "[-] Package Manager don't support it. Download 'zenity' manually." >&2
            return 1
        fi
    else
        echo "[!] Installation stopped by user." >&2
        return 1
    fi
}

select_folder() {
    local title="$1"
    
    if ok_zenity; then
        zenity --file-selection --directory --title="$title"
    else
        read -rp "$title (Type the absolute path): " dir_input
        echo "$dir_input"
    fi
}
