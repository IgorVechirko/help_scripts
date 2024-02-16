screen -dmS session_name - create session
screen -S session_name -X screen -t widnow_title - create new window in sesison
screen -S session_name -p 1 -X stuff "date^M" - for window num (-p 1) paste the string (date) in to terminal and (^M) for enter it

screen -c conf_file

############ screenrc sample ############
screen -t service

#comands apply to last created window
#stuff command doesn't append to executing termial and executing one by one so if you need some delay here I don't know how to perform it
stuff "sudo su -p root^M"
stuff "cd /opt/starwind/starwind-nvmf-target/^M"
stuff "systemctl stop starwind-nvmf-target^M"

screen -t log
stuff "sudo su -p root^M"
stuff "cd /var/log/starwind/starwind-nvmf-target/^M"

screen -t worker
stuff "sudo su -p root^M"
