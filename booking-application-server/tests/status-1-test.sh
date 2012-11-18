#!/usr/bin/env roundup
#
# This file contains the test plan for the status command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p status
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "status"


it_works_on_a_deployed_system() {
  build-booking-application-server-test-packages

  rerun booking-application-server:install --jboss-as-package-file ${JBOSS_AS_PACKAGE_FILE} --jboss-as-config-package-file ${JBOSS_AS_CONFIG_PACKAGE_FILE} --mysql-connector-package-file ${MYSQL_CONNECTOR_PACKAGE_FILE} --seam-booking-package-file ${SEAM_BOOKING_PACKAGE_FILE}

  rerun booking-application-server:status

  rerun booking-application-server:stop
  if ! rerun booking-application-server:status
  then
    :
  fi

  rerun booking-application-server:remove --cleanup true
}
