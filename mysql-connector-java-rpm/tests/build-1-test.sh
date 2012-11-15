#!/usr/bin/env roundup
#
# This file contains the test plan for the build command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m mysql-connector-java-rpm -p build
#

# The Plan
# --------

describe "build"

it_builds_the_mysql_connector_java_rpm() {
    rerun mysql-connector-java-rpm:build
}
