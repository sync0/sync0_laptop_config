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
export TZ="America/Bogota"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export IBUS_ENABLE_SYNC_MODE=0
# export DICPATH="$HOME/.hunspell/"
# export DICTIONARY=en_US 
