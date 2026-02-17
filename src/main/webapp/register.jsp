<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="demo_barbershop.customer.Customer"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="pixelstrap">
<link rel="icon" href="assets/images/favicon/favicon.png"
	type="image/x-icon">
<link rel="shortcut icon" href="assets/images/favicon/favicon.png"
	type="image/x-icon">
<title>Demo Barbershop</title>
<!-- Google font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&amp;display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/font-awesome.css">
<!-- ico-font-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/icofont.css">
<!-- Themify icon-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/themify.css">
<!-- Flag icon-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/flag-icon.css">
<!-- Feather icon-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/feather-icon.css">
<!-- Plugins css start-->
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="assets/css/vendors/extra/validation.css">
<link rel="stylesheet" type="text/css" href="assets/css/style.css">
<link id="color" rel="stylesheet" href="assets/css/color-6.css"
	media="screen">
<!-- Responsive css-->
<link rel="stylesheet" type="text/css" href="assets/css/responsive.css">
</head>
<body>
	<!-- Loader starts-->
	<div class="loader-wrapper">
		<div class="loader"></div>
	</div>
	<!-- Loader ends-->
	<!-- login page start-->
	<div class="container-fluid p-0">
		<div class="row m-0">
			<div class="col-12 p-0">
				<div class="login-card">
					<div>
						<div>
							<a class="logo text-center" href="index.jsp"><img
								class="img-fluid for-light" src="assets/images/logo/login.png"
								alt="loginpage"></a>
						</div>
						
						<!-- display message on user actions -->
						<div class="login-main">
							<%
							String message = null;

							if (request.getAttribute("weak_password") != null)
								message = "weak_password";
							else if (request.getAttribute("password_mismatch") != null)
								message = "password_mismatch";
							else if (request.getAttribute("email_exists") != null)
								message = "email_exists";

							if (message != null) {
								switch (message) {
								case "weak_password":
							%><div class="alert alert-danger text-center"><%=request.getAttribute("weak_password")%></div>
							<%
							break;
							case "password_mismatch":
							%><div class="alert alert-danger text-center"><%=request.getAttribute("password_mismatch")%></div>
							<%
							break;
							case "email_exists":
							%><div class="alert alert-danger text-center"><%=request.getAttribute("email_exists")%></div>
							<%
							break;
							}
							}
							%>

							<form class="theme-form needs-validation" novalidate
								action="RegisterCustomerView" method="post">
								<h4 class="text-center">Create your account</h4>
								<p class="text-center">Enter your personal details to create
									account</p>
								<div class="form-group">
									<label class="form-label">Full Name</label> <input
										class="form-control" type="text" name="full_name"
										placeholder="Enter Full Name" required>
									<div class="valid-feedback">Full name looks good!</div>
									<div class="invalid-feedback">Please enter full name.</div>
								</div>

								<div class="form-group">
									<label class="form-label">Email</label>
									<div class="input-group left-radius">
										<span class="input-group-text" id="inputGroupPrepend">@</span>
										<input class="form-control" type="email" name="email"
											placeholder="example@email.com"
											aria-describedby="inputGroupPrepend" required>
										<div class="valid-feedback">Email looks valid!</div>
										<div class="invalid-feedback">Please enter a valid email
											address.</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-form-label">Password<span
										data-bs-toggle="tooltip" data-bs-placement="right"
										title="Password must be at least 8 characters and contain a symbol.">
											<i class="fa fa-question-circle"></i>
									</span></label>
									<div class="form-input position-relative">
										<input class="form-control" type="password" name="password"
											placeholder="*********" required>
										<div class="valid-feedback">Password looks good!</div>
										<div class="invalid-feedback">Please enter password.</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-form-label">Confirm Password</label>
									<div class="form-input position-relative">
										<input class="form-control" type="password"
											name="confirm_password" placeholder="*********" required>
										<div class="valid-feedback">Password looks good!</div>
										<div class="invalid-feedback">Please enter password.</div>
									</div>
								</div>
								<div class="form-group">
									<label class="form-label">Phone Number</label> <input
										class="form-control" type="tel" name="phone_num"
										placeholder="e.g. 0182733029" pattern="[0-9]{10,11}" required>
									<div class="valid-feedback">Phone number looks good!</div>
									<div class="invalid-feedback">Please enter a valid phone
										number.</div>
								</div>
								<div class="form-group">
									<button class="btn btn-primary btn-block w-100 mt-3"
										type="submit">Create Account</button>
								</div>
								<p class="mt-4 mb-0 text-center">
									Already have an account?<a class="ms-2" href="login.jsp">Sign
										in</a>
								</p>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Bootstrap -->
		<script src="assets/js/jquery-3.6.0.min.js"></script>
		<script src="assets/js/bootstrap/bootstrap.bundle.min.js"></script>
		<script src="assets/js/icons/feather-icon/feather.min.js"></script>
		<script src="assets/js/icons/feather-icon/feather-icon.js"></script>
		<script src="assets/js/config.js"></script>
		<script src="assets/js/script.js"></script>
		<script src="assets/js/form-validation-custom.js"></script>
	</div>
</body>
</html>