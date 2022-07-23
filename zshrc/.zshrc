#{{{ export
# Basics
export EDITOR='nvim'
export PAGER='less'
export LANG='en_US.UTF-8'
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# man
export MANWIDTH='100'
export MANPAGER='nvim +Man!'
#}}}

#{{{ functions
# lf `cd` into the last directory upon exit. - kutsan Sat Jul 23 17:58:03 2022
function lf() {
  command lf -last-dir-path="$HOME/.local/share/lf/lastdir" "$@" \
    && cd "$(<$HOME/.local/share/lf/lastdir)" 2>/dev/null
}
#}}}

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

#{{{ keybind
bindkey -v                # vi mode
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
#}}}
export IGNOREEOF=1
autoload -U send-break
autoload -U delete-char-or-list
zle -N bash-ctrl-d

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

# turn on git stash status
# Tue Jul 12 18:33:31 2022 https://github.com/sindresorhus/pure
# # turn on git stash status
zstyle :prompt:pure:git:stash show yes

zstyle :prompt:pure:prompt:success color green 

prompt pure

# https://github.com/sindresorhus/pure/issues/184#issuecomment-173482509
TRAPWINCH() {
	    zle && zle .reset-prompt && zle -R
	}
#}}}

#{{{ history-substring-search
if [[ "$OSTYPE" == "linux-gnu" ]]; then
source ~/dotfiles/zshrc/zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
# source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/dotfiles/zshrc/zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/dotfiles/zshrc/zsh_plugins/fzf-marks/init.zsh

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/srmbp1/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/srmbp1/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/srmbp1/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/srmbp1/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
if [ -e /Users/srmbp1/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/srmbp1/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Wed Sep 15 17:37:15 2021
# https://www.gregorykapfhammer.com/software/tool/productivity/2017/05/08/Directory-Zooming/
t() {
  fasdlist=$( fasd -d -l -r $1 | \
    fzf --query="$1 " --select-1 --exit-0 --height=25% --reverse --tac --no-sort --cycle) &&
    cd "$fasdlist"
}
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Thu Sep 16 15:44:59 2021
#https://github.com/junegunn/fzf/wiki/Color-schemes
# export FZF_DEFAULT_OPTS='
#   --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
#   --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
#   --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07
# '

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"
  # Uncomment for truecolor, if your terminal supports it.
  # local base03="#002b36"
  # local base02="#073642"
  # local base01="#586e75"
  # local base00="#657b83"
  # local base0="#839496"
  # local base1="#93a1a1"
  # local base2="#eee8d5"
  # local base3="#fdf6e3"
  # local yellow="#b58900"
  # local orange="#cb4b16"
  # local red="#dc322f"
  # local magenta="#d33682"
  # local violet="#6c71c4"
  # local blue="#268bd2"
  # local cyan="#2aa198"
  # local green="#859900"

  # Comment and uncomment below for the light theme.

  # # Solarized Dark color scheme for fzf
  # export FZF_DEFAULT_OPTS="
  #   --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
  #   --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  # "
   ## Solarized Light color scheme for fzf
	export FZF_DEFAULT_OPTS="
	--color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
	--color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
	--height 40%
	--layout=reverse
	"
	# --height 40% --layout=reverse'
}
_gen_fzf_default_opts

# Thu Sep 16 20:24:26 2021
bindkey "ç" fzf-cd-widget
export PATH="/usr/local/opt/ruby/bin:$PATH"

if [ -f /usr/local/bin/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

if [ -f ~/dotfiles/nnn/nnn.zsh ]; then
   source ~/dotfiles/nnn/nnn.zsh
fi
