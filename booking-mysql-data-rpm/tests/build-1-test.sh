#!/usr/bin/env roundup
#
# This file contains the test plan for the build command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-mysql-data-rpm -p build
#

# The Plan
# --------

describe "build"


it_builds_the_booking_mysql_rpm() {
    rerun booking-mysql-data-rpm:build
}

