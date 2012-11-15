#!/usr/bin/env roundup
#
# This file contains the test plan for the build command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m jboss-as-rpm -p build
#

# The Plan
# --------

describe "build"


it_can_build_the_jboss_as_rpm() {
    rerun jboss-as-rpm:build
}

