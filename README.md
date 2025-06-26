# Think Deeper - Recursive Claude Code Brainstorming agents

We can ask claude code to think about an initial idea and brainstorm about it, then come back with a conclusion.

This is not a coding agent, it is meant to think about 3 questions per layer. (first layer 3 questions, second layer 9 total, etc.)

# Usage

1. Write your idea in `PROJECT.md`. be sure to add `MAXIMUM_LAYER:3` at the top or the end of the file.
2. Run `claude`
3. Execute the prompt `/think_deeper`.

Claude will launch 3 tmux session per question
```
$ tmux list-sessions
L2_content: 1 windows (created Thu Jun 26 20:29:04 2025) (attached)
L2_mechanics: 1 windows (created Thu Jun 26 20:29:02 2025) (attached)
L2_technical: 1 windows (created Thu Jun 26 20:29:00 2025)
L3_cartoonish: 1 windows (created Thu Jun 26 20:29:37 2025)
L3_compatibility_analysis: 1 windows (created Thu Jun 26 20:29:29 2025)
L3_development_complexity: 1 windows (created Thu Jun 26 20:29:28 2025)
L3_education: 1 windows (created Thu Jun 26 20:29:40 2025)
L3_performance_analysis: 1 windows (created Thu Jun 26 20:29:26 2025)
L3_powerups: 1 windows (created Thu Jun 26 20:29:33 2025)
L3_progression: 1 windows (created Thu Jun 26 20:29:32 2025)
L3_reactions: 1 windows (created Thu Jun 26 20:29:39 2025)
L3_variety: 1 windows (created Thu Jun 26 20:29:35 2025)
```

while it is running... you can use `./attach.sh` (one per terminal) to attach to the next unattached terminal.

# Final output

Will be written in `main_conclusion.md`.



