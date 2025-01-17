#!/bin/sh
# Work session
tmux new -s work -d

# Serve window
tmux rename-window -t work serve
tmux send-keys -t work 'cd ~/git/Cirrus/frontend' C-m

# Cmds window
tmux new-window -t work
tmux rename-window -t work cmds
tmux send-keys -t work 'cd ~/git/Cirrus/' C-m

# Main editor windows
tmux new-window -t work
tmux rename-window -t work FE
tmux send-keys -t work 'cd ~/git/Cirrus/frontend' C-m
tmux send-keys -t work 'nvim' C-m

tmux new-window -t work
tmux rename-window -t work BE
tmux send-keys -t work 'cd ~/git/Cirrus/backend' C-m
tmux send-keys -t work 'nvim' C-m

# Config session
tmux new -s config -d

# dotfiles window
tmux new-window -t config
tmux rename-window -t config dotfiles
tmux send-keys -t config 'cd ~/dotfiles/' C-m
tmux send-keys -t config 'nvim' C-m

tmux select-window -t work:1
tmux attach -t work
