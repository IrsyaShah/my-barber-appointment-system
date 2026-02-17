<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<div class="container-fluid">
		<div class="row">
			<div class="col-xl-7">
				<img class="bg-img-cover bg-center" src="assets/images/login/2.jpg"
					alt="loginpage">
			</div>
			<div class="col-xl-5 p-0">
				<div class="login-card">
					<div>
						<div>
							<a class="logo" href="index.jsp"><img
								class="img-fluid for-light" src="assets/images/logo/login.png"
								alt="loginpage"></a>
						</div>
						
						<!-- display message on user actions -->
						<div class="login-main">
							<%
							String error = (String) session.getAttribute("invalid");
							if (error != null) {
							%>
							<div class="alert alert-danger text-center"><%=error%></div>
							<%
							session.removeAttribute("invalid");
							}
							%>

							<%
							String message = null;

							if (session.getAttribute("acc_created") != null) {
								message = "acc_created";
								request.setAttribute("acc_created", session.getAttribute("acc_created"));
								session.removeAttribute("acc_created");
							} else if (session.getAttribute("change_pass") != null) {
								message = "change_pass";
								request.setAttribute("change_pass", session.getAttribute("change_pass"));
								session.removeAttribute("change_pass");
							}

							if (message != null) {
								switch (message) {
								case "acc_created":
							%>
							<div
								style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
								<div
									class="alert alert-success alert-dismissible fade show position-relative"
									role="alert" style="padding-right: 3rem;">
									<strong><%=request.getAttribute("acc_created")%></strong>
									<button type="button" class="btn-close" data-bs-dismiss="alert"
										aria-label="Close" style="position: absolute;"></button>
								</div>
							</div>
							<%
							break;
							case "change_pass":
							%>
							<div
								style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
								<div
									class="alert alert-success alert-dismissible fade show position-relative"
									role="alert" style="padding-right: 3rem;">
									<strong><%=request.getAttribute("change_pass")%></strong>
									<button type="button" class="btn-close" data-bs-dismiss="alert"
										aria-label="Close" style="position: absolute;"></button>
								</div>
							</div>
							<%
							break;
							}
							}
							%>

							<h4 class="text-center">Sign in to account</h4>
							<p class="text-center">Enter your login details</p>

							<!-- Pill Tabs -->
							<ul class="nav nav-pills justify-content-center mb-3"
								id="pills-login-tab" role="tablist">
								<li class="nav-item" role="presentation"><a
									class="nav-link active" id="pills-customer-tab"
									data-bs-toggle="pill" href="#pills-customer" role="tab"
									aria-controls="pills-customer" aria-selected="true"> <i
										class="fa fa-user"></i> Customer
								</a></li>
								<li class="nav-item" role="presentation"><a
									class="nav-link" id="pills-staff-tab" data-bs-toggle="pill"
									href="#pills-staff" role="tab" aria-controls="pills-staff"
									aria-selected="false"> <i class="fa fa-users"></i> Staff
								</a></li>
							</ul>

							<!-- Tab Content -->
							<div class="tab-content" id="pills-loginContent">

								<!-- Customer Login Form -->
								<div class="tab-pane fade show active" id="pills-customer"
									role="tabpanel" aria-labelledby="pills-customer-tab">
									<form class="theme-form needs-validation" novalidate
										action="<c:url value='/customer/LoginCustomerView' />"
										method="post">
										<input type="hidden" name="redirect"
											value="<%=request.getParameter("redirect") != null ? request.getParameter("redirect") : ""%>">
										<div class="form-group">
											<label class="col-form-label">Email Address</label> <input
												class="form-control" type="email" name="email"
												placeholder="Enter Email Address" autocomplete="username"
												required>
											<div class="valid-feedback">Email address looks good!</div>
											<div class="invalid-feedback">Please enter email
												address.</div>
										</div>

										<div class="form-group">
											<label class="col-form-label">Password</label>
											<div class="form-input position-relative">
												<input class="form-control" type="password" name="password"
													placeholder="*********" autocomplete="current-password"
													required>
												<div class="valid-feedback">Password looks good!</div>
												<div class="invalid-feedback">Please enter password.</div>
											</div>
										</div>

										<div class="form-group mb-0">
											<div class="checkbox p-3">
												<a class="link" href="forgot_password.jsp">Forgot
													password?</a>
											</div>
											<div class="text-end mt-3">
												<button class="btn btn-primary btn-block w-100"
													type="submit">Sign in</button>
											</div>
										</div>

										<p class="mt-4 mb-0 text-center">
											Don't have account? <a class="ms-2" href="register.jsp">Create
												Account</a>
										</p>
									</form>
								</div>

								<!-- Staff Login Form -->
								<div class="tab-pane fade" id="pills-staff" role="tabpanel"
									aria-labelledby="pills-staff-tab">
									<form class="theme-form needs-validation" novalidate
										action="<c:url value='/staff/LoginStaffView' />" method="post">
										<div class="form-group">
											<label class="col-form-label">Email Address</label> <input
												class="form-control" type="text" name="email" required
												placeholder="Enter Email Address">
											<div class="valid-feedback">Email Address looks good!</div>
											<div class="invalid-feedback">Please enter email address.</div>
										</div>

										<div class="form-group">
											<label class="col-form-label">Password</label>
											<div class="form-input position-relative">
												<input class="form-control" type="password" name="staffId"
													placeholder="*********" required>
												<div class="valid-feedback">Password looks good!</div>
												<div class="invalid-feedback">Please enter password.</div>
											</div>
										</div>

										<div class="form-group mb-0">
											<div class="text-end mt-3">
												<button class="btn btn-primary btn-block w-100"
													type="submit">Sign in</button>
											</div>
										</div>
									</form>
								</div>

							</div>
							<!-- End Tab Content -->
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