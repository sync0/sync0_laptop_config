# export QT_SELECT=4

# Avoid duplicate $PATH
typeset -U path
path=(~/.local/bin /other/things/in/path $path[@])

# environment variables
export EDITOR="emacs"  
export VISUAL="emacs"
export LANG="en_US.utf8"
export DICPATH="/usr/share/hunspell/"
export DICTIONARY=en_US-large
# export DICPATH="$HOME/.hunspell/"
# export DICTIONARY=en_US 
