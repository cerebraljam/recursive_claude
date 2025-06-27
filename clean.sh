#!/bin/bash

for i in $(tmux list-sessions| awk -F: '{print $1}'); do
    tmux kill-session -t "$i"
done

rm -Rf ./analysis/*
rm conclusion.md
rm QUESTIONS.md