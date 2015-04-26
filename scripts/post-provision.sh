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
    else 
    source ~/.bash_profile
fi
}

dir_change() {
  cd ~/html-newsletter/
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

gem_install() {
  if [[ ! -d ~/.rbenv/versions/2.1.5/bin/nokogiri ]]; then
    gem install nokogiri premailer --no-document
    rbenv rehash
  else
    echo "No gems to be installed."
fi
}

module_install() {
  if [[ ! -d ~/html-newsletter/node_modules ]]; then
    cp /vagrant/lib/package.json ~/html-newsletter/
    cp /vagrant/lib/Gruntfile.js ~/html-newsletter/
    npm install
  else
    echo "Modules already installed."
fi
}


### Script
echo "Starting sudoless post-provision script in 5 seconds."
sleep 5
echo " "
echo "Performing installation checks..."
profile_setup
ruby_install
nodejs_install
grunt_install
phpmailer_install
echo " "
echo "Installing required gems and grunt modules..."
dir_change
gem_install
module_install
echo " "
echo "Installing all the other stuff... Time remaining: 12:07:42s"
sleep 1
echo " "
echo "No, just kidding! Sudoless provision script finished at last!"
echo "Thank you for your patience!"
echo "-Cris."
