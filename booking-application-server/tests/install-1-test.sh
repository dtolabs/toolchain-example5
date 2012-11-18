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

if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

it_runs_on_a_clean_system() {
  build-booking-application-server-test-packages

  rerun booking-application-server:remove
  rerun booking-application-server:install --jboss-as-package-file ${JBOSS_AS_PACKAGE_FILE} --jboss-as-config-package-file ${JBOSS_AS_CONFIG_PACKAGE_FILE} --mysql-connector-java-package-file ${MYSQL_CONNECTOR_JAVA_PACKAGE_FILE} --seam-booking-package-file ${SEAM_BOOKING_PACKAGE_FILE}
  rerun booking-application-server:erase
}
