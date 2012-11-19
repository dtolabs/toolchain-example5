#!/usr/bin/env roundup
#
# This file contains the test plan for the deploy command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m toolchain-deploy-console -p deploy
#

# The Plan
# --------

describe "deploy"


it_runs_without_arguments() {
   rerun toolchain-deploy-console:deploy
   rerun toolchain-deploy-console:stop
}

