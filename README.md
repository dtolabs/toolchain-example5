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
    * 2GB RAM, 8 GB disk
    * 64-bit CentOS Linux 6.2 or later
    * Internet access (to GitHub and standard Yum repositories)
    * Disable firewall configuration:
<pre>
[root@centos63-toolchain-example5 ~]# chkconfig iptables off
[root@centos63-toolchain-example5 ~]# chkconfig ip6tables off
[root@centos63-toolchain-example5 ~]# service iptables stop
iptables: Flushing firewall rules:                         [  OK  ]
iptables: Setting chains to policy ACCEPT: filter          [  OK  ]
iptables: Unloading modules:                               [  OK  ]
^[[root@centos63-toolchain-example5 ~]# service ip6tables stop
ip6tables: Flushing firewall rules:                        [  OK  ]
ip6tables: Setting chains to policy ACCEPT: filter         [  OK  ]
ip6tables: Unloading modules:                              [  OK  ]
</pre>
    * Ensure the system's node name is a resovable hostname. e.g.:
<pre>
[anthony@centos63-toolchain-example5 ~]$ uname -n 
centos63-toolchain-example5
[anthony@centos63-toolchain-example5 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 centos63-toolchain-example5
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
</pre>

* User requirements:
    * Non-root user account ...
    * ... with sudo access to run any command as root without a password (e.g. wheel group membership)
    * ... sudo requiretty disabled to run any command without an interactive shell session (e.g. "Defaults requiretty" commented out)

* Repositories:
   * Configure the [EPEL repository](http://dl.fedoraproject.org/pub/epel/6/x86_64/repoview/epel-release.html). e.g:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
Retrieving http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
warning: /var/tmp/rpm-tmp.4fSCLZ: Header V3 RSA/SHA256 Signature, key ID 0608b895: NOKEY
Preparing...                ########################################### [100%]
   1:epel-release           ########################################### [100%]
</pre>
    * Configure the latest version of the [Rerun modules repository](https://github.com/rerun-modules/rerun-modules/downloads). e.g:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo rpm -Uvh https://github.com/downloads/rerun-modules/rerun-modules/rerun-modules-repo-1.0-3.noarch.rpm
Retrieving https://github.com/downloads/rerun-modules/rerun-modules/rerun-modules-repo-1.0-3.noarch.rpm
Preparing...                ########################################### [100%]
   1:rerun-modules-repo     ########################################### [100%]
</pre>

* Git setup:
    * Install git:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo yum -y install git 
.
.
.
Complete!
[anthony@centos63-toolchain-example5 ~]$ git --version
git version 1.7.1
</pre>

* Install rpm-build, mysql, mysql module and jboss-as module
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo yum -y install rpm-build mysql rerun-mysql rerun-jboss-as
.
.
.
Transaction Test Succeeded
Running Transaction
Warning: RPMDB altered outside of yum.
  Updating   : mysql-libs-5.1.66-1.el6_3.x86_64                                                                                                                                                 1/3 
  Installing : mysql-5.1.66-1.el6_3.x86_64                                                                                                                                                      2/3 
  Cleanup    : mysql-libs-5.1.61-4.el6.x86_64                                                                                                                                                   3/3 
  Verifying  : mysql-5.1.66-1.el6_3.x86_64                                                                                                                                                      1/3 
  Verifying  : mysql-libs-5.1.66-1.el6_3.x86_64                                                                                                                                                 2/3 
  Verifying  : mysql-libs-5.1.61-4.el6.x86_64                                                                                                                                                   3/3 

Installed:
  mysql.x86_64 0:5.1.66-1.el6_3                                                                                                                                                                     

Dependency Updated:
  mysql-libs.x86_64 0:5.1.66-1.el6_3                                                                                                                                                                

Complete!
</pre>


   * Clone the [Toolchain Example #5](https://github.com/dtolabs/toolchain-example5) repository:
   * NOTE:  for anonymous read-only access, use the read-only url: [git://github.com/dtolabs/toolchain-example5.git](git://github.com/dtolabs/toolchain-example5.git)
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

* Build and Install the booking-application-server and booking-database-server rerun modules
<pre>
[anthony@centos63-toolchain-example5 ~]$  cd toolchain-example5
[anthony@centos63-toolchain-example5 toolchain-example5]$ rerun  -M .  booking-application-server:install-module  --build true
[anthony@centos63-toolchain-example5 toolchain-example5]$ rerun  -M .  booking-database-server:install-module  --build true
</pre>

* Install Rerun and dependent modules:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo yum -y install rerun rerun-jenkins rerun-rundeck
.
.
.
Complete!
</pre>

* Deploy the toolchain build console:
<pre>
[chuck@mvn-sdp-0 toolchain-example5]$  rerun -M . toolchain-build-console: deploy
Shutting down Jenkins                                      [  OK  ]
Failed to set locale, defaulting to C
Failed to set locale, defaulting to C
Package rerun-rpm-1.0.0-25.noarch already installed and latest version
Failed to set locale, defaulting to C
Package rerun-apache-maven-1.0-8.noarch already installed and latest version
Failed to set locale, defaulting to C
Failed to set locale, defaulting to C
Package rpm-build-4.8.0-27.el6.x86_64 already installed and latest version
Failed to set locale, defaulting to C
Package 1:java-1.6.0-openjdk-devel-1.6.0.0-1.50.1.11.5.el6_3.x86_64 already installed and latest version
Failed to set locale, defaulting to C
Package matching xmlstarlet-1.3.1-1.el6.x86_64 already installed. Checking for update.
Starting Jenkins                                           [  OK  ]
reloading http://localhost:8080
Shutting down Jenkins                                      [  OK  ]
Starting Jenkins                                           [  OK  ]
</pre>

* Run the toolchain build console jobs
<pre>
[chuck@mvn-sdp-0 toolchain-example5]$ rerun jenkins: build-now --jobname dtolabs-toolchain-example5-master-mysql-connector-java-rpm
[chuck@mvn-sdp-0 toolchain-example5]$ rerun jenkins: build-now --jobname dtolabs-toolchain-example5-master-jboss-as-rpm	
[chuck@mvn-sdp-0 toolchain-example5]$ rerun jenkins: build-now --jobname dtolabs-toolchain-example5-master-jboss-as-config-rpm	
[chuck@mvn-sdp-0 toolchain-example5]$ rerun jenkins: build-now --jobname dtolabs-toolchain-example5-master-booking-mysql-data-rpm	
[chuck@mvn-sdp-0 toolchain-example5]$ rerun jenkins: build-now --jobname dtolabs-seam-examples-master	
</pre>

* Deploy the toolchain deploy console:
<pre>
[chuck@mvn-sdp-0 toolchain-example5]$ rerun -M . toolchain-deploy-console: deploy
Stopping rundeckd:                                         [  OK  ]
Failed to set locale, defaulting to C
Failed to set locale, defaulting to C
Package rerun-jboss-as-1.0-17.noarch already installed and latest version
Failed to set locale, defaulting to C
Package 1:java-1.6.0-openjdk-1.6.0.0-1.50.1.11.5.el6_3.x86_64 already installed and latest version
Failed to set locale, defaulting to C
Package matching xmlstarlet-1.3.1-1.el6.x86_64 already installed. Checking for update.
Failed to set locale, defaulting to C
Loaded plugins: fastestmirror, refresh-packagekit, security
Setting up Local Package Process
latest.rpm                                                                                                                                                                   | 2.1 kB     00:00     
Examining /var/tmp/yum-root-RQyb9A/latest.rpm: rundeck-repo-2-0.noarch
/var/tmp/yum-root-RQyb9A/latest.rpm: does not update installed package.
Nothing to do
Failed to set locale, defaulting to C
Loaded plugins: fastestmirror, refresh-packagekit, security
Loading mirror speeds from cached hostfile
 base: mirror.sanctuaryhost.com
 epel: linux.mirrors.es.net
 extras: holmes.umflint.edu
 updates: centos.mirror.sea.rackd.net
Setting up Install Process
Package rundeck-1.4.4-1.3.noarch already installed and latest version
Nothing to do
Starting rundeckd:                                         [  OK  ]
nohup: redirecting stderr to stdout
</pre>

* Append Rundeck Public SSH Key to your own authorized_keys file
<pre>
[chuck@sdp-centos-63-64-1 ]$ sudo cat /var/lib/rundeck/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
</pre>
