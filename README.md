Widget The People GitMachine
============================

A dev GitMachine pre-configured with Nodejs and Widget The People.

# What's a GitMachine?

GitMachines are pre-configured, accreditation-ready virtual machines in support of open government, open data, and civic innovation.

GitMachines are open source and community maintained.

A "dev" GitMachine is a pre-configured virtual machine that is not yet accreditation-ready. It will run just fine even though the government compliance work is incomplete.

A "gov-ready" GitMachome is a pre-configure and accreditation-ready virtual machine. That means the OS (and as much as the stack as possible) is configured to follow federal government guidelines.

# What's This GitMachine do?

This dev GitMachine has everything you need to run Douglas Back's [Widget The People](https://github.com/douglasback/widget-the-people) Nodejs application.

This GitMachine depends on Vagrant(http://vagrantup.com) (software for creating lightweight, portable development environments) and VirtualBox(http://virtualbox.org) (virtualization software).


# Dependencies

1. A computer onto which you can install software. (Tested on Mac).
2. [Download & Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
3. [Download & Install Vagrant](http://downloads.vagrantup.com/)
 
# Install

1. Clone out opendatadevops/widget-the-people project `git clone git@github.com:OpenDataDevOps/widget-the-people.git`
2. Go into widget-the-people directory and boot up the vm (in terminal) `cd widget-the-people && vagrant up`
3. Be _patient_ while vagrant configures your GM. This can take 5 to 10 minutes or longer...
4. When vagrant finishes configuring your GM, open your browser and go to `http://localhost:5001` to access Widget the People
5. Get into the virtual machine (vm) via ssh `vagrant ssh`


# Use

1. `vagrant up` from the directory with this repository starts your vm and adds the correct configuration.
2. `http://localhost:5001` in your host computer browser brings up the Widget The People Nodejs application.
3. The code for Widget the People is in guest GM `/opt/widget-the-people` directory.

# What's Installed

- git
- Nodejs
- npm
- Widget The People

# Other Commands

* `vagrant halt` stops the minus guest vm.
* `vagrant reload` re-runs the configuration (and applies changes in the vagrant manifest) to the minus guest vm without re-establishing the base box.
* `vagrant destroy` blows away the minus guest vm and let's you start all over again. Just. Like. That!
