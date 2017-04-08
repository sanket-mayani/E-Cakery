
$(document).ready(function(){
	
/* --------------------
	index.jsp 
-------------------- */
	
	$("#index .item").height($("#index #fit_to_screen").height()-$("#index #heading_section").outerHeight());
	
	$(window).resize(function(){
		$("#index .item").height($("#index #fit_to_screen").height()-$("#index #heading_section").outerHeight());
	});
	
	$("#index .img_section").mouseenter(function(){
		$(this).css("opacity",0.7);
		$(this).css("color","black");
	});
	
	$("#index .img_section").mouseleave(function(){
		$(this).css("opacity",1);
		$(this).css("color","white");
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
	seller-account.jsp 
-------------------- */
	
	$("#seller_basic_details .edit").click(function(){
		
		$("#name,#mobile,#acc,#pan,#ifsc,#vat").removeAttr("disabled");
		
	});
	
	$("#seller_address_details .edit").click(function(){
		
		$("#address,#pin,#city").removeAttr("disabled");
		
	});
	

	
/* --------------------
	add-product.jsp 
-------------------- */	
	
	var flavour_flag, category_flag, floor_flag, price_flag, quantity_flag, weight_flag;
	
	$("#choose_file").change(function(){

		var reader = new FileReader();
		
		reader.onload = function(e){
			$("#product_img_div img").attr("src",e.target.result);
			$("#product_img_div img").css("height",$("#product_img_div").height());
			$("#product_img_div img").css("width",$("#product_img_div").width());
		}
		
		reader.readAsDataURL(this.files[0]);
	});
	
	$(window).resize(function(){
		$("#product_img_div img").css("width",$("#product_img_div").width());
	});
	
	$("#flavour").change(function(){
		if($("#flavour").val() == 0)
		{
			$("#flavour_msg").removeAttr("hidden");
			flavour_flag = false;
		}
		else{
			$("#flavour_msg").attr("hidden","hidden");
			flavour_flag = true;
		}
	});
	
	$("#add_product_btn").click(function(){
		if($("#flavour").val() == 0)
		{
			$("#flavour_msg").removeAttr("hidden");
			flavour_flag = false;
		}
		else{
			$("#flavour_msg").attr("hidden","hidden");
			flavour_flag = true;
		}
		
		if($("#floor").val() == 0)
		{
			$("#floor_msg").removeAttr("hidden");
			floor_flag = false;
		}
		else{
			$("#floor_msg").attr("hidden","hidden");
			floor_flag = true;
		}
		
		if($("#weight").val() == 0)
		{
			$("#weight_msg").removeAttr("hidden");
			weight_flag = false;
		}
		else{
			$("#weight_msg").attr("hidden","hidden");
			weight_flag = true;
		}
	});
	
	$("#category").change(function(){
		if($("#category").val() == 0)
		{
			$("#category_msg").removeAttr("hidden");
			category_flag = false;
		}
		else{
			$("#category_msg").attr("hidden","hidden");
			category_flag = true;
		}
	});
	
	$("#floor").change(function(){
		if($("#floor").val() == 0)
		{
			$("#floor_msg").removeAttr("hidden");
			floor_flag = false;
		}
		else{
			$("#floor_msg").attr("hidden","hidden");
			floor_flag = true;
		}
	});
	
	$("#weight").change(function(){
		if($("#weight").val() == 0)
		{
			$("#weight_msg").removeAttr("hidden");
			weight_flag = false;
		}
		else{
			$("#weight_msg").attr("hidden","hidden");
			weight_flag = true;
		}
	});
	
	$("#price").change(function(){
		var price = $("#price").val();
		if(/^\d*(.\d{2})?$/.test(price))
		{
			price_flag = true;
			$("#price_msg").attr("hidden","hidden");
		}
		else{
			price_flag = false;
			$("#price_msg").removeAttr("hidden");
		}
	});
	
	$("#quantity").change(function(){
		var quantity = $("#quantity").val();
		if(/^\+?([1-9]\d*)$/.test(quantity))
		{
			quantity_flag = true;
			$("#quantity_msg").attr("hidden","hidden");
		}
		else{
			quantity_flag = false;
			$("#quantity_msg").removeAttr("hidden");
		}
	});
	
	$("#add_product_form").submit(function(){
		return flavour_flag && category_flag && floor_flag && price_flag && quantity_flag && weight_flag;
	});	
	
	
/* --------------------
	photo-cake.jsp 
-------------------- */	
	
	$("#userPhoto").change(function(){

		var reader = new FileReader();
		
		reader.onload = function(e){
			$("#uploadedPhoto").attr("src",e.target.result);
		}
		
		reader.readAsDataURL(this.files[0]);
	});
	
	
/* --------------------
	user-orders.jsp 
-------------------- */	

	$("#user_orders .cancel_btn").click(function(){
		var id = $(this).attr('id');
		$("#oid_field").val(id);
		$("#orderCancellationModal").modal('show');
	});	


/* --------------------
	order.jsp 
-------------------- */	

	$("#order .cancel_btn").click(function(){
		var id = $(this).attr('id');
		$("#oid_field").val(id);
		$("#orderCancellationModal").modal('show');
	});		
	
	
});