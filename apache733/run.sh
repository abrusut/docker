#!/bin/bash
. /dockerhost.sh
source /etc/apache2/envvars
#cat /etc/apache2/apache2.conf
exec apache2 -D FOREGROUND