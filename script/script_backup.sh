#!/bin/bash

get_time() {
    local start_time="$1"
    local now
    now=$(date +%s%3N)

    local diff_ms=$((now - start_time))
    local total_seconds=$((diff_ms / 1000))
    local miliseconds=$((diff_ms % 1000))

    local minutes=$((total_seconds / 60))
    local seconds=$((total_seconds % 60))
    
    if [ "$minutes" -gt 0 ]; then
        printf "%dm %02d.%03ds" "$minutes" "$seconds" "$miliseconds"
    else
        printf "%d.%03ds" "$seconds" "$miliseconds"
    fi
}

create_log() {
    local status="$1"
    local start_time="$2"
    local cur_dir="$3"
    local dir_test="$4"
   
    local duration
    duration=$(get_time "$start_time")

    local backup_date="$(date +%Y-%m-%d_%H-%M-%S)"
    local log_file="$dir_test/backup_log_opl.txt"     

    mkdir -p "$dir_test" 

    echo "[$backup_date] STATUS: $status | TIME: $duration | ORIGIN: $cur_dir" >> "$log_file"
}

main() {
    local cur_dir
    
    cur_dir=$(zenity --file-selection --directory --title="Select Origin Folder");[ -z "$cur_dir" ] && exit 1 

    local dir_test
    dir_test=$(zenity --file-selection --directory --title="Select Destination Folder");[ -z "$dir_test" ] && exit 1
    
    echo "Selected folder: $cur_dir to $dir_test"
    local start_time

    read -p "Let's start copying $cur_dir to $dir_test, alright? (Y/n) " response 

    if [[ "$response" != "Y" && "$response" != "y" ]] || [ -z "$response" ]; then 
        echo "Stop, go back and press 'Y'"
        exit 1
    fi

    echo 'Copying...' 
    start_time=$(date +%s%3N)

    if cp -r "$cur_dir"/* "$dir_test/"; then 
        create_log "SUCCESS" "$start_time" "$cur_dir" "$dir_test"

        echo "[+] Backup completed successfully"
        ls -la "$dir_test"
    else
        create_log "ERROR" "$start_time" "$cur_dir" "$dir_test"
        echo "[-] Error while copying"
    fi
}

main
