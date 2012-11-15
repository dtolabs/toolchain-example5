#!/usr/bin/env roundup
#
# This file contains the test plan for the create-jobs command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m seam-examples -p create-jobs
#

# The Plan
# --------

describe "create-jobs"

it_can_create_the_jenkins_jobs() {
    rerun seam-examples:create-jobs
}
