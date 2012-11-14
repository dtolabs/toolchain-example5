#!/usr/bin/env roundup
#
# This file contains the test plan for the build command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m apache-maven-rpm -p build
#

# The Plan
# --------

describe "build"

it_can_build_the_apache_maven_rpm() {
    rerun apache-maven-rpm:build
}

