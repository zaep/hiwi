#!/bin/bash

su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-6-8.noarch.rpm'
sudo yum update
sudo yum install R
