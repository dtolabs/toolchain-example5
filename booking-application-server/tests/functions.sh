# 
# Shell functions for booking-application-server test commands
#


# ----------------------------
# Your functions declared here.
#

build-booking-application-server-test-packages() {
  JBOSS_AS_PACKAGE_FILE="${RERUN_MODULES}/jboss-as-rpm/RPMS/noarch/jboss-as-7.1.1.Final-test.noarch.rpm"

  if [[ ! -r ${JBOSS_AS_PACKAGE_FILE} ]]
  then
    rerun jboss-as-rpm:build --release test
  fi

  JBOSS_AS_CONFIG_PACKAGE_FILE="${RERUN_MODULES}/jboss-as-config-rpm/RPMS/noarch/jboss-as-config-1.0-test.noarch.rpm"

  if [[ ! -r ${JBOSS_AS_CONFIG_PACKAGE_FILE} ]]
  then
    rerun jboss-as-config-rpm:build --release test
  fi

  MYSQL_CONNECTOR_PACKAGE_FILE="${RERUN_MODULES}/mysql-connector-java-rpm/RPMS/noarch/mysql-connector-java-5.1.22-test.noarch.rpm"

  if [[ ! -r ${MYSQL_CONNECTOR_PACKAGE_FILE} ]]
  then
    rerun mysql-connector-java-rpm:build --release test
  fi

  SEAM_BOOKING_PACKAGE_FILE="${RERUN_MODULES}/seam-examples/workspace/booking-rpm/target/rpm/seam-booking-rpm/RPMS/noarch/seam-booking-rpm-3.2.0-test.noarch.rpm"

  if [[ ! -r ${SEAM_BOOKING_PACKAGE_FILE} ]]
  then
    rerun seam-examples:build --release test
  fi
}
