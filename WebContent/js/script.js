
$(document).ready(function(){
	
/* --------------------
	index.jsp 
-------------------- */
	
	
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
	
	
/* --------------------
	seller-index.jsp 
-------------------- */
	
	
	/* --------------------
		Seller Registration Form 
	-------------------- */
	
	
	$("#seller_reg_email").focus(function(){
		$("#start_selling").attr("disabled","disabled");
	});
	
	$("#seller_reg_email").blur(function(){		
		$("#seller_reg_email_msg").hide();
		seller_reg_email_flag = true;
		var uname = $("#seller_reg_email").val();
		var hreq=new XMLHttpRequest();
		hreq.onreadystatechange= function(){
			if(hreq.readyState==4){
				var response=hreq.responseText;
				if(response==1){		
					$("#seller_reg_email_msg").show();
					seller_reg_email_flag = false;
				}
				else{
					$("#start_selling").removeAttr("disabled");
				}
			}		
		}
		
		hreq.open("get", "UserCheck?u="+uname+"&type=seller", true);
		hreq.send();		
	});
	
	$("#seller_mobile").keyup(function(){		
		  var phoneno = /^\d{10}$/;
		  if($("#seller_mobile").val().match(phoneno))
		  {
			  $("#seller_mobile_msg").hide();
			  seller_mobile_flag = true;
		  }
		  else
		  {
		       $("#seller_mobile_msg").show();
		       seller_mobile_flag = false;
		  }		
	});
	
	$("#seller_re-pwd, #seller_pwd").keyup(function(){		
		var x = $("#seller_pwd").val();
		var y = $("#seller_re-pwd").val();
		
		if(x != y){
			$("#seller_pwd_msg").show();
			seller_pwd_flag = false;
		}
		
		else{
			$("#seller_pwd_msg").hide();
			seller_pwd_flag = true;
		}		
	});

	$("#seller_reg_form").submit(function(){
		return (seller_reg_email_flag && seller_mobile_flag && seller_pwd_flag);
	});
	
	
	/* --------------------
		Seller Login Form 
	-------------------- */
	
	$("#seller_login_email, #seller_login_email2").focus(function(){
		$("#seller_login, #seller_login2").attr("disabled","disabled");
	});
	
	$("#seller_login_email, #seller_login_email2").blur(function(){		
		$("#seller_login_email_msg, #seller_login_email_msg2").hide();
		seller_login_email_flag = true;
		var uname = $(this).val();
		var hreq=new XMLHttpRequest();
		hreq.onreadystatechange= function(){
			if(hreq.readyState==4){
				var response=hreq.responseText;
				if(response==0){		
					$("#seller_login_email_msg, #seller_login_email_msg2").show();
					seller_login_email_flag = false;
				}
				else{
					$("#seller_login, #seller_login2").removeAttr("disabled");
				}
			}		
		}
		
		hreq.open("get", "UserCheck?u="+uname+"&type=seller", true);
		hreq.send();		
	});
	
	$("#seller_login_form, #seller_login_form2").submit(function(){
		return (seller_login_email_flag);
	});
	
	
/* --------------------
	seller-home.jsp 
-------------------- */
	
	
	
});