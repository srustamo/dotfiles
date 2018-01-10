# 21_07_2015 
##http://www.softec.lu/site/DevelopersCorner/MasteringThePathHelper
#if [ -x /usr/libexec/path_helper ]; then
#	PATH=""
#	eval `/usr/libexec/path_helper -s`
#fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=~/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export SHELL="/usr/local/bin/zsh"
# enable Homebrew coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# ruby related 
# 08_07_2015 https://gorails.com/setup/osx/10.9-mavericks
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin" #commented out SR 31_12_2014
### export MANPATH="/usr/local/man:$MANPATH"
##export PATH=/usr/local/bin:$PATH #added SR 31_12_2014 12:09
##export PATH=/usr/local/sbin:$PATH #added SR 20_07_2015 17:19
###export PATH=/opt/local/bin:/opt/local/sbin:$PATH #added SR  29_07_2015 after macport install
##export PATH=$PATH:/opt/local/bin:/opt/local/sbin: #added SR  28_07_2015 after macport install
### enable Homebrew coreutils SR 16_06_2015 19:51
### http://tealscientific.com/blog/?p=2450
##export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
##export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export VISUAL=vim
export EDITOR="$VISUAL"

# 9_11_2016  
# https://source.android.com/source/initializing.html#setting-up-a-mac-os-x-build-environment
# mount the android file image
function mountAndroid { hdiutil attach ~/android.dmg.sparseimage -mountpoint /Volumes/android; }
# unmount the android file image
function umountAndroid() { hdiutil detach /Volumes/android; }
# set the number of open files to be 1024
ulimit -S -n 1024

export PATH="$HOME/.cargo/bin:$PATH"
