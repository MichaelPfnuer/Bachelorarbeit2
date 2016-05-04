#!/usr/bin/python3
# *-* coding: utf-8 *-*
import smbus
import time
import sys
import os
import mysql.connector
from time import sleep

############################## Datenbank ###############################

#Datenbank Verbindung herstellen
try:
	db = mysql.connector.connect(host="localhost", user="root", passwd="test123", db="RPI-Projekt")
except :
	print("No connection to database")
	exit(0)
	

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
Slave_W1 = []


#Fuer jeden 1-Wire Slave aktuelle Temperatur ausgeben

for line in w1_slaves:
	Slave_W1.append(line.split("\n")[0])
	w1_slave = line.split("\n")[0]
	file = open('/sys/bus/w1/devices/'+str(w1_slave) + '/w1_slave')
	filecontent = file.read()
	file.close()
	
	stringvalue = filecontent.split("\n")[1]
	
	stringvalue = stringvalue.split(" ")[9]

	Temperature_W1.append(round((float(stringvalue[2:])/1000),2))



########################### Daten in mySQL speichern ###################

#Cursor zum Eintragen erzeugen
cur = db.cursor()


#SQL-Statment erzeugen

sql = "INSERT INTO Temperatur (DB18S20, DB18S20K, HYT22) VALUES (%s,%s,%s)"
cur.execute(sql,(Temperature_W1[1],Temperature_W1[0],HYT_Temperature))


sql1 = "INSERT INTO Luftfeuchtigkeit (HYT22) VALUES (%s)"
cur.execute(sql1,(HYT_Humidity,))

db.commit()
db.close()

sys.exit(0)
