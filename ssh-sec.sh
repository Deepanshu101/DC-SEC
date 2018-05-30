#!/bin/bash
toilet -f mono12 -F metal SSH-SEC
awk '/Port/ { if ( $2 != 22 ) { ++count ; print count ; print "your port is secured" } else { print " port is not secured "} } ' sshd_config > cnt
awk '/PermitRootLogin/{ if ( $1 = " PermitRootLogin_no " ) { ++count2 ; print count2 ; print "your root login is secured" } else { print "root login is not secured "} } ' sshd_config >> cnt
awk '/PrintLastLog/{ if ( $2 = "no" ) {  ++count3 ; print count3 ; print "last log is not printing so you are secured" } else { "last log is getting printed therefore you are not secured "} } ' sshd_config >> cnt 
awk '/MaxAuthTries/{ if ( $2 -lt 3 ) {  ++count4 ; print count4 ; print "max attempt tries is limited to less than 3 therefore secured" } else { "max attempts is more than 3 therefore not secured"} } ' sshd_config >> cnt
awk '/PermitEmptyPassword/{ if ( $2 = "no" ) {  ++count5 ; print count5 ; print "Empty passwords are not permitted therefore secured" } else { print "empty passwords are allowed hence not secured "} } ' sshd_config >> cnt
awk 'NR % 2 == 0' cnt
awk '{ sum += $1 } END { print sum }' cnt > finc
cat finc
awk '{ if ($1 -gt 4 ) { print "secured" } else { print "not Secured" } } ' finc



