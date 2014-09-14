# An instant build environment for RLSD using Vagrant

Follow these instruction to create a virtualized build environment and build RLSD within it on Linux as well as OS X and Windows (untested).

1\. Install VirtualBox and [Vagrant](https://www.vagrantup.com/downloads.html).

2\. Run the following commands in the terminal from `rlsd/vagrant-build-environment` (the directory in which you found this README file):

```
vagrant box add ubuntu/trusty32
vagrant box add ubuntu/trusty64
```

Then depending on whether you want to produce a 32-bit or a 64-bit build of RLSD run either

```
# i686
vagrant up v32
```

or

```
# x86_64
vagrant up v64
```

This will start the automatic process of provisioning an Ubuntu 14.04 virtual machine (VM) to build RLSD in and building RLSD within it.

To build both (using twice the RAM) run

```
# i686 _and_ x86_64
vagrant up v32 v64
```

3\. Wait. It will take a while to build the ISO disc images. By the end of the process .iso files will appear in `rlsd/releases`.

4\. (optional) To work interactively in a build environment VM type

```
vagrant ssh v32
```

or

```
vagrant ssh v64
```

5\. Destroy the build VM with

```
vagrant destroy
```

Note that this will **delete all the data stored on the VM(s)**. This is done to ensure a clean build each time that is not affected by the artifacts of a previous build.
