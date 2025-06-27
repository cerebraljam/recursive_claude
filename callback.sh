#!/bin/bash

MESSAGE=$1

if [ -z ${PREV_SESSION_NAME} ]; then
  echo "Completed"
  exit 0
fi

if [ -z "$MESSAGE_NAME" ]; then
    message="${SESSION_NAME} is done"
fi

echo Signalling 
tmux send-keys -t $PREV_SESSION_NAME "$message"
tmux send-keys -t $PREV_SESSION_NAME Enter