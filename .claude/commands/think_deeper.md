LAYER:0
NEXT_LAYER=LAYER+1

You are a brainstorming expert. Read the 'PROJECT.md' file to understand what is the original idea. If the 'QUESTIONS.md' file exists, read it.

From the description of the idea, think about the project, how you would approach it then think about 3 questions that have not been asked already that you would need clarifications to. These could be possible paths taken, these can also be opposing.

Once you identified these 3 questions:

- Create or update QUESTIONS.md and add your 3 questions with the format: 'Q. This is my question'
- If {LAYER} < MAXIMUM_LAYER:

  - For each of your 3 questions, create a prompt:
    - Make up a NEW_SESSION_NAME that can be used in a filename you want the output to be saved into.
    - Your NEW_PROMPT must be like this. when passed in parameter to spawn.sh, variables will be resolved: 'LAYER=$((COUNTER+1)) of MAXIMUM_LAYER. SUB_LAYER=$((COUNTER+2)).\n\n You are in a brainstorming session.\n ALWAYS run \'bash callback.sh\' to signal that you are done.\n If LAYER < MAXIMUM_LAYER, read PROJECT.md, think about the project, think how you would approach the following question: \'ONE QUESTION HERE\', then think about 3 more SUB_QUESTIONS. spawn one sub-session per question using 'bash spawn.sh L{NEXT_LAYER}_{SUB_QUESTION} \"{NEW_PROMPT}\"', one per question you have.\n- then you can stop at this point to wait for callbacks.\n When you have seen all the callbacks through prompts telling you that all of your sub-questions have completed, check the sub-sessions you started using tmux to confirm they are completed. For sub-sessions that completed successfully, read conclusions they saved in ./analysis/. The relevant files will start with 'L{SUB_LAYER}_', then incorporate the conclusions and significant points.\n- If you are prompted that a session is exhausted, kill that session and do not incorporate it.\n\- Write your final analysis to ./analysis/L{LAYER}_{NEW_SESSION_NAME}.\n- Stop the tmux sub-sessions you started if you did.\n- ALWAYS run 'bash callback.sh' to signal your parrent session that you are done.'
  - RUN 'bash spawn.sh \"L{NEXT_LAYER}_${NEW_SESSION_NAME}\" \"{PROMPT}\" 2>&1 >> ./debug.log' for each of the questions you have.
  - Then you can stop at this point to wait for callbacks.
  - When you have been prompted that all of your sub-questions are completed, check the sub-sessions you started using tmux, and read conclusions in ./analysis/ that starts with 'L{NEXT_LAYER}_'.
  - If you are prompted that a session is exhausted, kill that session and do not incorporate it.
  - For sub-sessions that completed successfully, incorporate the ideas. Consider each opposing paths if there are any, and select the one that is the most faithful with the idea of the project.
  - Stop the tmux sub-sessions you started using 'tmux kill-session -t session_name'.

- Write your conclusions from these sessions into 'conclusion.md'.
- As the initial spawner, you don't have to callback to signal that you are done. You should however check that all tmux sessions, except 'L0-initial' were killed.

The content of 'conclusion.md' should present the final solution with its conclusion. A positive or negative conclusion is acceptable.
