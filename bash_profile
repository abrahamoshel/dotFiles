[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Added line to fix homebrew on Lion
export PATH="/usr/local/bin:$PATH:/usr/local/bin"

# Customized Bash comes from here
if [ -f ~/.vim/bashrc ]; then
  . ~/.vim/bashrc
fi
