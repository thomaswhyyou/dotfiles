# Set up a default session called 'asdf'.

tmux has-session -t asdf
if [[ $? != 0 ]]; then
    # Make sure we detach first if we are already inside tmux.
    if [[ "$TERM" == "screen-256color" ]]; then
        tmux detach
    fi

    tmux set -g base-index 1
    tmux setw -g pane-base-index 1

    # Create a new session 'asdf' with first window 'Main'
    tmux new-session -s asdf -n Main -d
    tmux split-window -h -p 50 -t asdf:1.1

    # Third window '4x4'
    tmux new-window -n 4x4 -t asdf
    tmux split-window -h -p 50 -t asdf:2
    tmux split-window -v -p 50 -t asdf:2.1
    tmux split-window -v -p 50 -t asdf:2.2

    # Select the main editor window
    tmux select-window -t asdf:1
    tmux select-pane -t asdf:1.1
fi

# Get us into the default session.
if [[ "$TERM" != "screen-256color" ]]; then
    tmux attach -t asdf
fi
