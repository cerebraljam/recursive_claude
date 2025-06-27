#!/bin/bash

PREV_SESSION_NAME=${SESSION_NAME}
SESSION_NAME=$1
PROMPT=$2

COUNTER=$((COUNTER + 1))

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

ENV_VARS="-e SESSION_NAME=$SESSION_NAME -e PREV_SESSION_NAME=$PREV_SESSION_NAME -e COUNTER=$COUNTER"
ALL_VAR_NAMES=""
for envfile in '.env' '.env.claude'; do
    if [ -f ${envfile} ]; then
        echo "Loading environment variables from .env file..."
        # Read ${envfile} file, skip comments and empty lines, export variables
        while IFS= read -r line || [ -n "$line" ]; do
            # Skip comments and empty lines
            if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "${line// }" ]]; then
                continue
            fi
            # Export the variable
            export "$line"
            # Build tmux -e arguments dynamically
            VAR_NAME=$(echo "$line" | cut -d'=' -f1)
            VAR_VALUE=$(echo "$line" | cut -d'=' -f2-)
            ENV_VARS="$ENV_VARS -e $VAR_NAME='$VAR_VALUE'"
            ALL_VAR_NAMES="$ALL_VAR_NAMES $VAR_NAME"
        done < ${envfile}
    fi
done

echo "Starting session '${SESSION_NAME}' (Layer ${COUNTER})"
echo "Prompt: ${PROMPT}"

# Create a new tmux session - use detach to avoid conflict with current session  
# Replace the tmux command with:
TMUX= tmux new-session -d -s "$SESSION_NAME" $ENV_VARS sh -c "
source .env.claude 2>/dev/null || true
export $ALL_VAR_NAMES SESSION_NAME PREV_SESSION_NAME COUNTER
claude config set hasTrustDialogAccepted true
claude \"$PROMPT\" --allowedTools 'Edit,Write,Bash,Replace,Read,Glob,Grep,LS,MultiEdit'
"

echo "* started\n"