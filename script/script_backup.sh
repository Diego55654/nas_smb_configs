#!bin/bash

main(){

	local cur_dir= $(pwd)
	local dir_dest="/home/user/docs"
    local backup_date = "$(date +%Y-%m-%d_%H-%M-%S)"
    local log_file = "$dir_dest/backup_log_opl.txt" 

	echo '$cur_dir'
	echo '$destinatio_dir'
}
main





