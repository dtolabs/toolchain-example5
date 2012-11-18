#!/usr/bin/env roundup
#
# This file contains the test plan for the configure command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p configure
#

# The Plan
# --------

describe "configure"

if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

it_runs_without_arguments() {
  build-booking-application-server-test-packages

  rerun booking-application-server:remove
  rerun booking-application-server:install --jboss-as-package-file ${JBOSS_AS_PACKAGE_FILE} --jboss-as-config-package-file ${JBOSS_AS_CONFIG_PACKAGE_FILE} --mysql-connector-java-package-file ${MYSQL_CONNECTOR_JAVA_PACKAGE_FILE} --seam-booking-package-file ${SEAM_BOOKING_PACKAGE_FILE}
  rerun booking-application-server:configure    
  rerun booking-application-server:remove
}

