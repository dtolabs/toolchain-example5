#!/usr/bin/env roundup
#
# This file contains the test plan for the start command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p start
#

# The Plan
# --------

describe "start"

if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

it_runs_without_arguments() {
   testinstall
   rerun booking-application-server:start
   rerun booking-application-server:stop
   rerun booking-application-server: remove
}

