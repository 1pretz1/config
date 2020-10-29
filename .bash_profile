#export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ssh into dev vm and start a tmux session
alias dev="ssh dev -t 'tmux -CC'"

# print current branch
function cb() {
  command git rev-parse --abbrev-ref HEAD
}

# push current upstream branch
function gpu() {
 command git push --set-upstream origin `cb`
}

# checkout branch by grep
function gco() {
 command git checkout `git branch | grep $1`
}

export PATH=$PATH:~/govuk/govuk-docker/exe

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/Users/peterhartshorn/govuk/govuk-guix/bin
export EDITOR=vim
#export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

#export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"

# Add go apps to path
export PATH=$PATH:$(go env GOPATH)/bin

# Path to the bash it configuration
export BASH_IT="/Users/peterhartshorn/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='Sexy'

# Add govuk-docker bin to PATH
#export PATH=$PATH:~/govuk/govuk-docker-run/bin
#export PATH=$PATH:~/govuk/govuk-docker/bin

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# ctrl-s moves forward through search history
[[ $- == *i* ]] && stty -ixon

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
eval "$(direnv hook bash)"
