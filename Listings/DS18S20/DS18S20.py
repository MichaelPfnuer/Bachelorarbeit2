#!/usr/bin/python3
# -*-coding: utf-8 -*-

import sys
import os

#1-Wire Slave-Liste lesen
file = open('/sys/devices/w1_bus_master1/w1_master_slaves')
w1_slaves = file.readlines()
file.close()


#Fuer jeden 1-Wire Slave aktuelle Temperatur ausgeben
for line in w1_slaves:
	w1_slave = line.split("\n")[0]
	file = open('/sys/bus/w1/devices/'+str(w1_slave) + '/w1_slave')
	filecontent = file.read()
	file.close()
	
	stringvalue = filecontent.split("\n")[1].split(" ")[9]
	temperature = float(stringvalue[2:])/1000
	temperature = round(temperature,2)
	print(str(w1_slave) + ': %6.2f C' % temperature)

################ Sensor-Daten speichern #############

ret = rrd_update('/home/pi/Temperatur/TemperaturSensor/TemperaturAufzeichnungDB18S20.rrd','N:%s'%(temperature));

sys.exit(0)