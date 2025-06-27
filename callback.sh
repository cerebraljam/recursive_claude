#!/bin/bash

MESSAGE=$1

if [ -z ${PREV_SESSION_NAME} ]; then
  echo "Completed"
  exit 0
fi

if [ -z "$MESSAGE" ]; then
    MESSAGE="${SESSION_NAME} is done"
fi

echo "Signalling $PREV_SESSION_NAME with message: $MESSAGE"
tmux send-keys -t $PREV_SESSION_NAME "$MESSAGE"
sleep 1; tmux send-keys -t $PREV_SESSION_NAME Enter