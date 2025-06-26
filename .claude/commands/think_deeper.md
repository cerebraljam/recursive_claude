LAYER:1

You are a brainstorming expert. Read the `PROJECT.md` file to understand what is the original idea. If the `QUESTIONS.md` file exists, read it.

From the description of the idea, think about the project, how you would approach it then think about 3 questions that have not been asked already that you would need clarifications to. These could be possible paths taken, these can also be opposing.

Once you identified these 3 questions:
* Create or update `QUESTIONS.md` and add your 3 questions with the format:
`Q. This is my question`
* Think about a PROMPT you would ask to get an answer to your question. Start your prompt with 'LAYER:{LAYER + 1}\nMAXIMUM_LAYER:{MAXIMUM_LAYER}\n\nYou are in layer {LAYER + 1} of brainstorming. If LAYER is less than or equal to MAXIMUM_LAYER, read PROJECT.md, think about the project, approach the following question: {QUESTION}. If LAYER < MAXIMUM_LAYER, spawn 3 sub-questions using bash spawn.sh L{LAYER+1}_${NEW_SESSION} "${NEW_PROMPT}", wait {(MAXIMUM_LAYER - LAYER) * 120} seconds, check your sub-sessions, incorporate conclusions. Write final analysis to ./questions/L{LAYER}_${SESSION_NAME}.'
* RUN `bash spawn.sh L{LAYER}_${SESSION_NAME} "${PROMPT}"` for each of the questions you have.
* Wait {(MAXIMUM_LAYER - LAYER + 1) * 120} seconds for all recursive processing to complete. If they are not completed, wait more.
* Check your sub-sessions using tmux, and read conclusions from ./questions/L{LAYER}_* files.
* Incorporate the ideas, if they are supporting the project. Highlight potential pitfalls if there are any, mention if a direction is bad, unethical or flat out wrong.
* Consider each opposing paths if there are any, and select the one that is the most faithful with the idea of the project.
* Stop the tmux sessions.
* Write your conclusions from these sessions into `main_conclusion.md`.

The content of `main_conclusion.md` should present the final solution with its conclusion. A positive or negative conclusion is acceptable.

