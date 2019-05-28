function markAllAbsent(){
	var absent_checkbox = document.getElementById("absent");
	var elements = document.getElementsByTagName("select");
	if(absent_checkbox.checked==true){			
		for(var i = 0; i < elements.length; i++) {
			elements[i].value = "Absent";
			elements[i].className = "Absent";
		}
	}else{
		for(var i = 0; i < elements.length; i++) {
			elements[i].value = "Present";
			elements[i].className = "Present";
		}
	}
}

function display(evt){
	var elements = document.getElementsByTagName("select");
	var file = document.getElementById("attendance_csv");
	var f =  evt.target.files[0]; 
	if (f) {
      var r = new FileReader();
      r.onload = function(e) { 
	     	var contents = e.target.result;
        	var array = contents.split("\n");
        	console.log(array[5]);
        	for(var i = 0; i < elements.length; i++) {
        		var arr = array[i+1].split(",");
        		var str = arr[1].replace(/["]+/g, '').trim();
        		var val = str.charAt(0).toUpperCase() + str.slice(1);
        		//console.log(val);
        		elements[i].value = val;
        		elements[i].className = val;
        	}	
      }
      //console.log(elements);
      r.readAsText(f);
      document.getElementById("display-message").innerHTML = "Attendance Automatically Changed";
	}else{ 
	  alert("Failed to load file. Manually Take Attendance");
	}
}

document.getElementById("attendance_csv").addEventListener("change", display, false);