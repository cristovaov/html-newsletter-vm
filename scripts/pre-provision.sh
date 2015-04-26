#!/bin/bash

### Functions
apt_update() {
  apt-get update -y
}

package_install() {
  apt-get install -y php5-cli git-core zip unzip ngrep curl make vim ntp gettext dos2unix g++ libssl-dev zlib1g-dev libreadline-dev libfontconfig
}

cleanup() { 
  apt-get purge -y ruby
  chown -Rf vagrant:vagrant /home/vagrant/html-newsletter/
}

### Script
echo "Welcome!Beginning pre-provision w/sudo script in 5 seconds."
sleep 5
echo " "
echo "Starting pre-provision with sudo..."
echo "Performing purging default installs of Ruby,"
echo "followed by the necessary update..."
echo " "
cleanup
apt_update
echo " "
echo "Installing required packages..."
package_install
echo " "
echo "One more update for the road..."
apt_update
echo " "
echo "Thank you for your patience."
echo "End of pre-provision w/sudo script. Moving on..."
echo " "