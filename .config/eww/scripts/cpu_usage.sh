#!/bin/bash

echo "$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8""}')"
