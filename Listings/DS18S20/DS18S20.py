#!/usr/bin/python3
# -*-coding: utf-8 -*-

import mysql.connector
import sys
import os

#Verbindung zur Datenbank herstellen
try:
       db = mysql.connector.connect(host="localhost", user="root", passwd="test123", db="Sensordaten")
except:
       print("No connection to database")
       exit(0)


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

	#Coursor fuer Datenbankzugriff
	cur = db.cursor()

	#Daten in Datenbank schreiben
	sql = "INSERT INTO Sensordaten.DB18S20_Sensor (SensorID,Temperatur) VALUES(%s,%s)"
	cur.execute(sql,(w1_slave,temperature,))
	cur.close()


db.commit()
db.close()

sys.exit(0)
