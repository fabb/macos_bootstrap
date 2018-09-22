source ~/git-completion.bash

export PATH=$HOME/bin:$PATH

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export CLICOLOR=1

alias be='bundle exec'
alias pi='bundle exec pod install --repo-update'
alias pin='bundle exec pod install'
alias fixpod='git reset Podfile.lock && git checkout Podfile.lock && git reset Pods/Manifest.lock && git checkout Pods/Manifest.lock && git diff --name-only --diff-filter=U Pods/ | xargs -I{} git reset "{}" && bundle exec pod install --repo-update'
alias gp='git-pull-all'

export MAVEN_OPTS="-Xmx1048m -Xms256m -XX:MaxPermSize=312M"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

recsim() {
    xcrun simctl io booted recordVideo "$1"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
