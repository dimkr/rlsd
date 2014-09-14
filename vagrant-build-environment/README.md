# An instant build environment for RLSD using Vagrant

Follow these instruction to create a virtualized build environment and build RLSD within it on Linux as well as OS X and Windows (untested).

1\. Install VirtualBox and [Vagrant](https://www.vagrantup.com/downloads.html).

2\. Run the following commands in the terminal from `rlsd/vagrant-build-environment` (the directory in which you found this README file).

```
vagrant box add ubuntu/trusty32
vagrant box add ubuntu/trusty64
vagrant up
```

This will start the automatic process of provisioning a 32-bit and a 64-bit Ubuntu 14.04 virtual machine to build RLSD in and building RLSD within them.

3\. Wait. It will take a while to build the ISO disc images for both the i686 and the x86_64 version. By the end of the process .iso files will appear in `rlsd/vagrant-build-environment`.

4\. (optional) To work interactively in a build environment VM type

```
vagrant ssh v32
```

or

```
vagrant ssh v64
```

5\. Shut down the VMs with

```
vagrant down
```

6\. Next time run

```vagrant reload --provision```

to **delete** the content of the VMs and repeat the build process.
