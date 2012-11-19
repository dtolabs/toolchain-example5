# 
# Shell functions for booking-application-server test commands
#


# ----------------------------
# Your functions declared here.
#

TEST_MODULE_DIR="${RERUN_MODULES}/booking-application-server"

testinstall() {

   rerun booking-application-server: install \
     --jboss-as-package-file "file://${TEST_MODULE_DIR}/examples/rpms/jboss-as-7.1.1.Final-1.noarch.rpm" \
      --jboss-as-config-package-file "file://${TEST_MODULE_DIR}/examples/rpms/jboss-as-config-1.0-1.noarch.rpm" \
      --mysql-connector-package-file "file://${TEST_MODULE_DIR}/examples/rpms/mysql-connector-java-5.1.22-2.noarch.rpm" \
      --seam-booking-package-file "file://${TEST_MODULE_DIR}/examples/rpms/seam-booking-rpm-3.2.0-1.noarch.rpm"
}

testdeploy() {
   rerun booking-application-server: stop
   testinstall
   rerun booking-application-server: configure
   rerun booking-application-server: start
   rerun booking-application-server: stop
}
