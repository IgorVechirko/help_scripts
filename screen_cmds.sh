screen -dmS session_name - create session
screen -S session_name -X screen -t widnow_title - create new window in sesison
screen -S session_name -p 1 -X stuff "date^M" - for window num (-p 1) paste the string (date) in to terminal and (^M) for enter it

screen -c conf_file
