#!/usr/bin/env roundup
#
# This file contains the test plan for the cleanup command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m toolchain-deploy-console -p cleanup
#

# The Plan
# --------

describe "cleanup"

it_runs_without_arguments() {
   return 0
}

