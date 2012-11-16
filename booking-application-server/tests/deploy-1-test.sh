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


it_runs_without_arguments() {
   return 0
}

