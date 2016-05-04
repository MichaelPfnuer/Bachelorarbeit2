#!/bin/sh

#Grafik erstellen
sudo rrdtool graph /var/www/html/Messung/Bilder/TemperaturStunde.png \
-w 900 -h 600 -t "Temperaturverlauf letzte Stunde" \
--end now --start end-1h -v "Temperatur(°C)" --y-grid=0.2:5 --slope-mode --no-gridfit \
--grid-dash 1:0 \
--x-grid MINUTE:1:MINUTE:15:MINUTE:5:0:%R \
-c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff \
DEF:HYT_Temp=/home/pi/Temperatur/Messung/Messung.rrd:HYT_Temp:AVERAGE \
DEF:DB18S20_Temp=/home/pi/Temperatur/Messung/Messung.rrd:DB18S20_Temp:AVERAGE \
DEF:DB18S20_Kabel_Temp=/home/pi/Temperatur/Messung/Messung.rrd:DB18S20_Kabel_Temp:AVERAGE \
VDEF:Temp1Cur=HYT_Temp,LAST \
VDEF:Temp1Max=HYT_Temp,MAXIMUM \
VDEF:Temp1Avg=HYT_Temp,AVERAGE \
VDEF:Temp1Min=HYT_Temp,MINIMUM \
VDEF:Temp2Cur=DB18S20_Temp,LAST \
VDEF:Temp2Max=DB18S20_Temp,MAXIMUM \
VDEF:Temp2Avg=DB18S20_Temp,AVERAGE \
VDEF:Temp2Min=DB18S20_Temp,MINIMUM \
VDEF:Temp3Cur=DB18S20_Kabel_Temp,LAST \
VDEF:Temp3Max=DB18S20_Kabel_Temp,MAXIMUM \
VDEF:Temp3Avg=DB18S20_Kabel_Temp,AVERAGE \
VDEF:Temp3Min=DB18S20_Kabel_Temp,MINIMUM \
COMMENT:"                    " \
COMMENT:"Current   " \
COMMENT:"Maximum   " \
COMMENT:"Average   " \
COMMENT:"Minimum \l" \
LINE2:HYT_Temp#4CCDFF:"HYT 221" \
GPRINT:Temp1Cur:"           %2.2lf %S°C" \
GPRINT:Temp1Max:" %2.2lf %S°C" \
GPRINT:Temp1Avg:" %2.2lf %S°C" \
GPRINT:Temp1Min:" %2.2lf %S°C\l" \
LINE2:DB18S20_Temp#22BA32:"DB18S20 mit Kabel" \
GPRINT:Temp2Cur:" %2.2lf %S°C" \
GPRINT:Temp2Max:" %2.2lf %S°C" \
GPRINT:Temp2Avg:" %2.2lf %S°C" \
GPRINT:Temp2Min:" %2.2lf %S°C\l" \
LINE2:DB18S20_Kabel_Temp#AF2834:"DB18S20" \
GPRINT:Temp3Cur:"           %2.2lf %S°C" \
GPRINT:Temp3Max:" %2.2lf %S°C" \
GPRINT:Temp3Avg:" %2.2lf %S°C" \
GPRINT:Temp3Min:" %2.2lf %S°C\l" \



sudo rrdtool graph /var/www/html/Messung/Bilder/TemperaturTag.png \
-w 900 -h 600 -t "Temperaturverlauf letzte 10 Stunden" \
--end now --start end-10h -v "Temperatur(°C)" --y-grid=0.5:2 --slope-mode --no-gridfit \
--grid-dash 1:0 \
--x-grid MINUTE:20:HOUR:1:MINUTE:60:0:%R \
-c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff \
DEF:HYT_Temp=/home/pi/Temperatur/Messung/Messung.rrd:HYT_Temp:AVERAGE \
DEF:DB18S20_Temp=/home/pi/Temperatur/Messung/Messung.rrd:DB18S20_Temp:AVERAGE \
DEF:DB18S20_Kabel_Temp=/home/pi/Temperatur/Messung/Messung.rrd:DB18S20_Kabel_Temp:AVERAGE \
VDEF:Temp1Cur=HYT_Temp,LAST \
VDEF:Temp1Max=HYT_Temp,MAXIMUM \
VDEF:Temp1Avg=HYT_Temp,AVERAGE \
VDEF:Temp1Min=HYT_Temp,MINIMUM \
VDEF:Temp2Cur=DB18S20_Temp,LAST \
VDEF:Temp2Max=DB18S20_Temp,MAXIMUM \
VDEF:Temp2Avg=DB18S20_Temp,AVERAGE \
VDEF:Temp2Min=DB18S20_Temp,MINIMUM \
VDEF:Temp3Cur=DB18S20_Kabel_Temp,LAST \
VDEF:Temp3Max=DB18S20_Kabel_Temp,MAXIMUM \
VDEF:Temp3Avg=DB18S20_Kabel_Temp,AVERAGE \
VDEF:Temp3Min=DB18S20_Kabel_Temp,MINIMUM \
COMMENT:"                    " \
COMMENT:"Current   " \
COMMENT:"Maximum   " \
COMMENT:"Average   " \
COMMENT:"Minimum \l" \
LINE2:HYT_Temp#4CCDFF:"HYT 221" \
GPRINT:Temp1Cur:"           %2.2lf %S°C" \
GPRINT:Temp1Max:" %2.2lf %S°C" \
GPRINT:Temp1Avg:" %2.2lf %S°C" \
GPRINT:Temp1Min:" %2.2lf %S°C\l" \
LINE2:DB18S20_Temp#22BA32:"DB18S20 mit Kabel" \
GPRINT:Temp2Cur:" %2.2lf %S°C" \
GPRINT:Temp2Max:" %2.2lf %S°C" \
GPRINT:Temp2Avg:" %2.2lf %S°C" \
GPRINT:Temp2Min:" %2.2lf %S°C\l" \
LINE2:DB18S20_Kabel_Temp#AF2834:"DB18S20" \
GPRINT:Temp3Cur:"           %2.2lf %S°C" \
GPRINT:Temp3Max:" %2.2lf %S°C" \
GPRINT:Temp3Avg:" %2.2lf %S°C" \
GPRINT:Temp3Min:" %2.2lf %S°C\l" \



sudo rrdtool graph /var/www/html/Messung/Bilder/Temperatur3Tage.png \
-w 900 -h 600 -t "Temperaturverlauf letzte 3 Tage" \
--end now --start end-3d -v "Temperatur(°C)" --y-grid=0.5:2 --slope-mode --no-gridfit \
--grid-dash 1:0 \
--x-grid HOUR:4:HOUR:12:MINUTE:720:0:%A" "%R \
-c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff \
DEF:HYT_Temp=/home/pi/Temperatur/Messung/Messung.rrd:HYT_Temp:AVERAGE \
DEF:DB18S20_Temp=/home/pi/Temperatur/Messung/Messung.rrd:DB18S20_Temp:AVERAGE \
DEF:DB18S20_Kabel_Temp=/home/pi/Temperatur/Messung/Messung.rrd:DB18S20_Kabel_Temp:AVERAGE \
VDEF:Temp1Cur=HYT_Temp,LAST \
VDEF:Temp1Max=HYT_Temp,MAXIMUM \
VDEF:Temp1Avg=HYT_Temp,AVERAGE \
VDEF:Temp1Min=HYT_Temp,MINIMUM \
VDEF:Temp2Cur=DB18S20_Temp,LAST \
VDEF:Temp2Max=DB18S20_Temp,MAXIMUM \
VDEF:Temp2Avg=DB18S20_Temp,AVERAGE \
VDEF:Temp2Min=DB18S20_Temp,MINIMUM \
VDEF:Temp3Cur=DB18S20_Kabel_Temp,LAST \
VDEF:Temp3Max=DB18S20_Kabel_Temp,MAXIMUM \
VDEF:Temp3Avg=DB18S20_Kabel_Temp,AVERAGE \
VDEF:Temp3Min=DB18S20_Kabel_Temp,MINIMUM \
COMMENT:"                    " \
COMMENT:"Current   " \
COMMENT:"Maximum   " \
COMMENT:"Average   " \
COMMENT:"Minimum \l" \
LINE2:HYT_Temp#4CCDFF:"HYT 221" \
GPRINT:Temp1Cur:"           %2.2lf %S°C" \
GPRINT:Temp1Max:" %2.2lf %S°C" \
GPRINT:Temp1Avg:" %2.2lf %S°C" \
GPRINT:Temp1Min:" %2.2lf %S°C\l" \
LINE2:DB18S20_Temp#22BA32:"DB18S20 mit Kabel" \
GPRINT:Temp2Cur:" %2.2lf %S°C" \
GPRINT:Temp2Max:" %2.2lf %S°C" \
GPRINT:Temp2Avg:" %2.2lf %S°C" \
GPRINT:Temp2Min:" %2.2lf %S°C\l" \
LINE2:DB18S20_Kabel_Temp#AF2834:"DB18S20" \
GPRINT:Temp3Cur:"           %2.2lf %S°C" \
GPRINT:Temp3Max:" %2.2lf %S°C" \
GPRINT:Temp3Avg:" %2.2lf %S°C" \
GPRINT:Temp3Min:" %2.2lf %S°C\l" \



sudo rrdtool graph /var/www/html/Messung/Bilder/FeuchtigkeitStunde.png \
-w 900 -h 600 -t "Luftfeuchtigkeit letzte Stunde" \
--end now --start end-1h -v "Luftfeuchtigkeit(%rF)" --y-grid=0.1:10 --slope-mode --no-gridfit \
--grid-dash 1:0 \
--x-grid MINUTE:1:MINUTE:15:MINUTE:5:0:%R \
-c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff \
DEF:HYT_Feucht=/home/pi/Temperatur/Messung/Messung.rrd:HYT_Feucht:AVERAGE \
VDEF:FeuchtCur=HYT_Feucht,LAST \
VDEF:FeuchtMax=HYT_Feucht,MAXIMUM \
VDEF:FeuchtAvg=HYT_Feucht,AVERAGE \
VDEF:FeuchtMin=HYT_Feucht,MINIMUM \
COMMENT:"                    " \
COMMENT:"Current   " \
COMMENT:"Maximum   " \
COMMENT:"Average   " \
COMMENT:"Minimum \l" \
AREA:HYT_Feucht#4CCDFF:"HYT 221" \
GPRINT:FeuchtCur:"           %2.2lf %S°C" \
GPRINT:FeuchtMax:" %2.2lf %S°C" \
GPRINT:FeuchtAvg:" %2.2lf %S°C" \
GPRINT:FeuchtMin:" %2.2lf %S°C\l" \



sudo rrdtool graph /var/www/html/Messung/Bilder/FeuchtigkeitTag.png \
-w 900 -h 600 -t "Luftfeuchtigkeit letzte 10 Stunden" \
--end now --start end-10h -v "Luftfeuchtigkeit(%rF)" --y-grid=0.5:2 --slope-mode --no-gridfit \
--grid-dash 1:0 \
--x-grid MINUTE:20:HOUR:1:MINUTE:60:0:%R \
-c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff \
DEF:HYT_Feucht=/home/pi/Temperatur/Messung/Messung.rrd:HYT_Feucht:AVERAGE \
VDEF:FeuchtCur=HYT_Feucht,LAST \
VDEF:FeuchtMax=HYT_Feucht,MAXIMUM \
VDEF:FeuchtAvg=HYT_Feucht,AVERAGE \
VDEF:FeuchtMin=HYT_Feucht,MINIMUM \
COMMENT:"                    " \
COMMENT:"Current   " \
COMMENT:"Maximum   " \
COMMENT:"Average   " \
COMMENT:"Minimum \l" \
AREA:HYT_Feucht#4CCDFF:"HYT 221" \
GPRINT:FeuchtCur:"           %2.2lf %S°C" \
GPRINT:FeuchtMax:" %2.2lf %S°C" \
GPRINT:FeuchtAvg:" %2.2lf %S°C" \
GPRINT:FeuchtMin:" %2.2lf %S°C\l" \



sudo rrdtool graph /var/www/html/Messung/Bilder/Feuchtigkeit3Tage.png \
-w 900 -h 600 -t "Luftfeuchtigkeit letzte 3 Tage" \
--end now --start end-3d -v "Luftfeuchtigkeit(%rF)" --y-grid=0.5:2 --slope-mode --no-gridfit \
--grid-dash 1:0 \
--x-grid HOUR:4:HOUR:12:MINUTE:720:0:%A" "%R \
-c GRID#000000 -c BACK#aaaaaa -c SHADEA#ffffff -c SHADEB#ffffff \
DEF:HYT_Feucht=/home/pi/Temperatur/Messung/Messung.rrd:HYT_Feucht:AVERAGE \
VDEF:FeuchtCur=HYT_Feucht,LAST \
VDEF:FeuchtMax=HYT_Feucht,MAXIMUM \
VDEF:FeuchtAvg=HYT_Feucht,AVERAGE \
VDEF:FeuchtMin=HYT_Feucht,MINIMUM \
COMMENT:"                    " \
COMMENT:"Current   " \
COMMENT:"Maximum   " \
COMMENT:"Average   " \
COMMENT:"Minimum \l" \
AREA:HYT_Feucht#4CCDFF:"HYT 221" \
GPRINT:FeuchtCur:"           %2.2lf %S°C" \
GPRINT:FeuchtMax:" %2.2lf %S°C" \
GPRINT:FeuchtAvg:" %2.2lf %S°C" \
GPRINT:FeuchtMin:" %2.2lf %S°C\l" \
