<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="pixelstrap">
<link rel="icon" href="../assets/images/favicon/favicon.png"
	type="image/x-icon">
<link rel="shortcut icon" href="../assets/images/favicon/favicon.png"
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
	href="../assets/css/vendors/font-awesome.css">
<!-- ico-font-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/icofont.css">
<!-- Themify icon-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/themify.css">
<!-- Flag icon-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/flag-icon.css">
<!-- Feather icon-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/feather-icon.css">
<!-- Plugins css start-->
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/admin-index.css">
<link rel="stylesheet" type="text/css" href="../assets/css/style.css">
<link id="color" rel="stylesheet" href="../assets/css/color-6.css"
	media="screen">
<!-- Responsive css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/responsive.css">
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
					<div class="login-main">
					
						<!-- display message on user actions -->
						<%
						String error = request.getParameter("error");
						if ("invalid".equals(error)) {
						%>
						<div class="alert alert-danger text-center">Invalid username
							or password!</div>
						<%
						}
						%>
						<form class="theme-form needs-validation" action="LoginAdminView"
							method="post" novalidate>
							<h4 class="text-center">Administration</h4>
							<p class="text-center">Enter username and password</p>
							<div class="form-group">
								<label class="col-form-label">Username</label> <input
									class="form-control" type="text" name="username"
									placeholder="Enter Username" required>
								<div class="valid-feedback">Username looks good!</div>
								<div class="invalid-feedback">Please enter username.</div>
							</div>
							<div class="form-group">
								<label class="col-form-label">Password</label>
								<div class="form-input position-relative">
									<input class="form-control" type="password" name="password"
										placeholder="*********" required>
									<div class="valid-feedback">Password looks good!</div>
									<div class="invalid-feedback">Please enter password.</div>
								</div>
							</div>
							<div class="form-group mb-0">
								<div class="text-end mt-3">
									<button class="btn btn-primary btn-block w-100" type="submit">Log
										in</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Bootstrap -->
		<script src="../assets/js/jquery-3.6.0.min.js"></script>
		<script src="../assets/js/bootstrap/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/icons/feather-icon/feather.min.js"></script>
		<script src="../assets/js/icons/feather-icon/feather-icon.js"></script>
		<script src="../assets/js/config.js"></script>
		<script src="../assets/js/script.js"></script>
		<script src="../assets/js/form-validation-custom.js"></script>
	</div>
</body>
</html>