#!/usr/bin/python
# *-* coding: utf-8 *-*
import smbus
import time
import rrdtool
import sys
import os
from rrdtool import update as rrd_update
from time import sleep
	

############################## HYT 221 #################################	

#I2C-Adresse

SensorAdresse = 0x28;


#Array fuer die Sensordaten

SensorDaten = bytearray()


#Sensor ID für HYT221

ID_HYT = "HYT_221"	

#smbus Objekt fuer I2C bus #1

Sensor = smbus.SMBus(1)


#Initialisierung Array

SensorDaten.append(0x30)
SensorDaten.append(0x31)
SensorDaten.append(0x32)
SensorDaten.append(0x33)


#Sensor zum lesen initialisieren, Antwort ignorieren

ans = Sensor.read_byte_data(SensorAdresse,0)
sleep(0.1)


#4 Byte der Daten lesen

SensorDaten = Sensor.read_i2c_block_data(SensorAdresse,4)


#Luftfeuchtigkeit berechnen

DataHumidity = SensorDaten[0]<<8 | SensorDaten[1]
DataHumidity = DataHumidity & 0x3FFF

HYT_Humidity = 100.0*DataHumidity/(2**14)


#Temperatur berechnen

SensorDaten[3] = SensorDaten[3] & 0x3F
Temp = SensorDaten[2] << 6 | SensorDaten[3]

HYT_Temperature = 165.0*Temp/(2**14)-40

HYT_Temperature = round(HYT_Temperature,2)
HYT_Humidity = round(HYT_Humidity,2)


################################ DB18S20 ###############################

#1-Wire Slave-Liste lesen

file = open('/sys/devices/w1_bus_master1/w1_master_slaves')
w1_slaves = file.readlines()
file.close()
Temperature_W1 = []


#Fuer jeden 1-Wire Slave aktuelle Temperatur ausgeben

for line in w1_slaves:
	
	w1_slave = line.split("\n")[0]
	file = open('/sys/bus/w1/devices/'+str(w1_slave) + '/w1_slave')
	filecontent = file.read()
	file.close()
	
	stringvalue = filecontent.split("\n")[1]
	
	stringvalue = stringvalue.split(" ")[9]
	
	Temperature_W1.append(float(stringvalue[2:])/1000)
	
HYTTemp = float(HYT_Temperature)
HYTFeucht = float(HYT_Humidity)
DB18S20Temp = float(Temperature_W1[1])
DB18S20KabelTemp = float(Temperature_W1[0])

print ("HYT-Temperatur  : "), str(HYTTemp)
print ("DB-Temperatur   : "), str(DB18S20Temp)
print ("DB-Temperatur   : "), str(DB18S20KabelTemp)
print ("HYT-Feuchtigkeit: "), str(HYTFeucht)

################################ RRD-Daten speichern ###################


ret = rrd_update('/home/pi/Temperatur/Messung/Messung.rrd', 'N:%s:%s:%s:%s' %(HYTTemp, DB18S20KabelTemp, DB18S20Temp, HYTFeucht));
