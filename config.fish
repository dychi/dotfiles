if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Homebrew PATH
eval $(/opt/homebrew/bin/brew shellenv)

# Visual studio code alias
function vcode
  open -a "Visual Studio Code.app" $argv
end

# Alias
balias g git
balias gst 'git status'
balias gad 'git add'
balias gcm 'git commit'
balias gpush 'git push'
balias gpull 'git pull'
