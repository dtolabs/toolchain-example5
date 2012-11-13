Summary: JBoss Application Server configuration

# The package name, version and release are supplied by rpm:build using rpmbuild(8)'s "--define" option:
Name: %{name}
Version: %{version}
Release: %{release} 

License: LGPL
Group: Applications/System

BuildArch: noarch

# Specify minimum Java version required:
Requires: jboss-as >= 7.1
 
# Disables debug packages and stripping of binaries:
%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post %{nil}
 
%description
JBoss Application Server configuration
 
%prep

%build
 
%install
# setup the target directory hierarchy:
rm -rf %{buildroot}
find | cpio -pdm %{buildroot}

%clean

%files
%defattr(-,jboss-as,jboss-as)
/etc/jboss-as/jboss-as.conf
/usr/share/jboss-as/standalone/configuration/standalone-booking.xml
 
%changelog

