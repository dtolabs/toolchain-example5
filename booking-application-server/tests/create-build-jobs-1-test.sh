#!/usr/bin/env roundup
#
# This file contains the test plan for the create-build-jobs command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p create-build-jobs
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "create-build-jobs"

it_needs_a_real_test() {
    exit 0
}
