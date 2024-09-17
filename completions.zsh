# +--------------------+
# | Custom Completions |
# +--------------------+


# +---------+
# | General |
# +---------+

FPATH="$ZDOTDIR/MyCompletions:$FPATH"

# Should be called before compinit
zmodload -i zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char 
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^[[D' vi-backward-char
bindkey -M menuselect '^[[A' vi-up-line-or-history
bindkey -M menuselect '^[[B' vi-down-line-or-history
bindkey -M menuselect '^[[C' vi-forward-char

bindkey -M menuselect '^g' clear-screen
bindkey -M menuselect '^i' vi-insert                      # Insert
bindkey -M menuselect '^h' accept-and-hold                # Hold
bindkey -M menuselect '^n' accept-and-infer-next-history  # Next
bindkey -M menuselect '^[[Z' undo                         # Undo
bindkey -M menuselect '^[[1;16E' redo                     # Redo


autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

#compdef -k _additionalCommandCompletions menu-select '^f'
# or

# Saved Configurations of different commands.
zle -N widgetThatBindsSavedCommandCompleterWidget
widgetThatBindsSavedCommandCompleterWidget() {

    ZLS_COLORS="ma=48;5;244;38;5;202:=(#b) #(find#)*( * )*=38;5;252=38;5;31:=(#b) #(history#)*( * )*=38;5;254=38;5;31:=(#b) #(builtin#)*( * )*=38;5;254=38;5;31:=(#b) #(echo#)*( * )*=38;5;254=38;5;31:=(#b) #($PREFIX#)*(-?*)*( *[[:graph:]])*=38;5;31=38;5;252=38;5;252:=(#b) #(tr#)*( ',')*=38;5;252=38;5;31:=(#b) #(awk#)*( '{)*=38;5;252=38;5;31:=(#b) #(mv~man#)*( * )*=38;5;252=38;5;31:=(#b) #(touch#)*( * )*=38;5;252=38;5;31:=(#b) #(gunzip#)*( * )*=38;5;252=38;5;31:=(#b) #(ls~locate#)*( * )*=38;5;252=38;5;31:=(#b) #(local~locate#)*( * )*=38;5;252=38;5;31:=(#b) #(cp~c#)*( * )*=38;5;252=38;5;31:=(#b) #($PREFIX#)*( *[[:graph:]])*=38;5;31=38;5;252=38;5;252:=(#b) *=38;5;31=38;5;252:=*=38;5;31:"
    local initialBufferContents="$BUFFER"
    
     local firstArg
    
     local index=1

     while [[ -z $firstArg ]];
     do
         firstArg="$(echo ${LBUFFER} | rev | cut -d ' ' -f $index | rev )"
         ((index++))
     done

     BUFFER="${BUFFER:#*}"


    export SELECTEDWORD=$firstArg


    zle savedCommands

    # # Parse BUFFER for occurences of the SELECTEDWORD and output it as a string to a variable.
    # local checkForDuplicates="$(echo ${BUFFER} | grep -oE "$SELECTEDWORD")"
    #
    # # Split the string at newline into an array.
    # typeset -a arr=("${(f)checkForDuplicates}")
    #
    # local numberOf_Occurrences=${#arr[@]}
    # ((numberOf_Occurrences -= 1))
    #
    # if [[ $BUFFER =~ "$SELECTEDWORD $SELECTEDWORD" ]]; then
    #     #BUFFER=$(echo $BUFFER | tr -d '\' | sed "s/$SELECTEDWORD//$numberOf_Occurrences")
    #     BUFFER=$(echo $BUFFER | sed "s/$SELECTEDWORD//$numberOf_Occurrences")
    # fi
    #
    # #BUFFER=$(echo $BUFFER | sed -E 's/(\\)//g')
    #
    # BUFFER="${BUFFER#* }"
    #
    # BUFFER="$initialBufferContents$BUFFER"

    BUFFER="${BUFFER//\\/}" #Remove backslashes from buffer.

    CURSOR=${#BUFFER} #Remove duplicates.

    unset $SELECTEDWORD
}
source /Users/kurama/.config/.zsh/MyCompletions/_favCommandConfigsCompletions
zle -C savedCommands menu-select _favCommandConfigsCompletions
bindkey '^f' widgetThatBindsSavedCommandCompleterWidget

# Long Help Widget
zle -C additionalCommandCompletionsWidget menu-select _generic
# Binds completion widget to "option + f".
bindkey '^n' additionalCommandCompletionsWidget 
zstyle ':completion:additionalCommandCompletionsWidget::::' completer _additionalCommandCompletions


# Source the completions so zle line editor can use them. You do not have to source again if the completions were being used by themselves without zle.
source /Users/kurama/.config/.zsh/MyCompletions/_myHistoryCompletions
# Line Editor Widget That calls the History Completer Widget.
zle -N widgetThatBindsKeyToCustomHistoryCompleterWidget
widgetThatBindsKeyToCustomHistoryCompleterWidget() {

    ZLS_COLORS="ma=48;5;244;38;5;202:=(#b) #(find#)*( * )*=38;5;252=38;5;31:=(#b) #(history#)*( * )*=38;5;254=38;5;31:=(#b) #(builtin#)*( * )*=38;5;254=38;5;31:=(#b) #(brew#)*( * )*=38;5;254=38;5;31:=(#b) #(echo#)*( * )*=38;5;254=38;5;31:=(#b) #($PREFIX#)*(-?*)*( *[[:graph:]])*=38;5;31=38;5;252=38;5;252:=(#b) #(tr#)*( ',')*=38;5;252=38;5;31:=(#b) #(awk#)*( '{)*=38;5;252=38;5;31:=(#b) #(mv~man#)*( * )*=38;5;252=38;5;31:=(#b) #(touch#)*( * )*=38;5;252=38;5;31:=(#b) #(gunzip#)*( * )*=38;5;252=38;5;31:=(#b) #(ls~locate#)*( * )*=38;5;252=38;5;31:=(#b) #(local~locate#)*( * )*=38;5;252=38;5;31:=(#b) #(cp~c#)*( * )*=38;5;252=38;5;31:=(#b) #($PREFIX#)*( *[[:graph:]])*=38;5;31=38;5;252=38;5;252:=(#b) *=38;5;31=38;5;252:=*=38;5;31:"

    if [[ -n $LBUFFER ]]; then
         local firstArg

         local index=1
         while [[ -z $firstArg ]];
         do
             firstArg="$(echo ${LBUFFER} | rev | cut -d ' ' -f $index | rev )"
             ((index++))
         done

         ESCAPED_BUFFER=$(echo $firstArg | sed -e 's/[][\/.^$*+?()|{}]/\\&/g')
         
        # Parse BUFFER for occurences of the SELECTEDWORD and output it as a string to a variable.
        local checkForDuplicates="$(echo ${BUFFER} | grep -oE "$ESCAPED_BUFFER")"

        # Split the string at newline into an array.
        typeset -a arr=("${(f)checkForDuplicates}")
        
        local initialNumberOfOccurrences=${#arr[@]}
        ((initialNumberOfOccurrences -= 1))
        
        export SELECTEDWORD=$ESCAPED_BUFFER

        BUFFER="${BUFFER:#*}"
    fi

    zle completeFromHistoryWidget
    

    if [[ $SELECTEDWORD ]]; then

        # Parse BUFFER for occurences of the SELECTEDWORD and output it as a string to a variable.
        checkForDuplicates="$(echo ${BUFFER} | grep -oE "$SELECTEDWORD")"

        # Split the string at newline into an array.
        arr=("${(f)checkForDuplicates}")
        
        local numberOf_Occurrences=${#arr[@]}
        ((numberOf_Occurrences -= 1))


        if [[ ${#arr[@]} -gt 1 ]]; then

            if [[ $numberOf_Occurrences -gt $initialNumberOfOccurrences ]]; then
                BUFFER=$(echo $BUFFER | tr -d '\' | sed "s/$SELECTEDWORD//$numberOf_Occurrences")
            fi

        fi

        # if [[ -n $SELECTEDWORD ]]; then
        #     unset $SELECTEDWORD
        # fi
    fi
    BUFFER=$(echo $BUFFER | tr -d '\')

    # Removing trailing two characters from BUFFER.
    BUFFER=$BUFFER[1,-2]
}
# History Completer Widget
zle -C completeFromHistoryWidget menu-select _myHistoryCompletions
bindkey '^[[A' widgetThatBindsKeyToCustomHistoryCompleterWidget
zstyle ':completion:widgetThatBindsKeyToCustomHistoryCompleterWidget::::' completer _myHistoryCompletions
zstyle ':completion:widgetThatBindsKeyToCustomHistoryCompleterWidget:_myHistoryCompletions:::' format ' %F{202}--%f %F{214}%d%f %F{202}--%f'
#bindkey '^h' _myHistoryCompletions


zle -C alias-expansion complete-word _expand_alias
bindkey '^o' alias-expansion
zstyle ':completion:alias-expension:*' completer _expand_alias


# Complete the name of the most recently modified file matching the pattern on the command line (which may be blank). if given a numeric argument N, complete the Nth most recently modified file.
zle -C mostRecentlyModifiedFileWidget menu-select _most_recent_file
bindkey '^w' mostRecentlyModifiedFileWidget


# autoload -U incremental-complete-word
# zle -N incremental-complete-word
# bindkey '^x' incremental-complete-word


# Corrector Completer Widget
zle -C correctorWidget menu-select _correct_word
bindkey '^y' correctorWidget
zstyle ':completions:correctorWidget:correct:rcat::' completer _correct _approximate


# +---------+
# | Options |
# +---------+
setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.


# +---------+
# | zstyles |
# +---------+
setopt AUTO_LIST


# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _match _ignored _correct _approximate _prefix 

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification

zstyle ':completion:*' verbose, auto-description

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'



#Here 244 is the background color (grey) and 255 is the foreground color (white). Other numbers say "here comes the background/foreground color". You should not change these.
#ZLS_COLORS="ma=48;5;244;38;5;255"

#https://www.reddit.com/r/zsh/comments/1408avn/changing_the_highlight_background_colour_of_the/
#green foreground (38;2;0;255;0) on red background (48;2;255;0;0):
#ZLS_COLORS="ma=48;2;255;0;0;38;2;0;255;0"


# Following configurations set colored output for completions.
# Sets color for "corrections" completions.
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# Sets color for "descriptions" completions.
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
# Sets color for "messages" completions.
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
# Sets color for "warnings" completions.
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Params are deliminated by ":". The first param enables Fish-Like Partial Completion Coloring but ignores "-". The second param sets the color of the completion suggestion being hoverd over. The last param one uses LS_COLORS to set the colors for folders and files in completion suggestions.
zstyle -e ':completion:*:*:*:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX~-)*=38;5;254=38;5;31}:ma=48;5;244;38;5;202:${(s.:.)LS_COLORS}:=(#b)([^-])=38;5;1")';

# Sets colors for the completion suggestions for options.
zstyle ':completion:*:*:*:*:options' list-colors '=(#b)(-[[:graph:]]| -[[:graph:]])*( --)*=38;5;254=38;5;31=38;5;244' '=(#b)(--[![:alpha:]]*)#*=38;5;31=38;5;254'

# Sets colors for the completions suggestions of kill command.
zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'

# Sets the colors for completions that do not use "zstyle". Usually applies to completions directly added using "compadd" function. Deliminated by ":".
#ZLS_COLORS="ma=48;5;244;38;5;202:=(#b) #(find#)*( * )*=38;5;252=38;5;31:=(#b) #(history#)*( * )*=38;5;254=38;5;31:=(#b) #(builtin#)*( * )*=38;5;254=38;5;31:=(#b) #(echo#)*( * )*=38;5;254=38;5;31:=(#b) #($PREFIX#)*(-?*)*( *[[:graph:]])*=38;5;31=38;5;252=38;5;252:=(#b) #(tr#)*( ',')*=38;5;252=38;5;31:=(#b) #(awk#)*( '{)*=38;5;252=38;5;31:=(#b) #(mv~man#)*( * )*=38;5;252=38;5;31:=(#b) #(touch#)*( * )*=38;5;252=38;5;31:=(#b) #(gunzip#)*( * )*=38;5;252=38;5;31:=(#b) #(ls~locate#)*( * )*=38;5;252=38;5;31:=(#b) #(local~locate#)*( * )*=38;5;252=38;5;31:=(#b) #(cp~c#)*( * )*=38;5;252=38;5;31:=(#b) #($PREFIX#)*( *[[:graph:]])*=38;5;31=38;5;252=38;5;252:=(#b) *=38;5;31=38;5;252:=*=38;5;31:"
#ZLS_COLORS=":=(#b) #($words[1]#)*( *[[:graph:]])*=38;5;31=38;5;252=38;5;252:"

#zstyle ':completion:*:*:(docker|brew):*' list-colors '=(#b)([a-zA-Z]*)*(---~--- | -- Generate*)*=38;5;254=38;5;31=38;5;244' '=(#b)(--[![:alpha:]]*)#*=38;5;31=38;5;254'
zstyle ':completion:*:*:(docker|brew):*' list-colors '=(#b)([a-zA-Z]*)*(---~--- )*=38;5;254=38;5;31=38;5;244'  '=(#b)(--[![:alpha:]]*)#*=38;5;31=38;5;254'
zstyle ':completion:*:*:(docker|brew):*' list-separator '---'

# Sets the general color for descriptions used by completion suggestions.
zstyle ':completion:*' format ' %F{202}--%f %F{214}%d%f %F{202}--%f'


### Cant use '^c' '^d' '^m' '^l' '^z'
