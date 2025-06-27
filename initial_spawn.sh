#!/bin/bash

SESSION_NAME=$1

# if SESSION_NAME, FEATURE or PROMPT is not provided, display usage, then exit
if [ -z "$SESSION_NAME" ]; then
    SESSION_NAME="L0-initial"
fi

ENV_VARS="-e COUNTER=0 -e SESSION_NAME=\"$SESSION_NAME\""
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

mkdir -p analysis

echo "Starting session '${SESSION_NAME}'"

eval "tmux new-session -s \"$SESSION_NAME\" $ENV_VARS \"claude config set hasTrustDialogAccepted true && claude --allowedTools 'Edit,Write,Bash,Replace,Read,Glob,Grep,LS,MultiEdit'\""