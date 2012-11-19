#!/usr/bin/env roundup
#
# This file contains the test plan for the configure command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m toolchain-deploy-console -p configure
#

# The Plan
# --------

describe "configure"


it_runs_without_arguments() {
    rerun toolchain-deploy-console: install
    rerun toolchain-deploy-console: configure
}
