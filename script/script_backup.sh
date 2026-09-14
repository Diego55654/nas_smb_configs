#!/bin/bash


create_log() {
    local status="$1"
    local duracao="$2"
    local cur_dir="$3"
    local dir_test="$4"
    local backup_date="$(date +%Y-%m-%d_%H-%M-%S)"
    local log_file="$dir_test/backup_log_opl.txt"     

    mkdir -p "$dir_test"
    

}

main() {

    local cur_dir="$PWD"
    local dir_test=""


    read -p "Let's start copying $cur_dir to $dir_test, alright? (Y/n) " response 

    if [[ "$response" != "Y" && "$response" != "y" ]] || [ -z "$response" ]; then
        echo "Stop, go back and press 'Y'"
        exit 1
    else
        echo 'Copying...'
        
        if cp -r "$cur_dir"/* "$dir_test/"; then 
            echo "[+] Backup caompleted sucessfull"
            ls -la "$dir_test"
        
        else
            echo "[-] Error while copying"
        fi
    fi
}

main

