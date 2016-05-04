<?php
	$file = '/home/pi/Projekt/Vibration/Daten.txt';
	$lines = file($file);
	$Daten = explode(" ",$lines[0]);
?>

<?php echo $Daten[0],' ',$Daten[1],' ',$Daten[2];?>
