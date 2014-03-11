# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Added line to fix homebrew on Lion
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Customized Bash comes from here
if [ -f ~/.vim/bashrc ]; then
  . ~/.vim/bashrc
fi

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# To get sublime to open from the command line
# sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/bin/subl

# To remove all gems in one command
# for x in `gem list --no-versions`; do gem uninstall $x -a -x -I; done