#if [[ $TMUX ]]; then
#	neofetch
#fi

# if [[ -z "$TMUX" && -n "$ALACRITTY_WINDOW_ID" ]]
# then
#     tmux attach -t default || tmux new -s default
# fi

# +----------------+
# | POWERLEVEL 10K |
# +----------------+
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -r "${HOME:/.config/powerlevel10k/powerlevel10k.zsh-theme}" ]]; then
    source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
fi

[[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh

# Open in neovim.
#fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim


# +-----------+
# | OH MY ZSH |
# +-----------+
#plugins=(git docker)
#source $ZSH/oh-my-zsh.sh


# +------------+
# | Navigation |
# +------------+
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
# Access directory stack with the following command: $ dirs -v


# +---------+
# | History |
# +---------+
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# The following options can cause certain zsh-autosuggestion plugin strategies (match_prev_cmd & history).
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.


# +----------+
# | HOMEBREW |
# +----------+
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi



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


# +---------+
# | ALIASES |
# +---------+
source "$XDG_CONFIG_HOME/.zsh/aliases"

# +-----------+
# | VI KEYMAP |
# +-----------+
#set -o vi
bindkey -v
export KEYTIMEOUT=1

# Enable da" to delete a "quote and its contents", di" to delete the contents inside quotes.
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Zsh User Contrib: /usr/share/zsh/5.9/functions/surround (Have to be in normal mode in vim)

# Vim surround. Highlight in visual mode then press and quotes to surround with quotes.
autoload -Uz surround

zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# Zsh User Contrib: /usr/share/zsh/5.9/functions/incarg
# Increases any number by 1.
#autoload -Uz incarg
#zle -N incarg
#bindkey -M vicmd '^a' incarg

if [[ -n "$TERM_PROGRAM" && "$TERM_PROGRAM" == "iTerm.app" ]]; then
	cp "$HOME/Backups/zsh-syntax-highlighting.iterm2.bak" /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	test -e /Users/kurama/.config/.iterm2_shell_integration.zsh && source /Users/kurama/.config/.iterm2_shell_integration.zsh || true
else
	cp "$HOME/Backups/zsh-syntax-highlighting.alacritty.bak" /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	neofetch
fi


# +--------------+
# | AUTOCOMPLETE |
# +--------------+
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# +--------------------+
# | Custom Completions |
# +--------------------+
source "$ZDOTDIR/completions.zsh"


# +-------------+
# | KEYBINDINGS |
# +-------------+
source "$XDG_CONFIG_HOME/.zsh/keybindings.zsh"


# +---------------------+
# | Syntax Highlighting |
# +---------------------+
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


## History wrapper
function omz_history {
  # parse arguments and remove from $@
  local clear list stamp
  zparseopts -E -D c=clear l=list f=stamp E=stamp i=stamp t:=stamp

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    fc -p "$HISTFILE"
    echo >&2 History file deleted.
  elif [[ $# -eq 0 ]]; then
    # if no arguments provided, show full history starting from 1
    builtin fc $stamp -l 1
  else
    # otherwise, run `fc -l` with a custom format
    builtin fc $stamp -l "$@"
  fi
}

# Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
