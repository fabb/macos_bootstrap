source ~/git-completion.bash
source /usr/local/etc/profile.d/z.sh

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export CLICOLOR=1

alias be='bundle exec'
alias pi='bundle exec pod install --repo-update'
alias pin='bundle exec pod install'
alias fixpod='git reset Podfile.lock && git checkout Podfile.lock && git reset Pods/Manifest.lock && git checkout Pods/Manifest.lock && git diff --name-only --diff-filter=U Pods/ | xargs -I{} git reset "{}" && bundle exec pod install --repo-update'
alias fixpodn='git reset Podfile.lock && git checkout Podfile.lock && git reset Pods/Manifest.lock && git checkout Pods/Manifest.lock && git diff --name-only --diff-filter=U Pods/ | xargs -I{} git reset "{}" && bundle exec pod install'
alias gp='git-pull-all'

alias rm=trash

export MAVEN_OPTS="-Xmx1048m -Xms256m"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

recsim() {
    xcrun simctl io booted recordVideo "$1"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

complete -C /usr/local/bin/mc mc
