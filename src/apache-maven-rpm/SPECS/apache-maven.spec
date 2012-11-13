Summary: Apache/Maven Build and Comprehension Tool

# The package name, version and release are supplied by rpm:build using rpmbuild(8)'s "--define" option:
Name: %{name}
Version: %{version}
Release: %{release} 

# Assumes the appropriate community release has been downloaded to SOURCES from maven mirror
Source0: %{name}-%{version}.zip
 
License: LGPL
Group: Applications/System

BuildArch: noarch

# Specify minimum Java version required:
Requires: java-devel

# Disables debug packages and stripping of binaries:
%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post %{nil}
 
# stop the build failing just becauses there are a few sample binaries in the distribution:
%define _binaries_in_noarch_packages_terminate_build   0


%description
Apache/Maven Build and Comprehension Tool
 
%prep

%setup
# Overlay the source package contents with the customized files and directories:
#cp -R $RPM_SOURCE_DIR/%{name}-%{version}/* $RPM_BUILD_DIR/%{name}-%{version}

%build
 
%install
# setup the target directory hierarchy:
rm -rf %{buildroot}
install -d -m 755 %{buildroot}/usr/share/maven
mv * %{buildroot}/usr/share/maven

mkdir -p %{buildroot}/usr/bin
(cd %{buildroot}/usr/bin && ln -s ../share/maven/bin/mvn)
mkdir -p %{buildroot}/etc
cat >%{buildroot}/etc/mavenrc <<"EOF"
#!/bin/bash
if [ -z "${M2_HOME}" ]
then
   export M2_HOME="/usr/share/maven"
fi
EOF



%clean

%files
# add the files to the RPM with appropriate permissions (allowing jboss-as.conf to be modified):
%defattr(-,root,root)
%attr(755,root,root) /usr/bin/mvn
%attr(644,root,root) /etc/mavenrc

/usr/share/maven
 
%changelog

%pre

%post

%preun
