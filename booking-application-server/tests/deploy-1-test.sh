#!/usr/bin/env roundup
#
# This file contains the test plan for the deploy command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p deploy
#

# The Plan
# --------

describe "deploy"

if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

it_works_from_a_fresh_install() {
  # Make sure the required test packages are built.
  build-booking-application-server-test-packages

  # Remove the Booking application server instance.
  rerun booking-application-server:remove --cleanup true
  # Deploy the Booking application server.
  rerun booking-application-server:install --jboss-as-package-file ${JBOSS_AS_PACKAGE_FILE} --jboss-as-config-package-file ${JBOSS_AS_CONFIG_PACKAGE_FILE} --mysql-connector-java-package-file ${MYSQL_CONNECTOR_JAVA_PACKAGE_FILE} --seam-booking-package-file ${SEAM_BOOKING_PACKAGE_FILE}
  # Remove the Booking application server instance.
  rerun booking-application-server:remove --cleanup true

}

