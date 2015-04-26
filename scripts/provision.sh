#!/bin/bash

### Functions
profile_setup() {
  
NPMPROFILE=$(cat << 'EOF'
# bash_profile

# if running bash
if [ -n "$BASH_VERSION" ]; then
# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi
fi

# setup bash prompt
if [ -n "$BASH_VERSION" ]; then
# include .bash_prompt if it exists
if [ -f "$HOME/.bash_prompt" ]; then
. "$HOME/.bash_prompt"
fi
fi

# set PATH so it includes user\'s private bin if it exists
if [ -d "$HOME/bin" ] ; then
PATH="$HOME/bin:$PATH"
fi
#
# Nodejs NO-Sudo path and grunt-cli
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/local/lib/node_modules/grunt-cli/bin:$PATH"

# Ruby daddy
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Defaulting to work folder
cd ~/html-newsletter
EOF
)
  if [[ ! -f ~/.bash_profile ]]; then
    touch ~/.bash_profile
    echo "${NPMPROFILE}" >> ~/.bash_profile
    source ~/.bash_profile
fi
}

phpmailer_install() {
  if [[ ! -d ~/html-newsletter/PHPMailer ]]; then
    cp /vagrant/lib/index.php ~/html-newsletter/
    git clone https://github.com/PHPMailer/PHPMailer.git ~/html-newsletter/PHPMailer
  else
    echo "PHPMailer is present"
fi
}

nodejs_install() {
  if hash npm 2>/dev/null; then
    echo "Nodejs and npm already installed."
  else
    mkdir ~/node-latest-install
    cd ~/node-latest-install
    curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
    ./configure --prefix=/home/vagrant/local
    make install -s # ok, fine, this step probably takes more than 30 seconds...
    curl -L https://npmjs.org/install.sh | sh
fi
}

grunt_install() {
  if hash grunt 2>/dev/null; then
    echo "Grunt is installed."
  else
    echo "Installing Grunt"
    npm install -g grunt-cli
fi
}

ruby_install() {
  if [[ ! -d ~/.rbenv ]]; then
    git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    rbenv install 2.1.5
    rbenv rehash
    rbenv global 2.1.5
    rbenv rehash
  else
    echo "Ruby is installed."
fi
}

### Script
echo "Starting sudoless provision script in 5 seconds."
echo "This script will take a while, maybe go for a walk or clean some dishes?"
sleep 5
echo " "
echo "Setting up bash profile..."
profile_setup
echo " "
echo "Installing Ruby..."
ruby_install
echo " "
echo "Installing sudoless NodeJS and Grunt..."
nodejs_install
grunt_install
echo " "
echo "Installing PHPMailer..."
phpmailer_install
echo " "
echo "Sudoless provision script finished. Moving on..."

