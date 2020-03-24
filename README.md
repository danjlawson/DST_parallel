# Overview of parallel processing

In this session we create a parallel processing architecture that everyone can use. It is preferable to use the University High Performance Computing infrastructure, but that might be difficult for everyone to access. This is an alternative pipeline that will work on any computer, be it PC, mac, or linux.

The process that we are using will translate almost directly into BlueCrystal. It will also work on any commercial computer. The important reason to run things in the scripts as we do here, and not e.g. in a notebook, is that we can then genuinely scale the analysis up by moving it to a parallel architecture. You can have a jupyter notebook connect to a parallel backend via YARN but this is an engineering challenge to set up.

## Overview and sources

We will use two tools to create our environment:

* [VirtualBox](https://www.virtualbox.org/) : VirtualBox allows you to install an operating system as "software" on your computer as a "Virtual Machine". By doing this, we will all have the exact same version of Ubuntu on our computers.
* [Vagrant](www.vagrantup.com) : Vagrant allows us to script the creation of Virtual Machines so that we can all guarantee having the same setup, without having too much interactive installation etc to remember. It uses VirtualBox to create the virtual machine.

You will need to install both of these pieces of software for your normal operating system to proceed.

## Getting started

1. **GET THIS CODE**: Download [DST_parallel](https://github.com/danjlawson/DST_parallel), either as a git repostiory using ``git clone`` or as a zip file. Unzip it into a new directory.
2. **GET THE SOFTWARE**: Download [VirtualBox](https://www.virtualbox.org/) and  [Vagrant](https://www.vagrantup.com) .  You don't actually have to run VirtualBox yourself, though you can if you want to get a graphical display. Ensure that it runs and close it. Take a look at the [Vagrant Getting Started](https://www.vagrantup.com/intro/getting-started/).
3. **CREATE YOUR BOX**: Run ``vagrant up`` in the directory you downloaded things into. Look at the [Vagrantfile](Vagrantfile). This tells Vagrant what type of operating system we want. You are getting Ubuntu. It also calls [bootstrap.sh](bootstrap.sh) which will be used the first time that you create this virtual computer.
4. **SSH TO YOUR BOX**: Run ``vagrant ssh`` to get into the new box.
5. **HADOOP**: Follow the instructions in [README_hadoop.sh](README_hadoop.sh). These should be pasted one-by-one into the console of your vagrant box, and try to understand them as you go.
6. **PYSPARK**: Follow the instructions in [README_hadoop.sh](README_pyspark.sh). These should be pasted one-by-one into the console of your vagrant box, and try to understand them as you go. Note that it assumes that you have already run [README_hadoop.sh](README_hadoop.sh).

## Comments

* There are some interactive components of the scripts, so do read the comments.
* Over time, external links may become broken. Please examine the reason why you are sent to the link and check that it 

## Running without VirtualBox

If you are running on linux or mac, there is no requirement to install a virtual machine. However it may not work for a variety of reasons. Common ones:

* **JAVA**: You must have java 8 for spark, which is **not** the most recent version (11 at time of writing).
* **ANACONDA/PYTHON**: You can get pyspark working in several ways, including via jupyter notebooks, as well as using pip. Doing this could be non-trivial.
* **VIRTUAL MACHINE PROVISIONING**: You can give your virtual machine more memory, more CPUs etc by editing the Vagrantfile.
