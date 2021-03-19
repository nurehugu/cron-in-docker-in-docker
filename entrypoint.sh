#!/bin/bash
declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID' > /container.env

# Setup a cron schedule
echo "SHELL=/bin/bash
BASH_ENV=/container.env
* * * * * docker exec -i dev.eurochem.asupb.local php shell.php qcron" > scheduler.txt

crontab scheduler.txt
cron -f
