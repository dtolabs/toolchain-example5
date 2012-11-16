#!/usr/bin/env roundup
#
# This file contains the test plan for the remove command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p remove
#

# The Plan
# --------

describe "remove"

if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

# ------------------------------
# Replace this test. 
it_runs_without_arguments() {

   testinstall

   rerun booking-application-server: remove
}
# ------------------------------

