
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>http://Temperatur Auswertung</title>
<link href="style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

var Tempe = 0;	

function setTemp(){

<?php 
$file = '/sys/devices/w1_bus_master1/10-000802e7fc08/w1_slave';
$lines = file($file);
$temp = explode('=', $lines[1]);
$temp = number_format($temp[1]/1000, 1, '.', '');
$temps = explode(",", $temp);
?>
Tempe = <?php echo $temps[0];?>;

	document.getElementById('temp').innerHTML = Tempe + "°c";
	Tempe = 0;
	}
	setInterval(setTemp,1000);
	

</script>

</head>

<body onLoad="Test();">
<p align="center" id="id1">Temperaturauswertung</p>

<div  style="margin: 30px" align="center">
<h2>Aktuelle Temperatur</h2>
<div class="container">
	<div class="de">
		<div class="den">
			<div class="dene">
				<div class="denem">
					<div class="deneme">
					<span id="temp"></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

<div id="all" align="center"  >

	<img style="margin-top 30px" src="Imagebild.png" alt="Imagebild_Temperatur" width="600 px" height="400 px">
<h3 style="margin-top:30px">Temperatur:
<button id="temp1" type="button" style="margin-left: 20px; width:100px" onclick="window.open('TemperaturStunde.png')" target="_self" >1 Stunde</button>
<button id="temp10" type="button" style="margin-left: 20px; width:100px" onclick="window.open('TemperaturTag.png')">10 Stunden</button>
<button id="temp3T" type="button" style="margin-left: 20px; width:100px" onclick="window.open('Temperatur3Tage.png')">3 Tage</button>	 
</h3>

<h3 align="left" style="margin-left:634px">Luftfeuchtigkeit:
<button id="temp1" type="button" style="margin-left: 20px; width:100px" onclick="window.open('FeuchtigkeitStunde.png')" target="_self" >1 Stunde</button>
<button id="temp10" type="button" style="margin-left: 20px; width:100px" onclick="window.open('FeuchtigkeitTag.png')">10 Stunden</button>
<button id="temp3T" type="button" style="margin-left: 20px; width:100px" onclick="window.open('Feuchtigkeit3Tage.png')">3 Tage</button>	 
</h3></br>

<h3 align="right">SQL Datenbank:
<button id="SQL_DB" type="button" style="margin-left:20px; margin-right:100px; width:100px"  onclick="window.open('http://localhost/phpmyadmin/')">Go To</button>
</h3>
</div>
</div>

</body>
</html>
