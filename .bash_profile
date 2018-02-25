alias ls='ls -G'
alias cp='cp -i'
alias rm='rm -vi'
alias ll='ls -l'

# use emacs daemon.
alias emacs='emacsclient -nw -c -a ""'
alias killemacs='emacsclient -e "(kill-emacs)"'

# web browser.
alias firefox='open -a Firefox'
alias chrome='open -a Google\ Chrome'

# MS Office.
alias mw='open -a Microsoft\ Word'
alias me='open -a Microsoft\ Excel'
alias mp='open -a Microsoft\ PowerPoint'

# other apps.
alias pv='open -a Preview'
alias finder='open -a finder'
alias dropbox='open -a Dropbox'
alias acroread='open -a Adobe\ Reader'
alias mi='open -a mi'
alias atom='open -a Atom'
alias jpy='jupyter qtconsole --matplotlib=inline --style=monokai'

# tmp
alias bzlbuild='bazel build --incompatible_comprehension_variables_do_not_leak=false --incompatible_disallow_set_constructor=false'
alias bzlrun='bazel run --incompatible_comprehension_variables_do_not_leak=false --incompatible_disallow_set_constructor=false'
alias bzltest='bazel test --incompatible_comprehension_variables_do_not_leak=false --incompatible_disallow_set_constructor=false'

source /usr/local/Cellar/git/2.11.0/share/zsh/site-functions/git-completion.bash
source /usr/local/Cellar/git/2.11.0/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[36m\]\h:\[\033[36m\]\W\[\033[m\]\$(__git_ps1)\[\033[00m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


#the path to cpanm when I used MacPorts
#export PATH=/opt/local/libexec/perl5.16/sitebin:$PATH

#path to the home directry.
export PATH=/Users/tenoritama:$PATH

##
# Your previous /Users/tenoritama/.bash_profile file was backed up as /Users/tenoritama/.bash_profile.macports-saved_2013-09-15_at_23:32:57
##

# MacPorts Installer addition on 2013-09-15_at_23:32:57: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#if [ -f ~/.bashrc ]; then
#    . ~/.bashrc
#fi

#if which plenv > /dev/null; then eval "$(plenv init -)"; fi

#old path to plenv(homebrew). This path was wrong and has repeated parts.
#export PATH=/usr/local/bin:/Users/tenoritama/.plenv/versions/5.16.3/bin:/Users/tenoritama/.plenv/versions/5.16.3/bin:/Users/tenoritama/.plenv/shims:/Users/tenoritama/.plenv/versions/5.16.3/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/texbin:$PATH

#This is new path using in plenv(install by using homebrew )
#export PATH=/Users/tenoritama/.plenv/versions/5.23.5/bin:$PATH

#apache installed using homebrew packege manager
export PATH=/usr/local/sbin:$PATH

# java home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home

# java class path
export CLASSPATH=/Library/Java/Extensions/

# scala home
export SCALA_HOME=/usr/local/opt/scala/libexec/

#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# 'go root' and 'go path'
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

# commnad which use for develop of dynalyst
export PATH="/Users/tenoritama/conv-command:$PATH"

# require at importing pandas in ipython
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# python path
export PYTHONPATH="/usr/local/Cellar/pyqt5/5.7/lib/python3.5/site-packages"
export PYTHONPATH="/usr/local/Cellar/sip/4.18.1/lib/python3.5/site-packages:$PYTHONPATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/tenoritama/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/tenoritama/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/tenoritama/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/tenoritama/google-cloud-sdk/completion.bash.inc'
fi

# path for opencv3
export PATH="/usr/local/opt/opencv3/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

# hub command.
eval "$(hub alias -s)"

# plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# kubectl bash completion
#source ~/.kubecompletion

#alias clang-omp='/usr/local/opt/llvm/bin/clang -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'
#alias clang-omp++='/usr/local/opt/llvm/bin/clang++ -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'
