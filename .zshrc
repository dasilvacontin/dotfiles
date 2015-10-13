# ZSH

export ZSH=/Users/dasilvacontin/.oh-my-zsh # Path to your oh-my-zsh installation.
ZSH_THEME="robbyrussell" # name of the zsh theme to load.
COMPLETION_WAITING_DOTS="true" # display red dots whilst waiting for completion.

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)


# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Go stuff
export GOPATH=$HOME/go-workspace
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

# export MANPATH="/usr/local/man:$MANPATH"
umask 022
source $ZSH/oh-my-zsh.sh


# hub is an enriches git with GitHub candy
# https://github.com/github/hub
# eval "$(hub alias -s)"
# function git(){hub $@} fixes auto-completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Aliases

alias log1="git log --pretty=oneline"
alias zshconfig="vim ~/.zshrc"
alias git=hub
alias nr="npm run"

# FZF

## set ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'

## apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# FZF - Scripts

## fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf-tmux +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

## fcommit - show commit
#
# press enter to view commit in terminal
# press CTRL-B to open commit in github
fcommit() {
  local out option commit repo
  out=$(git log --pretty=oneline | fzf-tmux +m --exit-0 --expect=ctrl-b)
  option=$(head -1 <<< "$out")
  commit=$(head -2 <<< "$out" | tail -1 | sed "s/ .*//")
  if [ -n "$commit" ]; then
    if [ "$option" = ctrl-b ]; then
      repo=$(git config --get remote.origin.url | sed "s/.*com[\/:]//")
      repo=$(sed "s/.git$//" <<< "$repo")
      repo="https://github.com/$repo/commit/$commit"
      open "$repo"
    else
      git show $(echo "$commit")
    fi
  fi
}

## ff - search file contents
alias ff="ag --nobreak --nonumbers --noheading . | fzf | fpp"

## fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# Autocompletion

## Travis autocomp
[ -f /Users/dasilvacontin/.travis/travis.sh ] && source /Users/dasilvacontin/.travis/travis.sh


# Plugins (via zgen)

## load zgen
source "${HOME}/GitHub/tarjoilija/zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save"

  zgen oh-my-zsh

  zgen load walesmd/caniuse.plugin.zsh
  zgen load b4b4r07/enhancd
  zgen load peterhurford/git-aliases.zsh
  zgen load uvaes/fzf-marks

  zgen save
fi


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
