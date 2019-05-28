function validate(){
	var fname=document.myform.fullname.value;
	var fe=new RegExp("^[a-zA-Z ]*$");
	if(!fe.test(fname))
	{
		document.getElementById("a").innerHTML="Name must consist of alphabets only";
		return false;
	}
	var uname=document.myform.username.value;
	var ue=new RegExp("[a-zA-Z0-9]{5,}")
	if(!ue.test(uname))
	{
		document.getElementById("b").innerHTML="Username must be a minimum of 5 characters and must consist of alphabets and digits only.";
		return false;
	}
	var p=document.myform.password.value;
	if(p.length<5)
	{
		document.getElementById("c").innerHTML="password must be greater than 5 characters.";
		return false;
	}
	var cp=document.myform.confirm_password.value;
	if(p!=cp)
	{
		document.getElementById("d").innerHTML="Confirm password field must be equal to password field.";
		return false;
	}
	var num=document.myform.contact.value;
	var ne=new RegExp("[1-9][0-9]{9}");
	if(!ne.test(num) || num.length != 10)
	{
		document.getElementById("e").innerHTML="Number must be of 10 digits.";
		return false;
	}
	return true;
}