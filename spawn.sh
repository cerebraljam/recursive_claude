#!/bin/bash

PREV_SESSION_NAME=${SESSION_NAME}
SESSION_NAME=$1
PROMPT=$2

COUNTER=$(($COUNTER + 1))

if [ $COUNTER -gt 5 ]; then
    echo "Layer is greater than 5. Exiting..."
    bash ./callback.sh "Maximum number of layers exhausted. ${SESSION_NAME} was aborted"
    exit 1
fi

mkdir -p ./analysis

# if SESSION_NAME, FEATURE or PROMPT is not provided, display usage, then exit
if [ -z "$SESSION_NAME" ]  || [ -z "$PROMPT" ]; then
    echo "Usage: $0 SESSION_NAME PROMPT"
    exit 1
fi

ENV_VARS="-e SESSION_NAME=${SESSION_NAME} -e PREV_SESSION_NAME=${PREV_SESSION_NAME} -e COUNTER=${COUNTER}"
echo "Starting session '${SESSION_NAME}' (Layer ${COUNTER})"
echo "ENV_VARS: ${ENV_VARS}"
echo "Prompt: ${PROMPT}"

# Pass through all environment variables dynamically to tmux session
tmux new-session -d -s "$SESSION_NAME" $ENV_VARS "claude config set hasTrustDialogAccepted true && claude '$PROMPT' --allowedTools 'Edit,Write,Bash,Replace,Read,Glob,Grep,LS,MultiEdit'"

echo "started"