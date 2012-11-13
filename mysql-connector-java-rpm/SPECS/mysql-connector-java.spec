Summary: MySQL Connector/J for JBoss

# The package name, version and release are supplied by rpm:build using rpmbuild(8)'s "--define" option:
Name: %{name}
Version: %{version}
Release: %{release} 

# Assumes the appropriate community release has been downloaded to SOURCES from jboss.org:
Source0: %{name}-%{version}.zip
 
License: LGPL
Group: Applications/System

BuildArch: noarch

# Specify minimum Java version required:
Requires: jboss-as >= 7
 
# Disables debug packages and stripping of binaries:
%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post %{nil}
 
# stop the build failing just becauses there are a few sample binaries in the distribution:
%define _binaries_in_noarch_packages_terminate_build   0

%description
Packages the MySQL Connector/J for use with the JBoss Application Server standalone configuration
 
%prep

%setup

%build
 
%install
# setup the target directory hierarchy:
rm -rf %{buildroot}
install -d -m 755 %{buildroot}/usr/share/jboss-as/standalone/deployments
cp mysql-connector-java-%{version}-bin.jar %{buildroot}/usr/share/jboss-as/standalone/deployments

%clean

%files
# add the files to the RPM with appropriate permissions:
%defattr(-,jboss-as,jboss-as)
/usr/share/jboss-as/standalone/deployments/mysql-connector-java-%{version}-bin.jar
 
%changelog

%pre

%post

%preun
