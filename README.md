Toolchain example #5
====================

This example shows how to automate application build and deployment using a loosely-coupled toolchain

Application
-----------
 
DTO Lab's fork of the [Seam Examples](https://github.com/dtolabs/seam-examples) Booking application running on JBoss with MySQL.

Infrastructure
--------------

A single pre-provisioned Red Hat Linux (tested on "CentOS release 6.2") instance for build, repository, deployment, application and database services.

Toolchain
---------

* Souce code management: GitHub/Git
* Build tool: Maven and Rerun
* Build console: Jenkins
* Package format: RPM
* Package repository: Jenkins
* Deployment console: Rundeck
* Modular automation: Rerun

Requirements
------------

* System requirements:
** 2GB RAM, 8 GB disk
** 64-bit CentOS Linux 6.2 or later
** Internet access (to GitHub and standard Yum repositories)

* User requirements:
** Non-root user account ...
** ... with sudo access to run any command as root without a password (e.g. wheel group membership)

* Repositories:
** Configure the [EPEL repository](http://dl.fedoraproject.org/pub/epel/6/x86_64/repoview/epel-release.html). e.g:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
Retrieving http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
warning: /var/tmp/rpm-tmp.4fSCLZ: Header V3 RSA/SHA256 Signature, key ID 0608b895: NOKEY
Preparing...                ########################################### [100%]
   1:epel-release           ########################################### [100%]
</pre>
** Configure the latest version of the [Rerun modules repository](https://github.com/rerun-modules/rerun-modules/downloads). e.g:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo rpm -Uvh https://github.com/downloads/rerun-modules/rerun-modules/rerun-modules-repo-1.0-3.noarch.rpm
Retrieving https://github.com/downloads/rerun-modules/rerun-modules/rerun-modules-repo-1.0-3.noarch.rpm
Preparing...                ########################################### [100%]
   1:rerun-modules-repo     ########################################### [100%]
</pre>

* Git setup:
** Install git:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo yum -y install git
.
.
.
Complete!
[anthony@centos63-toolchain-example5 ~]$ git --version
git version 1.7.1
</pre>
** Clone the [Toolchain Example #5](https://github.com/dtolabs/toolchain-example5) repository:
<pre>
[anthony@centos63-toolchain-example5 ~]$ mkdir src
[anthony@centos63-toolchain-example5 ~]$ cd src
[anthony@centos63-toolchain-example5 src]$ git clone git@github.com:dtolabs/toolchain-example5.git
Initialized empty Git repository in /home/anthony/src/toolchain-example5/.git/
remote: Counting objects: 90, done.
remote: Compressing objects: 100% (38/38), done.
remote: Total 90 (delta 22), reused 87 (delta 19)
Receiving objects: 100% (90/90), 4.04 MiB | 1.48 MiB/s, done.
Resolving deltas: 100% (22/22), done.
</pre>

Anthony Shortland
anthony@dtosolutions.com
