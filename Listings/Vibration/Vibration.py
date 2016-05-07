#!/usr/bin/python3
# *-* coding: utf-8 *-*
import smbus
import sys
import os
import time
import math
import mysql.connector

from math import sqrt
from time import sleep
from smbus import SMBus

# Verbindung zur Datenbank

try:
	db = mysql.connector.connect(host="localhost", user="root", passwd="test123", db="RPI-Projekt")
except:
	print("No connection to database")
	exit(0)

sql = "INSERT INTO Vibration (XWERT, YWERT, ZWERT) VALUES(%s,%s,%s)"

#I2C Adresse
add = 0x38

#smbus Objekt für I2C erstellen
BMA020 = smbus.SMBus(1)

#Funktionsdefinition zum Auslesen
def read_word(reg):
	LSB = BMA020.read_byte_data(add, reg)
	LSB = LSB - 1
	MSB = BMA020.read_byte_data(add, reg+1)
	value = (MSB<<2)+(LSB>>6)
	return value

def read_word_2c(reg):
	val = read_word(reg)
	if(val >= 0x1FF):
		return -((1024 - val) + 1)
	else:
		return val

def Initialisierung_BMA020(SensorAdd):
	BMA020.write_quick(SensorAdd)
	sleep(0.5)

# Initialisierung BMA020
Initialisierung_BMA020(add)

# Cursor Erstellung für DB-Zugriff
cur = db.cursor()

# Dauerschleife für Ausgabe der Beschleunigungswerte

while(0==0):
	x = read_word_2c(0x02)
	y = read_word_2c(0x04)
	z = read_word_2c(0x06)
	
# Berechnung für +/- 2g
	x = x / 256.0
	y = y / 256.0
	z = z / 256.0

# Runden der Ergebnisse auf drei Nachkommastellen		
	x = round(x,3)
	y = round(y,3)
	z = round(z,3)
	
	#daten_in = open("Daten.txt")
	daten_out = open("Daten.txt","w")
	daten_out.write(str(x) + " " + str(y) + " " + str(z))
	daten_out.close() 	
	# Daten in DB eintragen
	cur.execute(sql,(x, y, z,))
	db.commit()
	
	# Gesamtbeschleunigung berechnen
	total = (sqrt(x**2 + y**2 + z**2))
	total = round(total, 3)

# Ausgabe der Ergebnisse		
	print("x: " + str(x) + "     " + "y: " + str(y) + "     " + "z: " + str(z) + "     " + "Beschleunigung: " + str(total) + " g")
	sleep(1)
