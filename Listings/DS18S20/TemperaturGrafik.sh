#!/bin/sh

#Grafik erstellen
sudo rrdtool graph /var/www/html/TemperaturTag.png \
-w 900 -h 600 -t "Temperaturverlauf letzte 10 Stunden" \
--end now --start end-10h -v "Temperatur(°C)" --slope-mode \
--x-grid MINUTE:20:HOUR:1:MINUTE:60:0:%R \
-c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff \
--alt-autoscale --rigid \
DEF:Temperatur1=/home/pi/Temperatur/TemperaturSensor/TemperaturAufzeichnungDB18S20.rrd:Temperatur1:AVERAGE \
DEF:Temperatur2=/home/pi/Temperatur/TemperaturSensor/TemperaturAufzeichnungDB18S20.rrd:Temperatur2:AVERAGE \
VDEF:Temp1Cur=Temperatur1,LAST \
VDEF:Temp1Max=Temperatur1,MAXIMUM \
VDEF:Temp1Avg=Temperatur1,AVERAGE \
VDEF:Temp1Min=Temperatur1,MINIMUM \
VDEF:Temp2Cur=Temperatur2,LAST \
VDEF:Temp2Max=Temperatur2,MAXIMUM \
VDEF:Temp2Avg=Temperatur2,AVERAGE \
VDEF:Temp2Min=Temperatur2,MINIMUM \
COMMENT:"                    " \
COMMENT:"Current   " \
COMMENT:"Maximum   " \
COMMENT:"Average   " \
COMMENT:"Minimum \l" \
LINE3:Temperatur1#00C000:"DB18S20" \
GPRINT:Temp1Cur:"          %6.2lf %S°C" \
GPRINT:Temp1Max:"%6.2lf %S°C" \
GPRINT:Temp1Avg:"%6.2lf %S°C" \
GPRINT:Temp1Min:"%6.2lf %S°C\l" \
LINE2:Temperatur2#0000FF:"DB18S20 mit Kabel" \
GPRINT:Temp2Cur:"%6.2lf %S°C" \
GPRINT:Temp2Max:"%6.2lf %S°C" \
GPRINT:Temp2Avg:"%6.2lf %S°C" \
GPRINT:Temp2Min:"%6.2lf %S°C\l" \

sudo rrdtool graph /var/www/html/TemperaturStunde.png \
-w 900 -h 600 -t "Temperaturverlauf letzte Stunde" \
--end now --start end-1h -v "Temperatur(°C)" --slope-mode -c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff --x-grid MINUTE:1:MINUTE:15:MINUTE:5:0:%R --alt-autoscale --rigid \
DEF:Temperatur1=/home/pi/Temperatur/TemperaturSensor/TemperaturAufzeichnungDB18S20.rrd:Temperatur1:AVERAGE \
DEF:Temperatur2=/home/pi/Temperatur/TemperaturSensor/TemperaturAufzeichnungDB18S20.rrd:Temperatur2:AVERAGE \
LINE3:Temperatur1#00C000:"DB18S20 mit Kabel\t\t\t" \
LINE2:Temperatur2#0000FF:"DB18S20\n" \
GPRINT:Temperatur1:LAST:"  aktuell\: %10.2lf °C\t\t" \
GPRINT:Temperatur2:LAST:"  aktuell\: %10.2lf °C\n" \
GPRINT:Temperatur1:MAX:"  Maximum\: %10.2lf °C\t\t" \
GPRINT:Temperatur2:MAX:"  Maximum\: %10.2lf °C\n" \
GPRINT:Temperatur1:MIN:"  Minimum\: %10.2lf °C\t\t" \
GPRINT:Temperatur2:MIN:"  Minimum\: %10.2lf °C\n" \
GPRINT:Temperatur1:AVERAGE:"  Mittel\:  %10.2lf °C\t\t" \
GPRINT:Temperatur2:AVERAGE:"  Mittel\:  %10.2lf °C\n" \

