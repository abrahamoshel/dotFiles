# Script / Console && Server
sc () {
  if [ -f ./script/rails ]; then
    bundle exec rails c $@
  else
    bundle exec ./script/console $@
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

# My Editor
alias mvim='~/Dropbox/Vimlander/mvim'

# Fix Vim opening up slowly
alias vi="/usr/bin/vi -X"
alias vim="/usr/bin/vim -X"

# Misc
alias h='history'

# Starting Rails
alias console='bundle exec rails console'
alias server='bundle exec rails server'
alias rs='bundle exec rails s'
alias rc='bundle exec rails c'
alias rslolcat='bundle exec rails server -d && tail -f log/* | lolcat'


# Logging Rails
alias tdl='tail -f ./log/development.log'
alias ttl='tail -f ./log/test.log'
alias ctl='> ./log/test.log'
alias cdl='> ./log/development.log'

# Rails Database
alias rdbm='bundle exec rake db:migrate'
alias rdbs='bundle exec rake db:seed'

# Rails Tests
alias rsp='bundle exec rake spec $1'

# Getting around my system
alias ls='ls -al -G'
alias d="cd ~/Dropbox"
alias doc="cd ~/Documents"
alias woork="cd ~/Dropbox/tukaiz"

# Git Versioning
alias gs='git status'
alias ga='git add'
alias gc='git commit -a'

# RVM
alias rvmrc="echo 'rvm use $1' > .rvmrc"

function mkrvmrc () {
  latest_ruby="$(rvm list strings | tail -n -1)"
  echo "rvm $latest_ruby@$(basename $PWD) --create" > .rvmrc
  source .rvmrc
}

#Chruby and Ruby Install

alias rinit='ruby-install'
alias gl='bundle exec gem list'
alias ge='bundle exec gem env'
alias bi='bundle install --path ./.bundle/gems'

alias r='bundle exec rake'
alias sourc='source ~/.bash_profile'