#!/usr/bin/env roundup
#
# This file contains the test plan for the erase command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p erase
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "erase"

it_runs_with_packages_installed() {
  build-booking-application-server-test-packages

  rerun booking-application-server:remove --cleanup true
  rerun booking-application-server:install --jboss-as-package-file ${JBOSS_AS_PACKAGE_FILE} --jboss-as-config-package-file ${JBOSS_AS_CONFIG_PACKAGE_FILE} --mysql-connector-java-package-file ${MYSQL_CONNECTOR_JAVA_PACKAGE_FILE} --seam-booking-package-file ${SEAM_BOOKING_PACKAGE_FILE}
  rerun booking-application-server:erase
}

it_runs_without_packages_installed() {
  rerun booking-application-server:remove --cleanup true
  rerun booking-application-server:erase
}
