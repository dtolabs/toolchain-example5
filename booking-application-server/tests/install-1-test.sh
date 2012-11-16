#!/usr/bin/env roundup
#
# This file contains the test plan for the install command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p install
#

# The Plan
# --------

describe "install"

if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

it_runs_with_example_file_args() {

   testinstall
   rerun booking-application-server: remove
}

