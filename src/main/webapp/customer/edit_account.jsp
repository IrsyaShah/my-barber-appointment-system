<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="demo_barbershop.customer.Customer"%>
<%
// retrieve logged in customer
Customer c = (Customer) session.getAttribute("loggedInCustomer");

// redirect to login page if customer not authenticated
if (c == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

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
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/scrollbar.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/timepicker.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/date-picker.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/owlcarousel.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/prism.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/slick.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/slick-theme.css">
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/edit-account.css">
<link rel="stylesheet" type="text/css" href="../assets/css/style.css">
<link id="color" rel="stylesheet" href="../assets/css/color-6.css"
	media="screen">
<!-- Responsive css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/responsive.css">
</head>
<body class="landing-page">
	<!-- Loader starts-->
	<div class="loader-wrapper">
		<div class="loader"></div>
	</div>
	<!-- Loader ends-->
	<!-- Page Body Start-->
	<!-- header start-->
	<div class="page-wrapper compact-wrapper" id="pageWrapper">
		<div class="page-header">
			<div class="header-wrapper row m-0">
				<div
					class="header-logo-wrapper col-auto d-flex align-items-center p-0">

					<a href="../index.jsp" class="me-3"> <img
						src="../assets/images/logo/logo-icon.png"
						alt="Demo Barbershop Logo"
						style="height: 45px; margin-left: 20px;">
					</a>

					<!-- NAVIGATION MENU -->
					<ul class="custom-nav d-flex align-items-center m-0 p-0">
						<li><a href="../index.jsp#home">Home</a></li>
						<li><a href="../index.jsp#services">Services</a></li>
						<li><a href="../index.jsp#barbers">Our Barbers</a></li>
						<li><a href="<c:url value='/customer/AddAppointmentView' />">Book
								Now</a></li>
						<li><a href="../index.jsp#contact">Contact</a></li>
					</ul>

				</div>
				<div class="nav-right col-8 pull-right right-header p-0">
					<ul class="nav-menus">
						<li class="profile-nav onhover-dropdown p-0 me-0">
							<div class="d-flex profile-media">
								<img class="b-r-50" src="../assets/images/dashboard/profile.jpg"
									alt="">
								<div class="flex-grow-1">
									<span><%=c.getFullName()%></span>
									<p class="mb-0 font-roboto">
										Member <i class="middle fa fa-angle-down"></i>
									</p>
								</div>
							</div>
							<ul class="profile-dropdown onhover-show-div">
								<li><a href="view_account.jsp"><i data-feather="user"></i><span>Account
									</span></a></li>
								<li><a href="<c:url value='/customer/AppointmentView' />"><i
										data-feather="book"></i><span>Booking </span></a></li>
								<li><a href="<c:url value='/customer/CustomerLogout' />"><i
										data-feather="log-out"></i><span>Logout</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row justify-content-center align-items-center vh-110"
				style="margin-top: 120px;">
				<div class="page-body">
					<!-- Container-fluid starts-->
					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-4">
								<div class="card">
									<div class="card-header pb-0">
									
										<!-- display message on user actions -->
										<%
										String message = null;

										if (request.getAttribute("current_mismatch") != null)
											message = "current_mismatch";
										else if (request.getAttribute("password_mismatch") != null)
											message = "password_mismatch";
										else if (request.getAttribute("weak_password") != null)
											message = "weak_password";
										else if (request.getAttribute("acc_updated") != null)
											message = "acc_updated";
										else if (request.getAttribute("pass_updated") != null)
											message = "pass_updated";

										if (message != null) {
											switch (message) {
											case "current_mismatch":
										%><div class="alert alert-danger text-center"><%=request.getAttribute("current_mismatch")%></div>
										<%
										break;
										case "password_mismatch":
										%><div class="alert alert-danger text-center"><%=request.getAttribute("password_mismatch")%></div>
										<%
										break;
										case "weak_password":
										%><div class="alert alert-danger text-center"><%=request.getAttribute("weak_password")%></div>
										<%
										break;
										case "acc_updated":
										%>
										<div
											style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
											<div
												class="alert alert-success alert-dismissible fade show position-relative"
												role="alert" style="padding-right: 3rem;">
												<strong><%=request.getAttribute("acc_updated")%></strong>
												<button type="button" class="btn-close"
													data-bs-dismiss="alert" aria-label="Close"
													style="position: absolute;"></button>
											</div>
										</div>
										<%
										break;
										case "pass_updated":
										%>
										<div
											style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
											<div
												class="alert alert-success alert-dismissible fade show position-relative"
												role="alert" style="padding-right: 3rem;">
												<strong><%=request.getAttribute("pass_updated")%></strong>
												<button type="button" class="btn-close"
													data-bs-dismiss="alert" aria-label="Close"
													style="position: absolute;"></button>
											</div>
										</div>
										<%
										break;
										}
										}
										%>
										<h4 class="card-title mb-0">Change Password</h4>
										<div class="card-options">
											<a class="card-options-collapse" href="javascript:void(0)"
												data-bs-toggle="card-collapse"><i
												class="fe fe-chevron-up"></i></a><a class="card-options-remove"
												href="javascript:void(0)" data-bs-toggle="card-remove"><i
												class="fe fe-x"></i></a>
										</div>
									</div>
									<div class="card-body">
										<form class="needs-validation" action="UpdatePasswordView"
											method="post" novalidate>
											<div class="mb-3">
												<label class="col-form-label">Current Password</label>
												<div class="form-input position-relative">
													<input class="form-control" type="password"
														name="current_password" placeholder="*********" required>
													<div class="valid-feedback">Password looks good!</div>
													<div class="invalid-feedback">Please enter password.</div>
												</div>
											</div>
											<div class="mb-3">
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
											<div class="mb-3">
												<label class="col-form-label">Confirm Password</label>
												<div class="form-input position-relative">
													<input class="form-control" type="password"
														name="confirm_password" placeholder="*********" required>
													<div class="valid-feedback">Password looks good!</div>
													<div class="invalid-feedback">Please enter password.</div>
												</div>
											</div>
											<div class="form-footer">
												<button class="btn btn-primary btn-block">Change
													Password</button>
											</div>
										</form>
									</div>
								</div>
							</div>
							<div class="col-lg-8">
								<form class="card needs-validation" method="post"
									action="UpdateCustomerView" novalidate>
									<div class="card-header pb-0">
										<h4 class="card-title mb-0">Edit Profile</h4>
										<div class="card-options">
											<a class="card-options-collapse" href="javascript:void(0)"
												data-bs-toggle="card-collapse"><i
												class="fe fe-chevron-up"></i></a><a class="card-options-remove"
												href="javascript:void(0)" data-bs-toggle="card-remove"><i
												class="fe fe-x"></i></a>
										</div>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<div class="mb-3">
													<label class="form-label">Full Name</label> <input
														class="form-control" type="text"
														placeholder="Enter Full Name" name="full_name"
														value="<%=c.getFullName()%>" required>
													<div class="valid-feedback">Full name looks good!</div>
													<div class="invalid-feedback">Please enter full name.</div>
												</div>
											</div>
											<div class="col-sm-6 col-md-6">
												<div class="mb-3">
													<label class="form-label">Email</label>
													<div class="input-group left-radius">
														<input class="form-control" type="email"
															aria-describedby="inputGroupPrepend"
															value="<%=c.getEmail()%>" disabled>
													</div>
												</div>
											</div>
											<div class="col-sm-6 col-md-6">
												<div class="mb-3">
													<label class="form-label">Phone Number</label> <input
														class="form-control" type="tel"
														placeholder="e.g. 0182733029" pattern="[0-9]{10,11}"
														name="phone_num" value="<%=c.getPhoneNum()%>" required>
													<div class="valid-feedback">Phone number looks good!</div>
													<div class="invalid-feedback">Please enter a valid
														phone number.</div>
												</div>
											</div>
											<div class="col-md-12">
												<div>
													<label class="form-label">Address (optional)</label>
													<textarea class="form-control" rows="3"
														placeholder="Enter Address" name="address"><%=(c.getAddress() == null) ? "" : c.getAddress()%></textarea>
													<div class="valid-feedback">Address looks good!</div>
												</div>
											</div>
										</div>
									</div>
									<div class="card-footer text-end">
										<a href="view_account.jsp" class="btn btn-secondary">Cancel</a>
										<button class="btn btn-primary" type="submit">Save</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap -->
	<script src="../assets/js/jquery-3.6.0.min.js"></script>
	<script src="../assets/js/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="../assets/js/icons/feather-icon/feather.min.js"></script>
	<script src="../assets/js/icons/feather-icon/feather-icon.js"></script>
	<script src="../assets/js/scrollbar/simplebar.js"></script>
	<script src="../assets/js/scrollbar/custom.js"></script>
	<script src="../assets/js/config.js"></script>
	<script src="../assets/js/sidebar-menu.js"></script>
	<script src="../assets/js/prism/prism.min.js"></script>
	<script src="../assets/js/clipboard/clipboard.min.js"></script>
	<script src="../assets/js/custom-card/custom-card.js"></script>
	<script src="../assets/js/typeahead/handlebars.js"></script>
	<script src="../assets/js/typeahead/typeahead.bundle.js"></script>
	<script src="../assets/js/typeahead/typeahead.custom.js"></script>
	<script src="../assets/js/typeahead-search/handlebars.js"></script>
	<script src="../assets/js/typeahead-search/typeahead-custom.js"></script>
	<script src="../assets/js/tooltip-init.js"></script>
	<script src="../assets/js/slick-slider/slick.min.js"></script>
	<script src="../assets/js/slick-slider/slick-theme.js"></script>
	<script src="../assets/js/notify/index.js"></script>
	<script src="../assets/js/notify/bootstrap-notify.min.js"></script>
	<script src="../assets/js/dashboard/default.js"></script>
	<script src="../assets/js/sidebar-menu.js"></script>
	<script src="../assets/js/form-wizard/form-wizard-three.js"></script>
	<script src="../assets/js/form-wizard/jquery.backstretch.min.js"></script>
	<script src="../assets/js/form-validation-custom.js"></script>
	<script src="../assets/js/time-picker/jquery-clockpicker.min.js"></script>
	<script src="../assets/js/time-picker/highlight.min.js"></script>
	<script src="../assets/js/time-picker/clockpicker.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.en.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.custom.js"></script>
	<script src="../assets/js/height-equal.js"></script>
	<script src="../assets/js/tooltip-init.js"></script>
	<script src="../assets/js/owlcarousel/owl.carousel.js"></script>
	<script src="../assets/js/counter/jquery.waypoints.min.js"></script>
	<script src="../assets/js/counter/jquery.counterup.min.js"></script>
	<script src="../assets/js/counter/counter-custom.js"></script>
	<script src="../assets/js/script.js"></script>
	<script src="../assets/js/extra/alert-timeout.js"></script>

</body>
</html>