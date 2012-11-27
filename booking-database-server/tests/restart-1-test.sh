#!/usr/bin/env roundup
#
# This file contains the test plan for the restart command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-database-server -p restart
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "restart"


it_needs_a_real_test() {
    exit 0
} 
