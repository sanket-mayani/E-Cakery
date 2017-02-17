
$(document).ready(function(){
	
	/* --------------------
		Navigation Bar 
	-------------------- */

	$("#cake_flavours a, #categories a").mouseenter(function(){
		$(this).css("color","white");
		$(this).css("background-color","#526369");		
	});

	$("#cake_flavours a, #categories a").mouseleave(function(){
		$(this).css("color","black");
		$(this).css("background-color","#eeeeee");		
	});
	
	
	/* --------------------
		Registration Form 
	-------------------- */
	
	$("#re-pwd, #pwd").keyup(function(){		
		var x = $("#pwd").val();
		var y = $("#re-pwd").val();
		
		if(x != y){
			$("#pwd_msg").show();
			pwd_flag = false;
		}
		
		else{
			$("#pwd_msg").hide();
			pwd_flag = true;
		}		
	});
	
	$("#reg_email").focus(function(){
		$("#submit").attr("disabled","disabled");
	});
	
	$("#reg_email").blur(function(){		
		$("#reg_email_msg").hide();
		reg_email_flag = true;
		var uname = $("#reg_email").val();
		var hreq=new XMLHttpRequest();
		hreq.onreadystatechange= function(){
			if(hreq.readyState==4){
				var response=hreq.responseText;
				if(response==1){		
					$("#reg_email_msg").show();
					reg_email_flag = false;
				}
				else{
					$("#submit").removeAttr("disabled");
				}
			}		
		}
		
		hreq.open("get", "UserCheck?u="+uname+"&type=user", true);
		hreq.send();		
	});
	
	$("#mobile").keyup(function(){		
		  var phoneno = /^\d{10}$/;
		  if($("#mobile").val().match(phoneno))
		  {
			  $("#mobile_msg").hide();
			  mobile_flag = true;
		  }
		  else
		  {
		       $("#mobile_msg").show();
		       mobile_flag = false;
		  }		
	});

	$("#reg_form").submit(function(){
		return (reg_email_flag && pwd_flag && mobile_flag);
	});
	
	
	/* --------------------
		Login Form 
	-------------------- */
	
	$("#login_email").focus(function(){
		$("#login").attr("disabled","disabled");
	});
	
	$("#login_email").blur(function(){		
		$("#login_email_msg").hide();
		login_email_flag = true;
		var uname = $("#login_email").val();
		var hreq=new XMLHttpRequest();
		hreq.onreadystatechange= function(){
			if(hreq.readyState==4){
				var response=hreq.responseText;
				if(response==0){		
					$("#login_email_msg").show();
					login_email_flag = false;
				}
				else{
					$("#login").removeAttr("disabled");
				}
			}		
		}
		
		hreq.open("get", "UserCheck?u="+uname+"&type=user", true);
		hreq.send();		
	});
	
	$("#login_form").submit(function(){
		return (login_email_flag);
	});
	
});