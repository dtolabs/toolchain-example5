#!/usr/bin/env roundup
#
# This file contains the test plan for the remove command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m booking-database-server -p remove
#

# The Plan
# --------

describe "remove"


it_can_remove_the_database_server() {
    rerun booking-database-server:remove
    rerun booking-database-server:remove
    rerun booking-database-server:deploy --data-package-file $RERUN_MODULES/booking-database-server/examples/booking-mysql-data-1.0-1.noarch.rpm
    rerun booking-database-server:remove
}
