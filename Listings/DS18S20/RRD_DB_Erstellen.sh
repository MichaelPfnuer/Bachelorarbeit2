#!/bin/sh
sudo rrdtool create TemperaturAufzeichnungDB18S20.rrd --step 60 \
DS:Temperatur1:GAUGE:120:-30:120 \
RRA:AVERAGE:0.5:1:600 \
RRA:MAX:0.5:1440:365 \
RRA:MIN:0.5:1440:365 \
RRA:AVERAGE:0.5:60:720 \
RRA:AVERAGE:0.5:240:720 \
RRA:AVERAGE:0.5:1440:365


