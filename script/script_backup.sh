#!/bin/bash

get_time() {
    local start_time="$1"
    local now
    now=$(date +%s%3N)

    local diff_ms=$((now - start_time))
    local seconds=$((diff_ms / 1000))
    local miliseconds=$((diff_ms % 1000))
    
    : '
    %d.03ds:Print the integer, a dot, and the suffix padded (max) to 3 characters
    seconds -> %d 
    miliseconds -> %03ds'

    printf "%d.%03ds" "$seconds" "$miliseconds"
}

create_log() {

    local status="$1"
    local start_time="$2"
    local cur_dir="$3"
    local dir_test="$4"
   
    local duration 
    local duration=$(get_time "$start_time")


    local backup_date="$(date +%Y-%m-%d_%H-%M-%S)"
    local log_file="$dir_test/backup_log_opl.txt"     
    

    mkdir -p "$dir_test" 

    echo "[$backup_date] STATUS: $status | TIME: $duration | ORIGIN: $cur_dir" >> "$log_file"

}

main() {

    local cur_dir="$PWD"
    local dir_test="$HOME/backup_opl"
    local start_time

    read -p "Let's start copying $cur_dir to $dir_test, alright? (Y/n) " response 

    if [[ "$response" != "Y" && "$response" != "y" ]] || [ -z "$response" ]; then
        echo "Stop, go back and press 'Y'"
        exit 1
    fi
        echo 'Copying...' 
        start_time=$(date +%s%3N)

        if cp -r "$cur_dir"/* "$dir_test/"; then 
            
            create_log "SUCESS" "$start_time" "$cur_dir" "$dir_test"

            echo "[+] Backup caompleted sucessfull"
            ls -la "$dir_test"
        
        else
            echo "[-] Error while copying"
    fi
}

main

