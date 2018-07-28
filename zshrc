## Language Setting

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv > /dev/null;
  then eval "$(pyenv init -)";
fi

# vim python plugin
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Java 1.8
# export JAVA_HOME=$(/usr/libexec/java_home)
# export PATH=$JAVA_HOME/bin:$PATH

# Scala 2.12.4
# export SCALA_HOME="$HOME/scala-2.12.4"
# export PATH="$SCALA_HOME/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

## Shell Prompt
# export PS1='%n@%m[ %/ ]$ '
# export PS1='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='%F{250}%n:%f %F{075}%/%f $ '

## Colors

export CLICOLOR='true'
export LSCOLORS='gxfxcxdxcxegedabagacad'

## alias
alias ls='ls -G'
alias ll='ls -lG'
alias lt='ls -ltrG'
alias ..='cd ..'
alias grep='grep --color=auto'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias jupy='jupyter notebook'

## git alias
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gp='git push origin master'
alias glog='git log --color --graph'
