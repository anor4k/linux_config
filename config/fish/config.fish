if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x GPG_TTY $(tty)
end

mcfly init fish | source
zoxide init fish --cmd cd | source
abbr --add ls eza
abbr --add cat bat
alias tree="eza --tree"
alias kube-update="AWS_PROFILE=uncover aws eks update-kubeconfig --region us-east-1 --name uncover-prod-us-east-1-eks-cluster"
alias kube-token="kube-update && aws eks get-token --cluster-name uncover-prod-us-east-1-eks-cluster | jq -r '.status.token' | wl-copy"

starship init fish | source
direnv hook fish | source
