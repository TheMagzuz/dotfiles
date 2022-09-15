alias vim='nvim'
alias py='python3'
alias cls='clear'
alias cd..='cd ..'
alias tmux="tmux -u"

# Git aliases
alias g='git'
alias gaa='git add .'
alias gc='git commit -m'
alias gl='git log'
alias gst='git status'
alias gps='git push'
alias gpl='git pull'
alias gd='git diff'
alias gap='git add -p'

# Standard command aliases
alias ls='ls --color'
alias mkdir='mkdir -p'

# Activate python virtual environment
activate() {
  venv=venv
  [ ! -z $1 ] && venv="$1"
  source ./$venv/bin/activate
}
