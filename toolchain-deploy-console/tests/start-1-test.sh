#!/usr/bin/env roundup
#
# This file contains the test plan for the start command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m toolchain-deploy-console -p start
#

# The Plan
# --------

describe "start"


it_runs_without_arguments() {
    rerun toolchain-deploy-console:install
    rerun toolchain-deploy-console:start
    rerun toolchain-deploy-console:stop
}
