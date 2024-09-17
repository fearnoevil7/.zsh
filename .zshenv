
# +-----------------+
# | User Directores |
# +-----------------+

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"


# +--------------------+
# | System Directores  |
# +--------------------+

# Created /usr/local/share
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
# Created /etc/xdg
export XDG_CONFIG_DIRS="/etc/xdg"

export ZDOTDIR="$XDG_CONFIG_HOME/.zsh"


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.config/.oh-my-zsh"


# +------+
# | SUDO |
# +------+

export SUDO_ASKPASS=$HOME/Assets/Tools/askpass/askpass.app/Contents/MacOS/askpass


# +---------+
# | HISTORY |
# +---------+
# Move Change where the ZSH History file is written and from where it is read.
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$XDG_CONFIG_HOME/.zsh/.zsh_history"



# Increase number of possible completions shown.
export LISTMAX=200


# +--------+
# | EDITOR |
# +--------+
export EDITOR="nvim"
export VISUAL="nvim"


# +-----------+
# | MAN PAGES |
# +-----------+
# Man Pages
export MANPATH="/usr/local/man:/Applications/Alacritty.app/Contents/Resources/man:$MANPATH"
#Using "bat" as a colorizing pager for man.
export MANPAGER="sh -c 'col -bx | bat -l man -p'"


# +----+
# | GO |
# +----+
export GOPATH=$HOME/Assets/.go
export PATH=$PATH:$GOPATH/bin


# +-----+
# | BAT |
# +-----+
export BAT_THEME=base16-256


# +----------+
# | LSCOLORS |
# +----------+
# How to set ls colors in mac m1 pro zsh: https://www.reddit.com/r/MacOS/comments/rzsday/terminal_coloured_ls_output_for_more_than_just/
# Check ls man pages for help too.
if [[ -n "$TERM_PROGRAM" && "$TERM_PROGRAM" == "iTerm.app" ]]; then
	export LSCOLORS="GxdxcxbxDxegedabagacad"
else
	export LSCOLORS="FxdxcxbxDxegedabagacad"
fi

#    rs=0: Reset
#    di=01;34: Directory
#    ln=01;36: Symbolic link
#    so=01;35: Socket
#    pi=01;33: Pipe
#    ex=01;32: Executable
#    bd=34;46: Block device
#    cd=34;43: Character device
#    su=30;41: Directory writable to others, with sticky bit
#    sg=30;46: Directory writable to others, without sticky bit
#    tw=30;42: Directory writable to others, with sticky bit and group execution
#    ow=30;43: Directory writable to others, without sticky bit, with group execution


# +-----+
# | FZF |
# +-----+
export FZF_DEFAULT_OPTS="
--no-height
--no-reverse
--ansi
--multi
--height=50%
--margin=5%,2%,2%,5%
--layout=reverse-list
--border=double
--info=inline
--prompt='👻$>'
--pointer='→'
--marker='🎯'
--header='CTRL-c or ESC 👑 to quit && Press TAB 💣 to select multiple lines' --color='dark,fg:magenta'

--color="bg+:-1,\
fg:252,\
fg+:178,\
border:241,\
spinner:199,\
hl:yellow,\
header:blue,\
info:37,\
pointer:196,\
prompt:magenta,\
hl+:red,\
separator:202"
"


export FZF_ALT_C_OPTS="
--multi --height=80% --border=sharp \
--preview='tree -C {}' --preview-window='45%,border-sharp' \
--bind='ctrl-_:execute(rm -ri {+})' \
--bind='ctrl-p:toggle-preview' \
--bind='ctrl-d:change-prompt(Dirs > )' \
--bind='ctrl-d:+reload(find . -type d 2>&1)' \
--bind='ctrl-d:+change-preview(tree -C {})' \
--bind='ctrl-d:+refresh-preview' \
--bind='ctrl-f:change-prompt(Files > )' \
--bind='ctrl-f:+reload(find . -type f 2>&1)' \
--bind='ctrl-f:+change-preview(bat --color=always {})' \
--bind='ctrl-f:+refresh-preview' \
--bind='ctrl-a:select-all' \
--bind='ctrl-x:deselect-all' \
--header '
CTRL-D 👑 to display directories | CTRL-F to display files
CTRL-A 🐙 to select all | CTRL-x 💣 to deselect all
ENTER 👾 to edit | DEL 🪼 to delete
CTRL-P 💎 to toggle preview
'
"

export FZF_CTRL_T_OPTS="
--multi --height=80% --border=sharp \
--preview='tree -C {}' --preview-window='45%,border-sharp' \
--bind='ctrl-_:execute(rm -ri {+})' \
--bind='ctrl-p:toggle-preview' \
--bind='ctrl-d:change-prompt(Dirs > )' \
--bind='ctrl-d:+reload(find . -type d 2>&1)' \
--bind='ctrl-d:+change-preview(tree -C {})' \
--bind='ctrl-d:+refresh-preview' \
--bind='ctrl-f:change-prompt(Files > )' \
--bind='ctrl-f:+reload(find . -type f 2>&1)' \
--bind='ctrl-f:+change-preview(bat --color=always {})' \
--bind='ctrl-f:+refresh-preview' \
--bind='ctrl-a:select-all' \
--bind='ctrl-x:deselect-all' \
--header '
CTRL-D 👑 to display directories | CTRL-F  to display files
CTRL-A 🐙 to select all | CTRL-x 💣 to deselect all
ENTER 👾 to edit | DEL 🪼 to delete
CTRL-P 💎 to toggle preview
'
"
#export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix --color=always --hidden --exclude .git"



# *** To get an "un-exact" match prefix your search term with '
#export FZF_CTRL_R_OPTS="--no-sort --exact --bind='ctrl-e:'"
export FZF_CTRL_R_OPTS="
--no-sort
--exact
--preview 'echo {}'
--preview-window down:3:hidden:wrap
--bind '?:toggle-preview'
--header='Press ? to preview | To get an 'un-exact' match prefix your search term with a single quote.'
"



# # Create a Preview Window that Serves as a help window and place the following contents in it.

#   Unless otherwise specified, fzf starts in "extended-search mode" where you can type in multiple search terms delimited by spaces. e.g. ^music .mp3$ sbtrkt !fire
#   Token 	   Match type 	                Description

#   sbtrkt 	   fuzzy-match 	                Items that match sbtrkt
#   'wild 	   exact-match (quoted)         Items that include wild
#   ^music 	   prefix-exact-match 	        Items that start with music
#   .mp3$ 	   suffix-exact-match 	        Items that end with .mp3
#   !fire 	   inverse-exact-match 	        Items that do not include fire
#   !^music    inverse-prefix-exact-match 	Items that do not start with music
#   !.mp3$ 	   inverse-suffix-exact-match 	Items that do not end with .mp3
#   
#    - If you don't prefer fuzzy matching and do not wish to "quote" every word, start fzf with -e or --exact option. Note that when --exact is set, '-prefix "unquotes" the term.
#   
#    - A single bar character term acts as an OR operator. For example, the following query matches entries that start with core and end with either go, rb, or py. ^core go$ | rb$ | py$








#FZF_DEFAULT_COMMAND="find . -type d" fzf \
#--preview='tree -C {}' \
#--bind='ctrl-r:reload(eval $FZF_DEFAULT_COMMAND)' \
#--bind='del:+reload(eval $FZF_DEFAULT_COMMAND)' \
#--header='CTRL-R to refresh the list | CTRL-P to toggle the preview | DEL to delete the current directory'


#--color="bg+:-1,\
#fg:252,\
#fg+:202,\
#border:241,\
#spinner:0,\
#hl:yellow,\
#header:blue,\
#info:202,\
#pointer:196,\
#prompt:magenta,\
#hl+:red"
#"
. "$HOME/.cargo/env"
