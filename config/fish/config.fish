if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x GPG_TTY $(tty)
end

set -g fish_greeting

mcfly init fish | source
zoxide init fish --cmd cd | source
abbr --add ls eza
abbr --add cat bat
alias tree="eza --tree"

starship init fish | source
direnv hook fish | source
