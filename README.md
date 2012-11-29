Toolchain example #5
====================

This example shows how to automate application build and deployment using a loosely-coupled toolchain

Application
-----------
 
DTO Lab's fork of the [Seam Examples](https://github.com/dtolabs/seam-examples) Booking application running on JBoss with MySQL.

Infrastructure
--------------

A single pre-provisioned Red Hat/CentOS Linux instance for build, repository, deployment, application and database services.

Toolchain
---------

* Source code management: GitHub/Git
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
    * 64-bit CentOS Linux 6.3 or later
    * Internet access (to GitHub and standard Yum repositories)
    
Preparations
------------

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
[root@localhost chuck]# grep HOSTNAME /etc/sysconfig/network
HOSTNAME=sdp-centos-63-64-1.local
[anthony@centos63-toolchain-example5 ~]$ uname -n 
centos63-toolchain-example5
[anthony@centos63-toolchain-example5 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 centos63-toolchain-example5
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
</pre>

* User requirements:
    * Non-root user account ...
    * ... with sudo access to run any command as root without a password (e.g. wheel group membership)
    * ... sudo requiretty disabled to run any command without an interactive shell session (e.g. "Defaults !requiretty")
<pre>
[chuck@sdp-centos-63-64-1 toolchain-example5]$ sudo grep '%wheel.*NOPASSWD' /etc/sudoers
%wheel  ALL=(ALL)       NOPASSWD: ALL
[chuck@sdp-centos-63-64-1 toolchain-example5]$ sudo grep 'Defaults.*requiretty' /etc/sudoers
Defaults    !requiretty
[chuck@sdp-centos-63-64-1 toolchain-example5]$ groups
chuck wheel
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

* Repositories:
   * Configure the [EPEL repository](http://dl.fedoraproject.org/pub/epel/6/x86_64/repoview/epel-release.html). e.g:
<pre>
[anthony@centos63-toolchain-example5 ~]$ sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
Retrieving http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
warning: /var/tmp/rpm-tmp.4fSCLZ: Header V3 RSA/SHA256 Signature, key ID 0608b895: NOKEY
Preparing...                ########################################### [100%]
   1:epel-release           ########################################### [100%]
</pre>



* Go to the [Rerun Downloads](https://github.com/rerun/rerun/downloads) page and obtain the latest link and execute the following replacing example url shown inline:
<pre>
[chuck@mvn-sdp-0 development]$ sudo rpm -Uvh https://github.com/downloads/rerun/rerun/rerun-1.0-122.noarch.rpm
Retrieving https://github.com/downloads/rerun/rerun/rerun-1.0-109.noarch.rpm
Preparing...                ########################################### [100%]
   1:rerun                  ########################################### [100%]
</pre>

   * Obtain latest version of the rerun-modules repo definition from [Rerun Modules Downloads](https://github.com/rerun-modules/rerun-modules/downloads), obtain the link and execute the following replacing example url shown inline:
<pre>
[chuck@sdp-centos-63-64-1 toolchain-example5]$  sudo rpm -Uvh https://github.com/downloads/rerun-modules/rerun-modules/rerun-modules-repo-1.0-21.noarch.rpm
Retrieving https://github.com/downloads/rerun-modules/rerun-modules/rerun-modules-repo-1.0-21.noarch.rpm
Preparing...                ########################################### [100%]
   1:rerun-modules-repo     ########################################### [100%]
</pre>

* Install all available Rerun modules
<pre>
[chuck@localhost ~]$ sudo yum -y --disablerepo=\* --enablerepo=rerun-modules install '*'
.
.
.
Installed:
  rerun-apache-maven.noarch 0:1.0-10  rerun-github.noarch 0:1.0.0-26  rerun-jboss-as.noarch 0:1.0-20  rerun-jenkins.noarch 0:1.0.0-28  rerun-mysql.noarch 0:1.0.0-13  rerun-rpm.noarch 0:1.0.0-26 
  rerun-rundeck.noarch 0:1.0-18       rerun-ssh.noarch 0:1.0.0-7     
Complete!
</pre>

* Clone the [Toolchain Example #5](https://github.com/dtolabs/toolchain-example5) repository:
<pre>
[anthony@centos63-toolchain-example5 ~]$ mkdir ~/src
[anthony@centos63-toolchain-example5 ~]$ cd ~/src
[chuck@localhost src]$ git clone git://github.com/dtolabs/toolchain-example5.git
Initialized empty Git repository in /home/chuck/src/toolchain-example5/.git/
remote: Counting objects: 1166, done.
remote: Compressing objects: 100% (512/512), done.
remote: Total 1166 (delta 602), reused 1058 (delta 494)
Receiving objects: 100% (1166/1166), 139.25 MiB | 1.35 MiB/s, done.
Resolving deltas: 100% (602/602), done.
</pre>

Setup the Toolchain
-------------------
At this point you are now ready to setup the example toolchain's build and deployment consoles.

* Deploy the toolchain build console:
<pre>
[chuck@localhost toolchain-example5]$ cd $HOME/src/toolchain-example5/
[chuck@mvn-sdp-0 toolchain-example5]$  rerun -M . toolchain-build-console: deploy
Failed to set locale, defaulting to C
Package rerun-jenkins-1.0.0-28.noarch already installed and latest version
Failed to set locale, defaulting to C
Package rerun-rpm-1.0.0-26.noarch already installed and latest version
Failed to set locale, defaulting to C
Package rerun-apache-maven-1.0-10.noarch already installed and latest version
Failed to set locale, defaulting to C
Package rerun-jboss-as-1.0-20.noarch already installed and latest version
Failed to set locale, defaulting to C
Failed to set locale, defaulting to C
Failed to set locale, defaulting to C
warning: rpmts_HdrFromFdno: Header V3 RSA/SHA256 Signature, key ID 0608b895: NOKEY
Importing GPG key 0x0608B895:
 Userid : EPEL (6) <epel@fedoraproject.org>
 Package: epel-release-6-7.noarch (installed)
 From   : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
Building target platforms: noarch
Building for target noarch
Failed to set locale, defaulting to C
Warning: RPMDB altered outside of yum.
warning: /etc/yum.repos.d/jenkins.repo created as /etc/yum.repos.d/jenkins.repo.rpmnew
Starting Jenkins                                           [  OK  ]
reloading http://localhost:8080
reloading http://localhost:8080
Shutting down Jenkins                                      [  OK  ]
Starting Jenkins                                           [  OK  ]
</pre>

* You can navigate to the build console (Jenkins) at [http://<i>localhost</i>:8080/](http://localhost:8080/) (replace localhost for your hostname) to check on the progress for the build jobs that have automatically been kicked off.

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

* You can navigate to the deploy console (Rundeck) at [http://<i>localhost</i>:4440/](http://localhost:4440/) (replace localhost for your hostname) to verify the deploy jobs have been setup.

Using the Example
-----
* Run any command as the toolchain user by filtering by the "toolchain-user" tag and entering a command in the command field:
![rundeck-tc-user](https://github.com/dtolabs/toolchain-example5/raw/master/.images/rundeck-tc-user.jpg)

* Ensure the builds started by the build console deploy are complete.
![building-console-jobs](https://github.com/dtolabs/toolchain-example5/raw/master/.images/build-console-jobs.jpg)
![building-console-jobs](https://github.com/dtolabs/toolchain-example5/raw/master/.images/build-console-jobs-built.jpg)

* Run the Booking database server deploy job
![building-console-jobs](https://github.com/dtolabs/toolchain-example5/raw/master/.images/deploy-console-database-server-deploy.jpg)

* Check that the Booking database exists
<pre>
[chuck@localhost toolchain-example5]$ mysql -u root
.
.
.
mysql&gt; show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| booking            |
| mysql              |
| scripts            |
| test               |
+--------------------+
5 rows in set (0.00 sec)
</pre>

* Run the Booking application server deploy job
![building-console-jobs](https://github.com/dtolabs/toolchain-example5/raw/master/.images/deploy-console-application-server-deploy.jpg)

* Navigate to the sample Booking application and make a booking at [http://<i>localhost</i>:8180/seam-booking](http://localhost:8180/seam-booking) (replace localhost for your hostname)
![seam-booking-login](https://github.com/dtolabs/toolchain-example5/raw/master/.images/seam-booking-login.jpg)



Removing the example from the system
-----------------------------------
* Completely remove the Booking application server (JBoss) from the system
<pre>
[chuck@localhost toolchain-example5]$ rerun -M . booking-application-server:remove
.
.
.
Stopping jboss-as:                                         [  OK  ]
  jboss-as.noarch 0:7.1.1.Final-1                                                                 seam-booking-rpm.noarch 0:3.2.0-1                                                                

Dependency Removed:
  jboss-as-config.noarch 0:1.0-1                                                               mysql-connector-java.noarch 0:5.1.22-1                                                              

Complete!
</pre>

* Completely remove the Booking database server (MySQL) from the system
<pre>
[chuck@localhost toolchain-example5]$ rerun -M . booking-database-server:remove
mysqld (pid  6654) is running...
Stopping mysqld:                                           [  OK  ]
mysqld is stopped
Failed to set locale, defaulting to C
Warning: RPMDB altered outside of yum.
warning: /var/log/mysqld.log saved as /var/log/mysqld.log.rpmsave
</pre>

* Completely remove the deploy console (Rundeck) from the system
<pre>
[chuck@localhost toolchain-example5]$ rerun -M . toolchain-deploy-console:remove
Stopping rundeckd:                                         [  OK  ]
.
.
.
</pre>

* Completely remove the build console (Jenkins) from the system
<pre>
[chuck@localhost toolchain-example5]$ rerun -M . toolchain-build-console:remove
Shutting down Jenkins                                      [  OK  ]
Failed to set locale, defaulting to C
warning: /etc/yum.repos.d/jenkins.repo saved as /etc/yum.repos.d/jenkins.repo.rpmsave
</pre>

Chuck Scott (chuck@dtosolutions.com)
Anthony Shortland (anthony@dtosolutions.com)
