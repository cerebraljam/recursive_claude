#!/bin/bash

SESSION_NAME=$1
PROMPT=$2

mkdir -p ./questions

# if SESSION_NAME, FEATURE or PROMPT is not provided, display usage, then exit
if [ -z "$SESSION_NAME" ] || [ -z "$PROMPT" ]; then
    echo "Usage: $0 SESSION_NAME PROMPT"
    exit 1
fi

# Load environment variables from .env file if it exists
ENV_VARS=""
for envfile in .env .env.claude; do
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
            ENV_VARS="$ENV_VARS -e $VAR_NAME=\"\${$VAR_NAME}\""
        done < ${envfile}
    fi
done

echo "Starting session '${SESSION_NAME}'"

# Pass through all environment variables dynamically to tmux session
eval "tmux new-session -d -s \"$SESSION_NAME\" $ENV_VARS \"claude config set hasTrustDialogAccepted true && claude '$PROMPT' --allowedTools 'Edit,Write,Bash,Replace,Read,Glob,Grep,LS,MultiEdit'\""