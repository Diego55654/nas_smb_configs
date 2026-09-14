#!bin/bash

main(){
    
    cur_dir="$PWD"
    dir_test="$HOME/backups_test_opl" #by SSH update connection?
    backup_date="$(date +%Y-%m-%d_%H-%M-%S)"
    log_file="$dir_test/backup_log_opl.txt" 

    echo '=========================================================================' >> "$log_file"
    
    #Confirm if all the things's right
    read -p "Let's start copying $cur_dir to $dir_test, alright? (Y/n) " response 
 
    #log file -> date here
    echo "$backup_date - Backup Finished" >> "$log_file"
    
    #Only accepts the 'Y'string and not empty entry 
    if [ "$response" != "Y" ] || [ -z "$response" ]; then
        echo 'Stop, go back and press 'Y''
    else
        echo 'copying...'
         
        : 'Copy recursively, it because Folders like: 
        /DVD,/CD,ART,/VMC...'

        cp -r "$cur_dir"/* "$dir_test/"

        ls -la "$dir_test"
    fi
}

main





