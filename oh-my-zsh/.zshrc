# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=${PATH}:/usr/local/mysql/bin/

# Path to your oh-my-zsh installation.
export ZSH="/Users/zachdegeorge/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=( "crcandy" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
#else
#   export EDITOR='mate'
#fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Used for modifying oh-my-zsh
alias z='code ~/.zshrc'
alias -g Z='~/.zshrc'
alias -g _Z='.zshrc'
alias sourcez='clear;echo "[oh-my-zsh] Sourcing .zshrc file";location="$(pwd)";source Z;echo "[oh-my-zsh] Has been sourced";cd $location'
alias -g home='~/'

# Connect to BIGGBY Database Tunnel
alias db="~/Workspace/_environment/db-tunnel.sh"

# Open mySQL CLI 
alias mysql="mysql -u root -p"

# Used for quickly zipping directory and deleting zipped file
alias art="zip -rq artifact.zip ."
alias unart="rm artifact.zip"

# Install directory for Brew Packages
alias Cellar="/usr/local/Cellar"

# Function for quickly serving directory to localhost
function serve() {
	echo "[serve] Provided parameters: "$1
	if [ -z $1 ] || [ $1 = "help" ]
	then
		echo "Usage: serve <port #>"
		echo "Port #: Integer port number 1024-65535"
		echo "Example: serve 2222"
		echo "Please provide correct parameters and run again"
	else
		echo "[serve] Selected Port #: "$1
		open -a "Google Chrome" http://localhost:$1
		php -S localhost:$1
	fi	
}

# Function for quickly invalidating CloudFront DNS Cache
function purgedns() {
	clear
	script_location=~/Workspace/dev-tools/invalidate-cloudfront-cache
	echo "[purgedns] Provided parameters: "$1" "$2
	if [ -z $1 ] || [ -z $2 ] || [ $1 = "help" ] 
	then
		echo "Usage: purgedns <cloudfront id> <profile name>"
		echo "CloudFront Id: AWS CloudFront Distribution Id"
		echo "Profile Name: AWS EB CLI Profile Name w/ IAM Credentials"
		echo "Example: purgedns E2N6NVP4B675NK eb-cli"
		echo "Set profile in ~/.aws/config file"
		echo "Please provide correct parameters and run again"
	else
		location="$(pwd)"
		cd $script_location
		./run.sh $1 $2
		cd $location
	fi
}

# Function for scraping udemy courses
function udemy() { 
	location=$(pwd)
	echo "[udemy] Provided parameters: "$1" "$2
	if [ -z $1 ] || [ $1 = "help" ] 
	then
		echo "Usage: udemy <course name> <optional cookies>"
		echo "Course Name: Udemy course name from URL" 
		echo "Cookies (Optional): Path to cookies.txt file. Must be named cookies.txt"
		echo "If cookies is not provided then the cookies.txt file must be in the directory you call the script from\n"
		echo "Example 1: udemy understanding-bash-scripts /path/to/cookies.txt"
		echo "Example 2: udemy understanding-bash-scripts\n"
		echo "Please provide correct parameters and run again"
	else
		echo "Project selected: "$1
		
		if [ -z $2 ] && [ ! -e "cookies.txt" ]
		then
			echo "No cookies.txt file found at location $(pwd)"
			echo "Please provide a path to cookies.txt and run again."
		else
			[ -e "cookies.txt" ] && _cookie="cookies.txt" || _cookie=$2
			echo "Cookie path: "$_cookie
			echo "Config location: ~/.config/youtube-dl/config-udemy"
			echo "Config contents: "$(cat udemy-config)
			echo "Starting download..."
			youtube-dl --cookie $_cookie --config-location udemy-config -o '~/Movies/Udemy/'$1'/%(chapter_number)s - %(chapter)s/%(playlist_index)s-%(title)s.%(ext)s' https://www.udemy.com/$1
			echo "Finished."
		fi
	fi
	cd $location
}

# Function for scraping udemy courses
function youtube() {
	location=$(pwd)
	echo "[youtube] Provided parameters: "$1
	if [ -z $1 ] || [ $1 = "help" ] 
	then
		echo "Usage: youtube <youtube identifier>"
		echo "YouTube Identifier: From v= in URL" 
		echo "Example: youtube HOaEwQ85fG4"
		echo "Please provide correct parameters and run again"
	else
		echo "Identifier selected: "$1
		echo "Config location: ~/.config/youtube-dl/config"
		echo "Config contents: "$(cat youtube-config)
		echo "Starting download..."
		youtube-dl -o '~/Movies/YouTube/%(title)s.%(ext)s' $1
		echo "Finished."
	fi
	cd $location
}

# Function for scraping youtube playlists
function playlist() {
	location=$(pwd)
	echo "[playlist] Provided parameters: "$1
	if [ -z $1 ] || [ $1 = "help" ]
	then
		echo "Usage: playlist <playlist url>"
		echo "Playlist URL: URL"
		echo "Example: playlist https://www.youtube.com/playlist?list=PLuT2DqGFoFPQWrlw0PP3yxJIAidhM9Grl"
		echo "Please provide correct parameters and run again"
	else
		echo "Identifier selected: "$1
		echo "Config location: ~/.config/youtube-dl/config"
		echo "Config contents: "$(cat youtube-config)
		echo "Starting download..."
		youtube-dl -o '~/Movies/YouTube/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s' $1
		echo "Finished."
	fi
	cd $location
}

# Used for youtube-dl
alias -g youtube-config='~/.config/youtube-dl/config'
alias -g udemy-config='~/.config/youtube-dl/config-udemy'
alias -g cookie='cookies.txt'
alias -g cookietest='[ ! -z $(LC) ]'
alias -g LC='find ~/Downloads -type f -name "*.com_cookies.txt" | sort -n | head -n 1'
alias feedme='cookietest && [ -e $(LC) ] && cp $(LC) cookie;[ -e cookie ] && echo "You have been fed." || echo "No cookie for you."'
alias barf='cookietest && [ -e $(LC) ] && _barf=true || _barf=;cookietest && [ -e $(LC) ] && rm $(LC) || echo "You dont seem to have anything to barf up at the moment."; [ ! -z $_barf ] && echo "You have successfully barfed."'
alias eat='[ -e cookie ] && _unset=true || _unset=;[ -e cookie ] && rm cookie || echo "You dont seem to have any cookies at the moment."; [ ! -z $_unset ] && echo "Yum yum yum. Your cookies all gone..."; unset _unset'

# Note When cat an html file into another file now the html will be rendered
# Comment this line out if you want to disable this feature
# Must run brew install w3m to install browser
alias -s html=w3m

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g L='| less -N -S'
alias -g atime='ls -ltu'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
