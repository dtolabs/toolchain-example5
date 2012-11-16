#!/usr/bin/env roundup
#
# This file contains the test plan for the install command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p install
#

# The Plan
# --------

describe "install"


# ------------------------------
# Replace this test. 
it_runs_with_example_file_args() {

   moduleDir="${RERUN_MODULES}/booking-application-server"
   if [ ! -d "${moduleDir}" ]
   then
      echo "directory ${moduleDir} does not exist" 1>&2
      return 1
   fi

   rerun booking-application-server: install \
      --jboss-as-package-file "file://${moduleDir}/examples/rpms/jboss-as-7.1.1.Final-1.noarch.rpm" \
      --jboss-as-config-package-file "file://${moduleDir}/examples/rpms/jboss-as-config-1.0-1.noarch.rpm" \
      --mysql-connector-package-file "file://${moduleDir}/examples/rpms/mysql-connector-java-5.1.22-2.noarch.rpm" \
      --seam-booking-package-file "file://${moduleDir}/examples/rpms/seam-booking-rpm-3.2.0-1.noarch.rpm"
}
# ------------------------------

