# Git Alias
alias gst='git status'
alias gad='git add'
alias gcm='git commit'
alias gpush='git push'
alias gpull='git pull'
alias gchout='git checkout'
alias gdiff='git diff'
alias gswitch='git switch'

# alias cat
if [[ $(command -v bat) ]]; then
  alias cat='bat'
fi

# ls
alias ls='ls -aGF'
alias ll='ls -Flh'

# Wifi Alias: on/off
# alias wo="networksetup -setairportpower en0 on"
# alias wf="networksetup -setairportpower en0 off"
