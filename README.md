Toolchain example #5
====================

This example shows how to automate application build and deployment using a loosely-coupled toolchain

Application
-----------
 
DTO Lab's fork of the [Seam Examples](https://github.com/dtolabs/seam-examples) Booking application running on JBoss with MySQL.

Infrastructure
--------------

A single pre-provisioned Red Hat Linux (tested on "CentOS release 6.2") instance for build, repository, deployment, application and database services.

Tool-chain
----------

* Souce code management: GitHub/Git
* Build tool: Ant and Rerun
* Build console: Jenkins
* Package format: RPM
* Package repository: Jenkins
* Deployment console: Rundeck
* Modular automation: Rerun

Anthony Shortland
anthony@dtosolutions.com
