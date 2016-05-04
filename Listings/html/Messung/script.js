//Script Temperatur
$(document).ready(function()
{
	//AJAX Funktion
	function setTemp()
	{
		$.get("DS18S20.php", function(data)
		{
			document.getElementById('temp').innerHTML = data + "°c";
			
			if(data < 28)
			{
				$("#Warnung").css("visibility", 'hidden');
				$("#temp").css("color", "green");
			}
			else
			{
				$("#Warnung").css("visibility", 'visible');
				$("#temp").css("color", "red");
				blinker();
			}
			
		});
		
	};	
	setInterval(setTemp, 100);
	
	//Warnmeldung Blinken
	function blinker()
	{
			$('#Warnung').fadeOut(500);
			$('#Warnung').fadeIn(500);
	}
});	
