LAYER:1

You are a brainstorming expert. Read the `PROJECT.md` file to understand what is the original idea. If the `QUESTIONS.md` file exists, read it.

From the description of the idea, think about the project, how you would approach it then think about 3 questions that have not been asked already that you would need clarifications to. These could be possible paths taken, these can also be opposing.

PREV_SESSION_NAME=L0-initial

Once you identified these 3 questions:
* Create or update `QUESTIONS.md` and add your 3 questions with the format: `Q. This is my question`
* If LAYER < MAXIMUM_LAYER:
    * For each question, create a prompt starting with 'LAYER:{LAYER}\nMAXIMUM_LAYER:{MAXIMUM_LAYER}\n\nYou are in layer {LAYER} of brainstorming.\nYour session name is (SESSION_NAME) and the previous session name is (PREV_SESSION_NAME).\nALWAYS run 'bash callback.sh' to signal that you are done.\nIf LAYER is less than or equal to MAXIMUM_LAYER, read PROJECT.md, think about the project, approach the following question: {QUESTION}.\nIf LAYER < MAXIMUM_LAYER\n* spawn 3 sub-questions using 'bash spawn.sh L{LAYER+1}_{NEW_SESSION} "{NEW_PROMPT}"' (don't forget the L(LAYER+1) prefix to properly label the analysis files)\n* then you can stop at this point to wait for callbacks.\nWhen you have been prompted that all of your sub-questions have completed, check the sub-sessions you started using tmux, and read conclusions from ./analysis/L(LAYER+1)_* files.\n* If you are prompted that a session is exhausted, kill that session and do not incoporate it.\nFor sub-sessions that completed successfully, incorporate conclusions.\n* Write your final analysis to ./analysis/L{LAYER}_{SESSION_NAME}.\n* Stop the tmux sub-sessions you started if you did.\n* ALWAYS run 'bash callback.sh' to signal that you are done.'
    * RUN `bash spawn.sh L{LAYER+1}_${SESSION_NAME} "{PROMPT}" 2>&1 >> ./debug.log` for each of the questions you have.
    * Then you can stop at this point and wait for callbacks.
    * When you have been prompted that all of your sub-questions are completed, check the sub-sessions you started using tmux, and read conclusions from ./analysis/L{LAYER+1}_* files.
    * If you are prompted that a session is exhausted, kill that session and do not incoporate it.
    * For sub-sessions that completed successfully, incorporate the ideas. Consider each opposing paths if there are any, and select the one that is the most faithful with the idea of the project.
    * Stop the tmux sub-sessions you started.
* Write your conclusions from these sessions into `main_conclusion.md`.
* As the initial spawner, you don't have to callback to signal that you are done.

The content of `main_conclusion.md` should present the final solution with its conclusion. A positive or negative conclusion is acceptable.

