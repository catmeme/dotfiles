# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DISABLE_AUTO_TITLE="true"
#export SSH_AUTH_SOCK=/home/username/.ssh/id_rsa

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zed"

# zed theme allows THREE RPROMPT MODES:
# 0 - no right prompt, all git info in the left
# 1 - right prompt with git info, not async
# 2 - right prompt with git info, async
RPROMPT_MODE=1

# Autosuggest -- requires in order: zsh-syntax-highlighting zsh-autosuggestions
AUTOSUGGESTION="true"

# Faster, more descriptions, colored
ENHANCED_COMPLETION="true"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
plugins=(git z zsh-syntax-highlighting zsh-autosuggestions history-substring-search history-search-multi-word docker)

# User configuration

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export MANPATH="/usr/local/man:$MANPATH"
export PATH="$PATH":~/.node/bin
source $ZSH/oh-my-zsh.sh

# Detect OS
if [[ $(uname) == 'Linux' ]]; then
    export OS="linux"
elif [[ $(uname) == 'Darwin' ]]; then
    export OS="osx"
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Rehash after package install
zstyle ':completion:*' rehash true

# History
unsetopt share_history
setopt INC_APPEND_HISTORY

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias tmux='tmux -2'
alias apts='apt-cache search'
alias aptu='apt-get update'
# always going to sudo these
alias aptup='sudo apt-get upgrade'
alias aptud='sudo apt-get dist-upgrade'
alias apti='sudo apt-get install'
alias aptr='sudo apt-get remove'
alias aptp='sudo apt-get purge'
alias dco='docker-compose'
alias dcd='docker-compose down --remove-orphans'
alias lssh="grep 'Host ' ~/.ssh/config |cut -f2 -d ' '"

if [ -f $HOME/.private_aliases ]; then
    . $HOME/.private_aliases
fi

# fix VTE issues
bindkey -e
bindkey '^L' push-line
bindkey '^[[5C' forward-word
bindkey '^[[5D' backward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

rule() {
    _hr=$(printf "%*s" $(tput cols)) && echo ${_hr// /${1--}}
}

zshp_up() {
    for d in $(find ${HOME}/.oh-my-zsh/custom/plugins/ -maxdepth 1 -type d); do cd $d; git pull; cd -; done
}

delete_branch() {
    branch=$1
    git branch -d $branch
    if [[ "$status" == 0 ]]; then
        echo "Not deleting from origin until issues above are resolved"
        return 1
    else
        git push origin --delete $branch
    fi
}

list_merged() {
    for branch in `git branch -r --merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
}

list_unmerged() {
    for branch in `git branch -r --no-merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
}


if [[ ${OS} == "linux" ]]; then
    vboxshare() {
        sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) vbox-share ~/share
    }

    alias setclip='xclip -selection c'
    alias getclip='xclip -selection clipboard -o'
    alias atom='atom --enable-transparent-visuals --disable-gpu'

    source /etc/profile.d/vte.sh

    vboxclip() {
      pkill 'VBoxClient --clipboard' -f & sleep 1 && VBoxClient --clipboard
    }
fi

ssh_copy_id() {
    local ssh_connection=${1}
    local ssh_key=${2:-~/.ssh/id_rsa.pub}
    if [[ "${ssh_connection}" == "" ]]; then echo "ssh connection string required"; exit 1; fi
    cat ${ssh_key} | ssh ${ssh_connection} "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys"
}
