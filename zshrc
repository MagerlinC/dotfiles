export ZSH="$HOME/.oh-my-zsh"
export CDPATH=".:$HOME/git:$HOME/git/Cirrus"

eval "$(starship init zsh)"

# git/folder helpers
function github_project_root () {
  echo "https://github.$(git config remote.origin.url | cut -f2 -d. | sed 's/:/\//')"
}

function current_branch () {
  echo $(git symbolic-ref --quiet --short HEAD)    
}

function current_directory () {
  echo $(git rev-parse --show-prefix)
}

plugins=(git)

source $ZSH/oh-my-zsh.sh

GPG_TTY=$(tty)
export GPG_TTY

export RAVENDB_IMAGE=ravendb/ravendb:6.0.108-ubuntu.22.04-arm64v8

alias ddb="docker compose up -d --build -V sql sql_migrations ravendb database_seeder"
alias awsdaily="python3 ~/.aws/refreshMFA.py"
export LANG=en_US.UTF-8
export LANG=en_US.UTF-8
source <(fzf --zsh)
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

alias tmuxdev="~/dotfiles/dev-tmux.sh"

# Run CC BE stuff
alias devscript="dotnet run --project src/Scripts/Scripts --launch-profile Scripts.Scripts.Dev"
alias prodscript="dotnet run --project src/Scripts/Scripts --launch-profile Scripts.Scripts.Prod"

alias localrun="dotnet run --project CC.API --launch-profile Local-Docker-CC.API"
alias devrun="dotnet run --project CC.API --launch-profile Dev-CC.API"

tsapi () {
	cd "$(git rev-parse --show-toplevel)" || exit
	dotnet run --project ./backend/Utils/TsContractsGeneratorSwagger/TsContractsGeneratorSwagger.csproj
	cd - > /dev/null || exit
}

# Catpuccin zsh-syntax-highlighting
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#667c94"
source $ZSH/oh-my-zsh.sh

function search() {
  echo "Searching for: $@"
  search=$(echo $@ | sed 's/ /%20/g')

  open "https://duckduckgo.com/?q=$search"
}

function newpr () {
  open $(github_project_root)/pull/new/$(current_branch)/
}

function openpr () {
  open $(github_project_root)/pull/$(current_branch)/
}

set -o vi
