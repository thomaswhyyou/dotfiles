tmux has-session -t Painless
if [[ $? != 0 ]]
then
    tmux detach

    # Create a new session 'Painless' with first window 'Editor'
    tmux new-session -s Painless -n Editor -d
    tmux split-window -h -p 28 -t Painless:1.1
    tmux split-window -v -p 50 -t Painless:1.2
    tmux send-keys -t Painless:1.1 'ls -FGlAhp' C-m

    # Second window 'Servers'
    tmux new-window -n Servers -t Painless
    tmux split-window -h -p 66 -t Painless:2
    tmux split-window -h -p 50 -t Painless:2
    tmux split-window -v -p 33 -t Painless:2.3

    # Third window 'Whatevs'
    tmux new-window -n Whatevs -t Painless

    # Select the main editor window
    tmux select-window -t Painless:1
    tmux select-pane -t Painless:1.1
fi
tmux attach -t Painless
