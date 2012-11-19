#!/usr/bin/env roundup
#
# This file contains the test plan for the install command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m toolchain-deploy-console -p install
#

# The Plan
# --------

describe "install"


it_runs_without_arguments() {
    rerun toolchain-deploy-console:install
}
