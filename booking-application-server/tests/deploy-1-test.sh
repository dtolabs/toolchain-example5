#!/usr/bin/env roundup
#
# This file contains the test plan for the deploy command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p deploy
#

# The Plan
# --------

describe "deploy"

if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

it_runs_without_arguments() {
   testdeploy
}

