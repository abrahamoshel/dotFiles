export EDITOR='subl -w'
# export MAIN_EDITOR='subl'
# alias subl=$MAIN_EDITOR

# Store 10,000 history entries
export HISTSIZE=10000
# Don't store duplicates
export HISTCONTROL=erasedups

## The prompt below gets ideas from the following:
    # http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
    # http://github.com/adamv/dotfiles/blob/master/bashrc
    # http://wiki.archlinux.org/index.php/Color_Bash_Prompt
## Custom prompt
# Colors
       RED="\[\033[0;31m\]"
      PINK="\[\033[1;31m\]"
    YELLOW="\[\033[1;33m\]"
     GREEN="\[\033[0;32m\]"
  LT_GREEN="\[\033[1;32m\]"
      BLUE="\[\033[0;34m\]"
     WHITE="\[\033[1;37m\]"
    PURPLE="\[\033[1;35m\]"
      CYAN="\[\033[1;36m\]"
     BROWN="\[\033[0;33m\]"
COLOR_NONE="\[\033[0m\]"

LIGHTNING_BOLT="⚡"
      UP_ARROW="↑"
    DOWN_ARROW="↓"
      UD_ARROW="↕"
      FF_ARROW="→"
       RECYCLE="♺"
        MIDDOT="•"
     PLUSMINUS="±"

function parse_git_branch {
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern_ahead="# Your branch is ahead of"
  remote_pattern_behind="# Your branch is behind"
  remote_pattern_ff="# Your branch (.*) can be fast-forwarded."
  diverge_pattern="# Your branch and (.*) have diverged"

  git_status="$(git status 2> /dev/null)"
  if [[ ! ${git_status} =~ ${branch_pattern} ]]; then
    # Rebasing?
    toplevel=$(git rev-parse --show-toplevel 2> /dev/null)
    [[ -z "$toplevel" ]] && return

    [[ -d "$toplevel/.git/rebase-merge" || -d "$toplevel/.git/rebase-apply" ]] && {
      sha_file="$toplevel/.git/rebase-merge/stopped-sha"
      [[ -e "$sha_file" ]] && {
        sha=`cat "${sha_file}"`
      }
      echo "${PINK}(rebase in progress)${COLOR_NONE} ${sha}"
    }
  fi

  branch=$(git rev-parse --abbrev-ref HEAD)

  # Dirty?
  if [[ ! ${git_status} =~ "working directory clean" ]]; then
    [[ ${git_status} =~ "modified:" ]] && {
      git_is_dirty="${RED}${LIGHTNING_BOLT}"
    }

    [[ ${git_status} =~ "Untracked files" ]] && {
      git_is_dirty="${git_is_dirty}${WHITE}${MIDDOT}"
    }

    [[ ${git_status} =~ "new file:" ]] && {
      git_is_dirty="${git_is_dirty}${LT_GREEN}+"
    }

    [[ ${git_status} =~ "deleted:" ]] && {
      git_is_dirty="${git_is_dirty}${RED}-"
    }

    [[ ${git_status} =~ "renamed:" ]] && {
      git_is_dirty="${git_is_dirty}${YELLOW}→"
    }
  fi

  # Are we ahead of, beind, or diverged from the remote?
  if [[ ${git_status} =~ ${remote_pattern_ahead} ]]; then
    remote="${YELLOW}${UP_ARROW}"
  elif [[ ${git_status} =~ ${remote_pattern_ff} ]]; then
    remote_ff="${WHITE}${FF_ARROW}"
  elif [[ ${git_status} =~ ${remote_pattern_behind} ]]; then
    remote="${YELLOW}${DOWN_ARROW}"
  elif [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}${UD_ARROW}"
  fi

  echo "${remote}${remote_ff}${GREEN}(${branch})${COLOR_NONE}${git_is_dirty}${COLOR_NONE}"
}

function setWindowTitle {
  case $TERM in
    *xterm*|ansi)
      echo -n -e "\033]0;$*\007"
      ;;
  esac
}

function set_prompt {
  [[ -n $HOMEBREW_DEBUG_INSTALL ]] && \
    homebrew_prompt="${BROWN}Homebrew:${COLOR_NONE} debugging ${HOMEBREW_DEBUG_INSTALL}\n"

  git_prompt="$(parse_git_branch)"
  export CLICOLOR=1
  export LSCOLORS=gxgxcxdxbxegedabagacad  # cyan directories
  export PS1="[\w] ${git_prompt}${COLOR_NONE}\n${homebrew_prompt}${CYAN}💀  "
  setWindowTitle "${PWD/$HOME/~}"

}

export PROMPT_COMMAND=set_prompt

function git-root {
  root=$(git rev-parse --git-dir 2> /dev/null)
  [[ -z "$root" ]] && root="."
  dirname $root
}


# Get My Alaises
if [ -f ~/.vim/bash_aliases ]; then
  . ~/.vim/bash_aliases
fi

# Auto completion for git
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export BUNDLER_EDITOR=vim

#config for autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
# [[ -s ~/.autojump/etc/profile.d/autojump.bash ]] && source ~/.autojump/etc/profile.d/autojump.bash

#add .ssh/id_rsa for deployments
ssh-add

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


# Setup chruby and having chruby automatically switch rubies in there is a .ruby-version file
if [[ -e /usr/local/share/chruby ]]; then
  # Load chruby
  source '/usr/local/share/chruby/chruby.sh'

  # Automatically switch rubies
  source '/usr/local/share/chruby/auto.sh'

  # need to get it working to bash it is for zsh right now
  #source ~/.vim/chruby_gemset

  # Set a default ruby if a .ruby-version file exists in the home dir
  if [[ -f ~/.ruby-version ]]; then
    chruby $(cat ~/.ruby-version)
  fi
fi

# For notes in terminal
# Finds or creates by name
n() {
        $EDITOR ~/notes/"$*".txt
}
# Gives list of all notes that have name in the title
nls() {
        ls -c ~/notes/ | grep "$*"
}

# Golang
export GOPATH=$HOME/.
export GOROOT=`go env GOROOT`
export PATH=$GOPATH/bin:$PATH:$GOROOT/bin

# Docker and Docker2Boot
export DOCKER_HOST=tcp://localhost:4243

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

# Uncomment to persist pair info between terminal instances
hitch
