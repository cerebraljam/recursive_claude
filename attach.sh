#!/bin/bash

nb_tmux=$(tmux list-sessions|grep -v "L0-initial" | wc -l)
nb_running_attach=$(ps -ef | grep "tmux attach" | grep -v grep |grep -v "L0-initial" | wc -l)

if [ ${nb_running_attach} -lt ${nb_tmux} ]; then
    next_session=$(tmux list-sessions | grep -v "L0-initial" | head -n $((nb_running_attach + 1)) | tail -n 1 | cut -f1 -d':')
    tmux attach -t $next_session
fi
