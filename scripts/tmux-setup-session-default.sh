# Set up a default session called 'asdf'.

tmux has-session -t asdf
if [[ $? != 0 ]]; then
    # Make sure we detach first if we are already inside tmux.
    if [[ "$TERM" == "screen-256color" ]]; then
        tmux detach
    fi

    tmux set -g base-index 1
    tmux setw -g pane-base-index 1

    # Create a new session 'asdf' with first window 'main'
    tmux new-session -s asdf -n main -d

    # Third window 'misc'
    tmux new-window -n misc -t asdf
    tmux split-window -h -p 50 -t asdf:2.1

    # Third window '2x2'
    tmux new-window -n 2x2 -t asdf
    tmux split-window -h -p 50 -t asdf:3
    tmux split-window -v -p 50 -t asdf:3.1
    tmux split-window -v -p 50 -t asdf:3.2

    # Select the main editor window
    tmux select-window -t asdf:1
    tmux select-pane -t asdf:1.1
fi

# Get us into the default session.
if [[ "$TERM" != "screen-256color" ]]; then
    tmux attach -t asdf
fi
