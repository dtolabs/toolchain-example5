#!/usr/bin/env roundup
#
# This file contains the test plan for the create-deploy-jobs command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-database-server -p create-deploy-jobs
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "create-deploy-jobs"


it_needs_a_real_test() {
    exit 0
} 
