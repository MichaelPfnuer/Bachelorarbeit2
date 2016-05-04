//Script Vibration
$(document).ready(function()
{
	//AJAX Funktion
	function setVib()
	{
		$.get("BMA.php", function(data)
		{
			var Daten = data.split(" ");
			$("#Warnung").css("visibility", 'hidden');
			$("#xWert").css("color", "green");
			$("#yWert").css("color", "green");
			$("#zWert").css("color", "green");
			
			if(Daten[0] > 0.200 || Daten[0] < -0.200)
			{
				$("#xWert").css("color", "orange");
			}
			if(Daten[1] > 0.200 || Daten[1] < -0.200)
			{
				$("#yWert").css("color", "orange");
			}
			if(Daten[2] > -0.800 || Daten[2] < -1.200)
			{
				$("#zWert").css("color", "orange");
			}
			if(Daten[0] > 0.500 || Daten[0] < -0.500)
			{
				$("#xWert").css("color", "red");
			}
			if(Daten[1] > 0.500 || Daten[1] < -0.500)
			{
				$("#yWert").css("color", "red");
			}
			if(Daten[2] > -0.500 || Daten[2] < -1.500)
			{
				$("#zWert").css("color", "red");
			}
			
			if(Daten[0] > 0.500 || Daten[0] < -0.500 || Daten[1] > 0.500 || Daten[1] < -0.500 || Daten[2] > -0.500 || Daten[2] < -1.500)
			{
				$("#Warnung").css("visibility", 'visible');
				blinker();
			}
			
			document.getElementById('xWert').innerHTML = Daten[0] + " g";
			document.getElementById('yWert').innerHTML = Daten[1] + " g";
			document.getElementById('zWert').innerHTML = Daten[2] + " g";
		});
	};	
	setInterval(setVib, 100);
	
	//Warnmeldung Blinken
	function blinker()
	{
			$('#Warnung').fadeOut(500);
			$('#Warnung').fadeIn(500);
	}
});	
