# Set up a default session called 'asdf'.

tmux has-session -t asdf
if [[ $? != 0 ]]; then
    # Make sure we detach first if we are already inside tmux.
    if [[ "$TERM" == "screen-256color" ]]; then
        tmux detach
    fi

    tmux set -g base-index 1
    tmux setw -g pane-base-index 1

    # Create a new session 'asdf' with first window 'Editor'
    tmux new-session -s asdf -n Editor -d

    tmux split-window -v -p 25 -t asdf:1.1
    tmux split-window -h -p 25 -t asdf:1.2

    # Second window 'Whatevs'
    tmux new-window -n Whatevs -t asdf
    tmux split-window -h -p 50 -t asdf:2

    # Third window 'Servers'
    tmux new-window -n Servers -t asdf
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
