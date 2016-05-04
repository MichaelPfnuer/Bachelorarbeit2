<?php 
$file = '/sys/devices/w1_bus_master1/10-000802e7fc08/w1_slave';
$lines = file($file);
$temp = explode('=', $lines[1]);
$temp = number_format($temp[1]/1000, 1, '.', '');
$temps = explode(",", $temp);
?>

<?php echo $temps[0];?>
