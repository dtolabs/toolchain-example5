#!/usr/bin/env roundup
#
# This file contains the test plan for the create-deploy-jobs command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-application-server -p create-deploy-jobs
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "create-deploy-jobs"


if [ -f "${RERUN_MODULES}/booking-application-server/tests/functions.sh" ]
then
   source "${RERUN_MODULES}/booking-application-server/tests/functions.sh"
fi

it_runs_without_arguments() {
    # Make sure the deployment console is running.
    rerun toolchain-deploy-console:deploy
    # Create the Booking application server's jobs.
    rerun booking-application-server:create-deploy-jobs
    # Remove
    rerun toolchain-deploy-console:remove
}
