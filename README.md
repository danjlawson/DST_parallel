# Overview of parallel processing

In this session we create a parallel processing architecture that everyone can use. It is preferable to sue the University High Performance Computing infrastructure, but that might be difficult for everyone to access. This is an alternative pipeline that will work on any computer, be it PC, mac, or linux.

The process that we are using will translate almost directly into BlueCrystal. It will also work on any commercial computer.

## Overview and sources

We will use two tools to create our environment:

* [VirtualBox](https://www.virtualbox.org/) : VirtualBox allows you to install an operating system as "software" on your computer as a "Virtual Machine". By doing this, we will all have the exact same version of Ubuntu on our computers.
* [Vagrant](www.vagrantup.com) : Vagrant allows us to script the creation of Virtual Machines so that we can all guarantee having the same setup, without having too much interactive installation etc to remember. It uses VirtualBox to create the virtual machine.

You will need to install both of these pieces of software for your normal operating system to proceed.

## Getting started

1. Download [DST_parallel](https://github.com/danjlawson/DST_parallel), either as a git repostiory using ``git clone`` or as a zip file. Unzip it into a new directory.
2. Download [VirtualBox](https://www.virtualbox.org/) and  [Vagrant](www.vagrantup.com) .  You don't actually have to run VirtualBox yourself, though you can if you want to get a graphical display. Ensure that it runs and close it. Take a look at the [Vagrant Getting Started](https://www.vagrantup.com/intro/getting-started/).
3. Run ``vagrant up`` in the directory you downloaded things into. Look at the ``Vagrantfile``. This tells Vagrant what type of operating system we want. You are getting Ubuntu. It also calls ``bootstrap.sh`` which will be used the first time that you create this virtual computer.
4. Run ``vagrant ssh`` to get into the new box.
5. Follow the instructions in [README_hadoop.sh](README_hadoop.sh) to get started

