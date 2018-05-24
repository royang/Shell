#! /bin/sh

while :
do 
	cat /sys/class/thermal/thermal_zone0/temp
	sleep 10
done
