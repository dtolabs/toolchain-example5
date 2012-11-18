#!/usr/bin/env roundup
#
# This file contains the test plan for the cleanup command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p cleanup
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "cleanup"


it_works_without_arguments() {
    rerun booking-application-server:remove
    rerun booking-application-server:cleanup
}
