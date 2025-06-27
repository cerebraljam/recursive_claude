# Think Deeper - Recursive Claude Code Brainstorming agents

We can ask claude code to think about an initial idea and brainstorm about it, then come back with a conclusion.

This is not a coding agent, it is meant to think about 3 questions per layer. (first layer 3 questions, second layer 9 total, then 27, etc.)

# Usage

1. Write your idea in `PROJECT.md`. be sure to add `MAXIMUM_LAYER:3` at the top or the end of the file.
2. Start the initial tmux session using `bash initial_spawn.sh`. This will allow sub-sessions to signal back when they are done by writing a new prompt by themselves, triggering claude to continue.
3. Execute the prompt `/think_deeper`.

Claude will launch 3 tmux session per question. and will signal the parent session when they are done.
```
$ tmux list-sessions
L0-initial: 1 windows (created Fri Jun 27 07:56:56 2025) (attached)
L2_behavior_mechanics: 1 windows (created Fri Jun 27 07:58:54 2025)
L2_game_progression: 1 windows (created Fri Jun 27 07:58:56 2025)
L2_technology_stack: 1 windows (created Fri Jun 27 07:58:55 2025)
browser_compatibility: 1 windows (created Fri Jun 27 07:59:30 2025)
development_complexity: 1 windows (created Fri Jun 27 07:59:23 2025)
difficulty_balance: 1 windows (created Fri Jun 27 07:59:19 2025)
level_difficulty: 1 windows (created Fri Jun 27 07:59:19 2025)
performance_rendering: 1 windows (created Fri Jun 27 07:59:15 2025)
player_engagement: 1 windows (created Fri Jun 27 07:59:22 2025)
powerup_mechanics: 1 windows (created Fri Jun 27 07:59:21 2025)
scoring_rewards: 1 windows (created Fri Jun 27 07:59:23 2025)
technical_implementation: 1 windows (created Fri Jun 27 07:59:24 2025)
```

while it is running... you can use `./attach.sh` (one per terminal) to attach to the next unattached terminal.

# Final output

Will be written in `conclusion.md`.



