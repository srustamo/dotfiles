# alias
[[ -e ~/.alias ]] && emulate sh -c 'source ~/.alias'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

unsetopt CASE_GLOB          # case insensitive
unsetopt nomatch            # prevent zsh to print an error when no match can be found
setopt ignoreeof            # ignore EOF ('^D') (i.e. don't log out on it)
disable r                   # disable redo command r
stty -ixon -ixoff           # enable i-search

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
#   14_01_2016 https://github.com/pengwynn/dotfiles/blob/master/zsh/config.zsh
# setopt complete_aliases

#{{{ history
export HISTSIZE=20000
export HISTFILE="$HOME/.zhistory"
export SAVEHIST=$HISTSIZE
setopt extendedhistory      # save timestamps in history
setopt no_histbeep          # don't beep for erroneous history expansions
setopt histignoredups       # ignore consecutive dups in history
setopt histfindnodups       # backwards search produces diff result each time
setopt histreduceblanks     # compact consecutive white space chars (cool)
setopt histnostore          # don't store history related functions
setopt incappendhistory     # incrementally add items to HISTFILE
# setopt histverify           # confirm !: or ^ command results before execution
setopt share_history        # share history between sessions ???
#}}}

eval "$(dircolors -b $HOME/GitHub/LS_COLORS/LS_COLORS)"
# LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
# export LS_COLORS
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt AUTO_CD

# keybind
# bindkey -v                # vi mode
bindkey "^[[3~" delete-char
autoload -U select-word-style
select-word-style bash
bindkey "^d"  bash-ctrl-d

# bash like ctrl d
bash-ctrl-d()
{
    if [[ $CURSOR == 0 && -z $BUFFER ]]
    then
        [[ -z $IGNOREEOF || $IGNOREEOF == 0 ]] && exit
        [[ -z $__BASH_IGNORE_EOF ]] && (( __BASH_IGNORE_EOF = IGNOREEOF ))
        if [[ $LASTWIDGET == "bash-ctrl-d" ]]
        then
            [[ $__BASH_IGNORE_EOF -le 0 ]] && exit
        else
            (( __BASH_IGNORE_EOF = IGNOREEOF ))
        fi
        (( __BASH_IGNORE_EOF = __BASH_IGNORE_EOF - 1 ))
        echo -n Use \"exit\" to leave the shell Shavkat.
        zle send-break
    else
        zle delete-char-or-list
    fi
}
export IGNOREEOF=1
autoload -U send-break
autoload -U delete-char-or-list
zle -N bash-ctrl-d

#{{{ oh-my-zsh
# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git tmux osx)
#vim-interaction


# source $ZSH/oh-my-zsh.sh
#}}}
# reduce Esc delay
# http://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1

# add zsh-completions of homebrew
fpath=(~/Dropbox/dotfiles /usr/local/share/zsh/site-functions /usr/local/share/zsh-completions ~/zsh_plugins/* ~/zsh_prompts/* $fpath)

# compsys initialization
# setopt noautomenu
# setopt nomenucomplete
setopt nolistambiguous
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

#Shavkat here 12.29.14
#https://github.com/robbyrussell/oh-my-zsh/issues/2189
bindkey -v
#Shavkat here 12_01_2016
#looks like the slow vi mode has been resolved; put vi-mode plugin back in

#26_06_2015
#https://github.com/clvv/fasd
eval "$(fasd --init auto)"
# alias v='f -e vim' # quick opening files with vim
#alias m='f -e mplayer' # quick opening files with mplayer
#alias o='a -e xdg-open' # quick opening files with xdg-open
#
#Shavkat here
# git-radar - promt
# 02_09_2015
# https://github.com/michaeldfallen/git-radar/blob/master/README.md
# causing error ***** TODO error nohup: redirecting stderr to stdout, disabled git-radar from .zshrc at the moment
# export PROMPT="%1/%$(git-radar --zsh --fetch) "

#Shavkat here
# 25_11_2015
copy() {
	if [[ $1 =~ ^-?[hH] ]]; then

		echo "Intelligently copies command results, text file, or raw text to"
		echo "OS X clipboard"
		echo
		echo "Usage: copy [command or text]"
		echo "  or pipe a command: [command] | copy"
		return
	fi

	local output
	local res=false
	local tmpfile="${TMPDIR}/copy.$RANDOM.txt"
	local msg=""

	if [[ $# == 0 ]]; then
		output=$(cat)
		msg="Input copied to clipboard"
		res=true
	else
		local cmd=""
		for arg in $@; do
			cmd+="\"$(echo -en $arg|sed -E 's/"/\\"/g')\" "
		done
		output=$(eval "$cmd" 2> /dev/null)
		if [[ $? == 0 ]]; then
			msg="Results of command are in the clipboard"
			res=true
		else
			if [[ -f $1 ]]; then
				output=""
				for arg in $@; do
					if [[ -f $arg ]]; then
						type=`file "$arg"|grep -c text`
						if [ $type -gt 0 ]; then
							output+=$(cat $arg)
							msg+="Contents of $arg are in the clipboard.\n"
							res=true
						else
							msg+="File \"$arg\" is not plain text.\n"
						fi
					fi
				done
			else
				output=$@
				msg="Text copied to clipboard"
				res=true
			fi
		fi
	fi

	$res && echo -ne "$output" | pbcopy -Prefer txt
	echo -e "$msg"
}

# Change iterm2 profile. Usage it2prof ProfileName (case sensitive)
# https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli
it2prof() { echo -e "\033]50;SetProfile=$1\a" }

#{{{ Prompt
autoload -U promptinit && promptinit
prompt pure

VIM_PROMPT="❯"
PROMPT='%(?.%F{green}.%F{red})${VIM_PROMPT}%f '

function zle-line-init zle-keymap-select { 
    VIM_PROMPT=${${KEYMAP/vicmd/❮}/(main|viins)/❯}
    zle .reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# PROMPT='%(?.%F{green}.%F{red})${${KEYMAP/vicmd/❮%f}/(main|viins)/❯%f} '
# PROMPT='[KEYMAP:${KEYMAP-<<unset>>}]%(?.%F{green}.%F{red})${${KEYMAP/vicmd/❮}/(main|viins)/❯}%f '
#
#function zle-line-init zle-keymap-select {
#	# VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#	# RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#	zle .reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select
#}}}
TRAPWINCH() {
	    zle && zle .reset-prompt && zle -R
	}

##{{{ syntax highlight
#if [[ "$OSTYPE" == "linux-gnu" ]]; then
#export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/share/zsh-syntax-highlighting/highlighters
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#elif [[ "$OSTYPE" == "darwin"* ]]; then
#        # Mac OSX
#export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#elif [[ "$OSTYPE" == "cygwin" ]]; then
#        # POSIX compatibility layer and Linux environment emulation for Windows
#elif [[ "$OSTYPE" == "msys" ]]; then
#        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
#elif [[ "$OSTYPE" == "win32" ]]; then
#        # I'm not sure this can happen.
#elif [[ "$OSTYPE" == "freebsd"* ]]; then
#        # ...
#else
#        # Unknown.
#fi
##}}}

#{{{ history-substring-search
if [[ "$OSTYPE" == "linux-gnu" ]]; then
source ~/dotfiles/zshrc/zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
# source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/dotfiles/zshrc/zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
#}}}

#{{{ zsh-autosuggestions
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	source ~/dotfiles/zshrc/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
	source ~/dotfiles/zshrc/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi
#}}}

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=
# export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=
setopt HIST_IGNORE_ALL_DUPS

 # 14_01_2016 from https://github.com/sindresorhus/pure/wiki
 # had to put this after prompt pure init, still C-l causes problem
#PROMPT='%(?.%F{green}.%F{red})${${KEYMAP/vicmd/❮%f}/(main|viins)/❯%f} '
#####PROMPT='%(?.%F{green}.%F{red})${${KEYMAP/vicmd/❮%f}/(main|viins)/❯%f} '
##### ## PROMPT='%(?.%F{green}.%F{red})${${KEYMAP/vicmd/<%f}/(main|viins)/>%f} '
#####function zle-line-init zle-keymap-select {
#####    zle reset-prompt
#####    }
#####zle -N zle-line-init
#####zle -N zle-keymap-select

# source these at the end recommended 
#{{{zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting#faq 
if [[ "$OSTYPE" == "linux-gnu" ]]; then
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/share/zsh-syntax-highlighting/highlighters
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=~/dotfiles/zshrc/zsh_plugins/zsh-syntax-highlighting/highlighters
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zshrc/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi
#}}}

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then source '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then source '~/google-cloud-sdk/completion.zsh.inc'; fi
#pushd Sat Jun 19 19:39:06 2021 
#https://zsh.sourceforge.io/Intro/intro_6.html
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
# https://news.ycombinator.com/item?id=6230284
di() {
	local dir
	select dir in $dirstack
	do
		echo $dir
		break
	done
	test "x$dir" != x && cd $dir
    }
