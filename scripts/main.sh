#!/bin/bash

cd /var/www/react-app
nohup serve -s build -l 80 > /dev/null 2>&1 &