if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting
set -g fish_escape_delay_ms 20
set -g fish_handle_reflow 0
#set -g fish_autosuggestion_generation_methods history
#set -g fish_history_max_length 2000  # Limit history size
#set -g fish_autosuggestion_enabled 0

source ~/dotfiles/aliases.sh
source ~/dotfiles/functions.fish
source ~/.secret_aliases
