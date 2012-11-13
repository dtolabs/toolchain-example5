Summary: Seam Booking sample application database scripts

# The package name, version and release are supplied by rpm:build using rpmbuild(8)'s "--define" option:
Name: %{name}
Version: %{version}
Release: %{release} 

License: LGPL
Group: Applications/System

BuildArch: noarch

# Specify minimum Java version required:
Requires: mysql-server
 
# Disables debug packages and stripping of binaries:
%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post %{nil}
 
%description
Seam Booking sample application database scripts
 
%prep

%build
 
%install
# setup the target directory hierarchy:
rm -rf %{buildroot}
find | cpio -pdm %{buildroot}

%clean

%files
%defattr(-,mysql,mysql)
/var/lib/mysql/scripts
 
%changelog

