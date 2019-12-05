#!/bin/bash

##pwdx
#through pid to find the path-cwd

ls -l /proc/$1 | grep cwd | awk '{print $11}'
