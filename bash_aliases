# My Editor
alias mvim='~/Dropbox/Vimlander/mvim'

# Starting Rails
alias console='rails console'
alias server='rails server'
alias rs='rails s'
alias rc='rails c'

# Script / Console && Server
sc () {
  if [ -f ./script/rails ]; then
    rails c $@
  else
    ./script/console $@
  fi
}

sg () {
  if [ -f ./script/rails ]; then
    rails g $@
  else
    ./script/generate $@
  fi
}

ss () {
  if [ -f ./script/rails ]; then
    rails s $@
  else
    ./script/server $@
  fi
}

# Logging Rails
alias tdl='tail -f ./log/development.log'
alias ttl='tail -f ./log/test.log'
alias ctl='> ./log/test.log'
alias cdl='> ./log/development.log'

# Rails Database
alias rdbm='rake db:migrate'
alias rdbs='rake db:seed'

# Rails Tests
alias rsp='rake spec $1'

# Getting around my system
alias ls='ls -al'
alias d="cd ~/Dropbox"
alias doc="cd ~/Documents"
alias woork="cd ~/Dropbox/tukaiz"

# Git Versioning
alias gs='git status'
alias ga='git add'
alias gc='git commit -a'

# RVM
alias rvmrc="echo 'rvm use $1' > .rvmrc"
