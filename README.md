# HTML Newsletter VM

A very rudimentary Vagrant virtual machine to automate (responsive) HTML emails. Based on a previous installed machine which in turn was inspired by this article by Victor Garcia: https://medium.com/@victorgarcia/a-workflow-for-responsive-emails-using-ink-and-grunt-32d607879082


##### REQUIREMENTS
* Vagrant - https://www.vagrantup.com/
* Virtualbox - https://www.virtualbox.org/


##### Instructions
* git-clone the repo
* Setup your SMPT credentials and other settings in 'index.php', additionally review Grunt modules settings in 'Gruntfile.js'
* run command `vagrant up --provision`
* watch the Matrix happen or do something else, it will take quite a long time to set up (roughly 30min. on my laptop)
* Once all set up, to run the following commands to inline your HTML and CSS as well as sending test mails with PHPMailer you will currently have to `vagrant ssh` into the box -you'll be taken straight to the working dir. The main commands are: 
 - `vagrant ssh -c "grunt email"` will uncss -> replace the old stylesheets with the uncss version -> inline the styles in your HTML markup. Every files build will be placed in the 'Dist' folder
 - after inlining your template run `vagrant ssh -c "php -f index.php"` to send a test email (providing you have configured the 'index.php' file before provisioning. cli alt: `vagrant ssh -c "vim index.php"` )

 **should you delete the vm and if you changed some confs back them up so to not rewrite them if you reinstall**

 **An [Ink] 1.0.5 is provided as example. Check it out!**
 
 
### Version
0.1        project revision: repo structure, project dir structure and template cleanups  
 
0.0.3      added getink.bat, update readme with vagrant ssh CLI commands

0.0.1      Initial

### Tech

The insides of the Vagrant VM uses a number of open source projects to work properly:

* [Ubuntu 14.04 box] - vagrant box
* [PHP 5.* CLI] - required for PHPMailer
* [PHPMailer] - for testing your freshly inlined email via SMTP or other
* [Node.js] - Sudoless! Just for NPM modules
* [Grunt.js] - for the following grunt/node modules:
 - [grunt-premailer] , [grunt-processhtml] , [grunt-uncss]
* [rbenv ruby] - required for Premailer gem and dependencies (nokogiri)
* [Premailer] - that magic tool that inlines our styles!


### Todo's

 - a bunch of things....
 
License 
----
Copyright 2015 Cristovao Verstraeten
*NYD : Not Yet Determined as in: 
I invented nothing... Contributing to the OSS this automation vm relies on is strongly encouraged, obviously improvements in any way on this repo itself is welcomed too~ )**


[Ubuntu 14.04 box]:https://atlas.hashicorp.com/ubuntu/boxes/trusty64
[PHP 5.* CLI]:http://php.net/
[Node.js]:http://nodejs.org
[Grunt.js]:http://gruntjs.com/
[rbenv Ruby]:https://github.com/sstephenson/rbenv
[PHPMailer]:https://github.com/PHPMailer/PHPMailer
[grunt-uncss]:https://github.com/addyosmani/grunt-uncss
[grunt-processhtml]:https://github.com/dciccale/grunt-processhtml
[grunt-premailer]:https://github.com/dwightjack/grunt-premailer
[Premailer]:https://github.com/premailer/premailer
[Ink]:http://zurb.com/ink/
