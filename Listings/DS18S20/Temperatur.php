#!/usr/bin/php
<?php
$temperatur01 = exec('cat /sys/bus/w1/devices/10-000802e7fc08/w1_slave |grep t=');
$temperatur01 = explode('t=', $temperatur01);
$temperatur01 = $temperatur01[1]/1000;
$temperatur01 = round($temperatur01,2);

$temperatur02 = exec('cat /sys/bus/w1/devices/10-000803190694/w1_slave |grep t=');
$temperatur02 = explode('t=', $temperatur02);
$temperatur02 = $temperatur02[1]/1000;
$temperatur02 = round($temperatur02,2);
exec("sudo /usr/bin/rrdtool update /home/pi/Temperatur/TemperaturSensor/TemperaturAufzeichnungDB18S20.rrd N:$temperatur01:$temperatur02");

?>
