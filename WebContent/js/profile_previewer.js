function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
          $('#preview_photo').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
      }
}

$("#photo").change(function() {
    readURL(this);
});
            
function displayUsername(){
	var fname = document.getElementById("fname").value.toLowerCase();
	var lname = document.getElementById("lname").value.toLowerCase();
	document.getElementById("username").defaultValue = fname + "." + lname;
}