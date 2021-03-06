# Aliases
alias py=python3
alias py2=python
alias pip=pip3
alias g='git'
alias gst='git status -s'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdt='git difftool -y'
alias gl='git pull'
alias glr='git pull --rebase'
alias gp='git push'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcm='git checkout master'
alias gr='git remote'
alias grv='git remove -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate --color'
alias glog='git log --oneline --decorate --color --graph'
alias gss='get status -s'
alias ga='git add'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias gsup='git standup'

alias myip='curl -s https://ipv4.myip.info/ | pbcopy'

# remove the gf alias
alias gf='git ls-files | grep'

alias gpoat='git push origin --all & git push origin --tags'
alias gpft='git push --follow-tags'
alias gmt='git mergetool --no-prompt'

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gtsp='git stash pop'
alias gtsd='git stash drop'

# Will cd into the top of the current repository
# or submodule.
alias groot='cd $(git rev-parse --show-toplevel || echo ".")'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

alias gsr='git svn rebase'
alias gsd='git svn dcommit'

# these aliases commit and uncommit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'

# these alias ignore changes to file
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'

# list temporarily ignored files
alias gignored='git ls-files | grep "^[[:lower:]]"'

# Quality of life
alias cls='clear'
alias c='cat'
alias l='ls -lh'
alias s='ls -lh'
alias ls='ls -lh'
alias ll='ls -lh'
alias lsa='ls -lah'
alias lxl='lxc list -c ns4tS'
alias tb='nc termbin.com 9999'
alias tbc='nc termbin.com 9999 | xclip -selection c'

function lxcon {
  lxc exec $1 -- sudo --login --user ubuntu
}

function lxfp {
  lxc file push $2 $1/$3
}

# tdc-ssh
function tssh {
  DOMAIN=''

  host $1.yousee.idk 2>&1 >/dev/null
  if [ $? == 0 ]; then
    DOMAIN='.yousee.idk'
  fi

  HOST=$1$DOMAIN

  # Variable to grep password from keychain
  SSHPASSWORD=$(security find-generic-password -l TDC_LDAP -gw)

  # Test if host exist in tdc_keyadded, otherwise we will transfer it with ssh-copy-id
  grep $HOST ~/.ssh/tdc_keyadded >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    sshpass -p"$SSHPASSWORD" ssh-copy-id -i ~/.ssh/id_tdc-rsa.pub $HOST >/dev/null 2>&1
    echo $HOST | tee -a ~/.ssh/tdc_keyadded >/dev/null 2>&1
  fi

  # We now try to ssh with public key only, if that fails we will use sshpass to log us in
  ssh -o PreferredAuthentications=publickey -o PubkeyAuthentication=yes $HOST
  if [ $? -ne 0 ]; then
    sshpass -p"$SSHPASSWORD" ssh sf@$HOST
  fi
}

# Open folder in Files
alias od='xdg-open . &'

# SSH Tunnel
function tnl {
  ssh -fNL $2:localhost:$2 $1
}

# List all Tunnels
function ltnl {
  ps -ax | grep fNL | grep -v "grep"
}

# Kill all Tunnels
function ktnl {
  ps -ax | grep fNL | grep -v "grep" | awk '{print $1}' | xargs kill
}

# gnupg key handling
SSH_AUTH_SOCK=/run/user/$(id -u)/gnupg/S.gpg-agent.ssh

# Opxdg-open current repository location in github web
function web {
  git_root=$(git rev-parse --show-toplevel)
  cur_dir=$(pwd)
  git_path=${cur_dir#$git_root} 
  origin=$(git config --get remote.origin.url)
  origin=${origin/://}
  origin=${origin:4}
  origin=${origin%????}
  branch=$(current_branch)
  git_url="https://"${origin}"/tree/"${branch}${git_path}
  open -a "Google Chrome" ${git_url}
}

# List which files are different between current and specified branch
function gfd { #git-file-diff
git diff --name-status $1..$(current_branch)
}

# Functions
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# Will return the current repository name
#
function current_repository {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | git -d':' -f 2)
}

# Creates a commit with the branch name prefixing the message
# 
function gsc {
  this_branch=$(current_branch)
  git commit -m "$(echo $this_branch | awk -F '-' '{print $1"-"$2" -"}') $1"
}
# Creates a commit with the branch name prefixing the message and pushes it 
#
function gcp {
  gsc $1
  git push
}

function gpsu {
  git push --set-upstream origin $(current_branch)
}

# Lists all unmerged changes in all branches
#
function gcl {
  cb=$(current_branch)
  echo "List all changes not merged to $cb"
  for b in $(git branch -l)
  do
    if [[ $b == PRODUCTION* || $b == DEVOPS* ]] ;
	then
	  git checkout $b > /dev/null
	  echo "--- change log start ---"
	  changes=$(git cherry -v $cb)
	  if [[ -n "$changes" ]] ;
	  then
	    echo $(git cherry -v $cb)
	  else
	    echo "No changes on branch $b"
	  fi
	  echo "--- change log end ---"
	fi
  done
  git checkout $cb > /dev/null
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
alias ggpur='git pull --rebase origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'

# Pretty log messages
function _git_log_prettily {
 if ! [ -z $1 ]; then
   git log --pretty=$1
 fi
}
alias glp='_git_log_prettily'

alias ghist='git log -20 --pretty=format:"%C(yellow)%h%Creset\\ %C(green)%ar%C(cyan)%d\\ %Creset%s%C(yellow)\\ [%cn]" --graph --decorate --all'

# Work In Progress (wip)
# These features allow to pause a branch 
# development and switch to another one (wip)
# When you want to go back to work just unwip it
#
# This function returns a warning if the current branch is a wip
function work_in_progress {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}

# Nuke a repository back to the working state
function gnuke {
    git checkout .
    git clean -xfd
}

# Pull all changes from all repositories in folder
alias ggpall='find . -type d -mindepth 1 -maxdepth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;'


# My awesome bash prompt
#
# ANSI CODES - SEPARATE MULTIPLE VALUES WITH ;
#
#  0  reset          4  underline
#  1  bold           7  inverse
#
# FG  BG  COLOR     FG  BG  COLOR
# 30  40  black     34  44  blue
# 31  41  red       35  45  magenta
# 32  42  green     36  46  cyan
# 33  43  yellow    37  47  white

if [[ ! "${prompt_colors[@]}" ]]; then
  prompt_colors=(
    "36" # information color
    "37" # bracket color
    "31" # error color
  )

  if [[ "$SSH_TTY" ]]; then
    # connected via ssh
    prompt_colors[0]="32"
  elif [[ "$USER" == "root" ]]; then
    # logged in as root
    prompt_colors[0]="35"
  fi
fi

# Inside a prompt function, run this alias to setup local $c0-$c9 color vars.
alias prompt_getcolors='prompt_colors[9]=; local i; for i in ${!prompt_colors[@]}; do local c$i="\[\e[0;${prompt_colors[$i]}m\]"; done'

# Exit code of previous command.
function prompt_exitcode() {
  prompt_getcolors
  [[ $1 != 0 ]] && echo " $c2$1$c9"
}

# Git status.
function prompt_git() {
  prompt_getcolors
  local status output flags branch
  status="$(git status -s 2>/dev/null)"
  [[ $? != 0 ]] && return;
  output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"
  [[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* \(detached from (.*)\)$/ ? print "($1)" : /^\* (.*)/ && print $1')"
  flags="$(
    echo "$status" | awk '{ count[$1]++;
            always_show="true"; 
            r=""; 
            a=0; m=0; u=0; d=0} END { for (word in count)
            if (word ~ "A") a=count[word]
            else if (word ~ "M") m=count[word]
            else if (word == "??") u=count[word]
            else if (word ~ "D") d=count[word]
            if (always_show == "true" || a > 0)
            r=r " \033[0;32m+"a
            if (always_show == "true" || m > 0)
            r=r " \033[1;33m!"m
            if (always_show == "true" || d > 0)
            r=r " \033[0;31m-"d
            if (always_show == "true" || u > 0)
            r=r " \033[0;33m?"u
        } END {print r}'
  )"
  if [[ "$flags" ]]; then
    output="$output$c1:$flags"
  fi
  echo "$c1[$c0$output$c1]$c9"
}

function prompt_venv() {
  if test -z "$VIRTUAL_ENV" ; then
    output=""
   else
     output="$c1[$c0`basename \"$VIRTUAL_ENV\"`$c1]"
   fi
   echo $output
}

# Maintain a per-execution call stack.
prompt_stack=()
trap 'prompt_stack=("${prompt_stack[@]}" "$BASH_COMMAND")' DEBUG

function prompt_command() {
  local exit_code=$?
  # If the first command in the stack is prompt_command, no command was run.
  # Set exit_code to 0 and reset the stack.
  [[ "${prompt_stack[0]}" == "prompt_command" ]] && exit_code=0
  prompt_stack=()

  # Manually load z here, after $? is checked, to keep $? from being clobbered.
  [[ "$(type -t _z)" ]] && _z --add "$(pwd -P 2>/dev/null)" 2>/dev/null

  # While the simple_prompt environment var is set, disable the awesome prompt.
  [[ "$simple_prompt" ]] && PS1='\n$ ' && return

  prompt_getcolors
  # http://twitter.com/cowboy/status/150254030654939137
  PS1="\n"
  # git: [branch:flags]
  PS1="$PS1$(prompt_git)"
  # misc: [cmd#:hist#]
  # PS1="$PS1$c1[$c0#\#$c1:$c0!\!$c1]$c9"
  # path: [user@host:path]
  PS1="$PS1$c1[$c0\u$c1@$c0\h$c1:$c0\w$c1]$c9"
  PS1="$PS1\n"
  # date: [HH:MM:SS]
  PS1="$PS1$(prompt_venv)$c1[$c0$(date +"%H$c1:$c0%M$c1:$c0%S")$c1]$c9"
  # exit code: 127
  PS1="$PS1$(prompt_exitcode "$exit_code")"
  PS1="$PS1 \$ "
}

PROMPT_COMMAND="prompt_command; history -a"

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add -A &> /dev/null;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

. ~/git-completion.bash
export PATH=/usr/local/aws/bin:$PATH
complete -C '/usr/local/bin/aws_completer' aws

