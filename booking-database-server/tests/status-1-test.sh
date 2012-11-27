#!/usr/bin/env roundup
#
# This file contains the test plan for the status command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-database-server -p status
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "status"

it_needs_a_real_test() {
    exit 0
} 
