#! /bin/bash

# Install Git first:
# install-git.sh
# Install pip. pip can be used to install python packages if missing packages are reported by GateOne
# sudo easy_install python-pip
cd
mkdir GateOne
cd GateOne
git clone https://github.com/liftoff/GateOne.git
sudo python setup.py install