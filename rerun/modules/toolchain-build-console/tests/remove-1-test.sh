#!/usr/bin/env roundup
#
# This file contains the test plan for the remove command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m toolchain-build-console -p remove
#

# The Plan
# --------

describe "remove"

it_runs_without_arguments() {
    rerun toolchain-build-console:remove
}
