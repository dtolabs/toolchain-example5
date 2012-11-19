#!/usr/bin/env roundup
#
# This file contains the test plan for the erase command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m toolchain-deploy-console -p erase
#

# The Plan
# --------

describe "erase"


it_runs_without_arguments() {
    #rerun toolchain-deploy-console: erase
    return 0
}
