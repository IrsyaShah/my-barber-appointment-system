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
	<!-- tap on top starts-->
	<div class="tap-top">
		<i data-feather="chevrons-up"></i>
	</div>
	<!-- tap on tap ends-->
	<!-- Loader starts-->
	<div class="loader-wrapper">
		<div class="loader"></div>
	</div>
	<!-- Loader ends-->
	<!-- page-wrapper Start-->
	<div class="page-wrapper">
		<div class="container-fluid p-0">
			<div class="row">
				<div class="col-12">
					<div class="login-card">
						<div>
							<div>
								<a class="logo" href="login.jsp"><img
									class="img-fluid for-light" src="assets/images/logo/login.png"
									alt="loginpage"></a>
							</div>
							
							<!-- display message on user actions -->
							<div class="login-main">
								<%
								String message = null;

								if (request.getAttribute("sent_code") != null)
									message = "sent_code";
								else if (request.getAttribute("resent_code") != null)
									message = "resent_code";
								else if (request.getAttribute("send_fail") != null)
									message = "send_fail";
								else if (request.getAttribute("wrong_code") != null)
									message = "wrong_code";
								else if (request.getAttribute("expired_code") != null)
									message = "expired_code";
								else if (request.getAttribute("weak_password") != null)
									message = "weak_password";
								else if (request.getAttribute("password_mismatch") != null)
									message = "password_mismatch";
								else if (request.getAttribute("not_found") != null)
									message = "not_found";
								else if (request.getAttribute("session_expired") != null)
									message = "session_expired";

								if (message != null) {
									switch (message) {
									case "sent_code":
								%><div class="alert alert-success text-center"><%=request.getAttribute("sent_code")%></div>
								<%
								break;
								case "resent_code":
								%><div class="alert alert-success text-center"><%=request.getAttribute("resent_code")%></div>
								<%
								break;
								case "send_fail":
								%><div class="alert alert-danger text-center"><%=request.getAttribute("send_fail")%></div>
								<%
								break;
								case "wrong_code":
								%><div class="alert alert-danger text-center"><%=request.getAttribute("wrong_code")%></div>
								<%
								break;
								case "expired_code":
								%><div class="alert alert-danger text-center"><%=request.getAttribute("expired_code")%></div>
								<%
								break;
								case "weak_password":
								%><div class="alert alert-danger text-center"><%=request.getAttribute("weak_password")%></div>
								<%
								break;
								case "password_mismatch":
								%><div class="alert alert-danger text-center"><%=request.getAttribute("password_mismatch")%></div>
								<%
								break;
								case "not_found":
								%><div class="alert alert-danger text-center"><%=request.getAttribute("not_found")%></div>
								<%
								break;
								case "session_expired":
								%><div class="alert alert-danger text-center"><%=request.getAttribute("session_expired")%></div>
								<%
								break;
								}
								}
								%>

								<form class="theme-form needs-validation"
									action="ForgotPasswordView" method="post" novalidate>
									<h4>Reset Your Password</h4>
									<div class="form-group">
										<label class="col-form-label">Enter Email Address</label>
										<div class="row">
											<div class="input-group left-radius">
												<input class="form-control" type="email" name="email"
													value="<%=request.getParameter("email") != null ? request.getParameter("email") : ""%>"
													placeholder="Enter Email Address" required>
												<div class="valid-feedback">Email address looks good!</div>
												<div class="invalid-feedback">Please enter email
													address.</div>
											</div>
											<div class="col-12">
												<div class="text-end">
													<button class="btn btn-primary btn-block m-t-10"
														type="submit">Send</button>
												</div>
											</div>
										</div>
									</div>
								</form>
								<div class="mt-4 mb-4">
									<span class="reset-password-link">If don't receive Code?
										<a class="btn-link text-danger" href="ResendCodeView">Resend</a>
									</span>
								</div>
								<form class="theme-form needs-validation"
									action="ResetPasswordView" method="post" novalidate>
									<div class="form-group">
										<label class="col-form-label pt-0">Enter Code</label>
										<div class="row">
											<div class="col">
												<input class="form-control text-center opt-text code-input"
													type="text" maxlength="6" placeholder="00000" name="code"
													required>
												<div class="valid-feedback">Code looks good!</div>
												<div class="invalid-feedback">Please enter code.</div>
											</div>
										</div>
									</div>
									<h6 class="mt-4">Create Your Password</h6>
									<div class="form-group">
										<label class="col-form-label">New Password<span
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
									<div class="form-group mb-0">
										<button class="btn btn-primary btn-block w-100 mt-3"
											type="submit">Done</button>
									</div>
									<p class="mt-4 mb-0 text-center">
										Already have an password?<a class="ms-2" href="login.jsp">Sign
											in</a>
									</p>
								</form>
							</div>
						</div>
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
</body>
</html>