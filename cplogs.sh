#!/bin/bash


export L1=0
export T7=$(stat /moodle/conf/var.logs.conf | grep Modify)

file=/etc/logrotate.d/var.logs.conf
if [ ! -e "$file" ]; then
    echo "Copying Logrotate config"
    sudo cp -p /moodle/conf/var.logs.conf /etc/logrotate.d/
    echo "Logrotate config Copy done"
    export L1=1
else     :
    echo "check if logrotate config is updated"
    export T8=$(stat /etc/logrotate.d/var.logs.conf | grep Modify)
    if [ "$T7" != "$T8" ]; then
           echo "Copying Logrotate config"
           sudo cp -p /moodle/conf/var.logs.conf /etc/logrotate.d/
           echo "Logrotate config Copy done"
           export L1=1  
    fi
fi 

if [ "$L1" != "0" ]; then
    #restart nginx
    echo "run log rotate"
    sudo logrotate /etc/logrotate.d/var.logs.conf --state /var/log/logsrotate-state --verbose --force
    echo "run log rotate complete"
fi

