#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
PS1='\$ \[\e[4m\]\W\[\e[m\] \[\e[1;31m\]必緩\[\e[m\] '

# alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
alias more=less
# export QT_SELECT=4

# environment variables
export EDITOR="emacs"  
export VISUAL="emacs"
export LANG="en_US.utf8"
# export DICPATH="$HOME/.hunspell/"
# export DICTIONARY=en_US 

# user defined aliases
alias drive_list="lsblk -p"
alias unmount="umount"
alias du="du -h"
alias fat32="sudo mkfs.vfat"
alias pacup="sudo pacman -Syu" 
alias pacout="sudo pacman -Syu --noconfirm && shutdown +1" 
alias pacaup="pacaur -Syua" 
# alias paclean="sudo pacman -Rsn $(pacman -Qdtq)"
alias bashrc="emacs ~/.bashrc && source ~/.bashrc"
alias mynotes="emacs ~/Dropbox/projects/paris_1/m1_2/m2_1_notes_petit.org"
alias mypdf="zathura ~/Dropbox/projects/paris_1/m1_2/m2_1_notes_petit.pdf"
alias gom1="cd ~/Dropbox/projects/paris_1/M1_1/"
alias configinitcpio="sudo emacs /etc/mkinitcpio.conf"
alias initrams="sudo mkinitcpio -p linux-lts"
alias grub="sudo emacs /etc/default/grub"
alias xorgconf="sudo emacs /etc/X11/xorg.conf.d/00-keyboard.conf"
alias xorgkeys="cat /usr/share/X11/xkb/rules/base.lst"
#alias grubup="sudo update-grub"
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias less="less -M"
alias off="shutdown now"
alias m1="cd ~/Dropbox/projects/paris_1/m1_2/"
alias m2="cd ~/Dropbox/projects/paris_1/m2_1/"
alias stage="cd ~/Dropbox/projects/paris_1/stage/"
alias memoire="cd ~/Dropbox/projects/paris_1/memoire/"
alias certificates="cd ~/Dropbox/certificates/"
alias rmhidden="rm -i .[^.]*"
alias grep="grep -i -n --color=always"
alias useful="emacs $HOME/Dropbox/org/useful.org"
alias dropbox="cd $HOME/Dropbox ; ls -1F"
alias documents="cd $HOME/documents ; ls -1F"
alias pictures="cd $HOME/pictures ;  ls -1F"
alias scripts="cd $HOME/scripts ;  ls -1F"
alias music="cd $HOME/music ; ls -1F"
alias downloads="cd $HOME/downloads ; ls -1F"
alias configtlp="sudo emacs /etc/default/tlp"
alias videos="cd $HOME/videos ; ls -1F"
alias todo="emacs $HOME/Dropbox/org/todo.org"
alias r_install="R CMD INSTALL -l $R_LIBS_USER"
alias backsys="sudo rsync -aAX --delete --exclude={"/dev/*","/proc/*","/home/*""/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} --info=progress2 / /run/media/sync0/backup/backups/system"
alias backbox="sudo rsync -a --delete --info=progress2 /home/$USER/Dropbox /run/media/sync0/backup/backups"
# alias restoreme="rsync -aAX --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} --info=progress2 /run/media/sync0/mjro_backup/ /"
alias pdf_compress="gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook
-dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true
-r150"
alias pdf_shrink='bash $HOME/Scripts/shell/shrinkpdf.sh'
screenfetch
alias setscreen='xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync && xrandr --addmode HDMI-1 1920x1080_60.00'
# keep the prompt on top
#prompt_on_top() {
#  tput cup 0 0
#  tput el
#  tput el1
#}

#pre_cmd() {
#  if [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] || [ -n "$COMP_LINE" ]; then
#    return
#  fi
#  printf "\33[2J"
#}

#PROMPT_COMMAND="prompt_on_top"
#trap 'pre_cmd' DEBUG
# source /home/sync0/.oh-my-git/prompt.sh
