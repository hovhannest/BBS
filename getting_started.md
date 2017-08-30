
Those who don't have Unix environment, such as Linux, BSD, OSX, will need to do one of the following, get a VM, or install Cygwin.


Installing Cygwin
=================

Download an installer from http://cygwin.com

When installing, choose the following software.

* base
* * everything (everything should be already chosen by default)

* devel
* * binutils
* * clang
* * gdb
* * gcc-core
* * gcc-c++
* * git
* * make

* editors
* * vim
* * you may also choose mc, nano

* utils
* * diffutils
* * dos2unix
* * patchutils

some of the assignments is possible to make with Python. Those who'd like, may want to choose

* python
* * python3
* * python3-pip

Installing VM image.
====================

Download VirtualBox software from https://www.virtualbox.org/wiki/Downloads

For Windows hosts you probably want http://download.virtualbox.org/virtualbox/5.1.26/VirtualBox-5.1.26-117224-Win.exe

I've prepared an OS image for you to work with.

It's located at http://lab.am/osp/

Save 'gentoo.zip' files somewhere.
Unzip it.

Run installed virtualbox.
Click New.

give it some name.

Choose Type - Linux, Version - Gentoo 32 bit.

Choose 'Use an existing virtual hard disk file' and open the file you've downloaded and unpacked.

This should be enough for starting it.

Start the machine, log in as user 'osp', password 'osp'.

Upon login, type 'startx' to start the graphical session.




Username: osboxes
Password: osboxes.org
Root Account Password: osboxes.org

Make sure you are able to login.
