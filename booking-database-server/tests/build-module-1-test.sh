#!/usr/bin/env roundup
#
# This file contains the test plan for the build-module command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-database-server -p build-module
#

# The Plan
# --------

describe "build-module"


it_runs_without_a_real_test() {
    echo "NOTE: this test sucks because we are limited to where we can write this module" 1>&2
    exit 0
}