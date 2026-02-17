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
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/view-account.css">
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
								<li><a href="#"><i data-feather="user"></i><span>Account
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

		<!-- view account start-->
		<div class="container-fluid">
			<div class="row justify-content-center align-items-center vh-110"
				style="margin-top: 120px;">
				<div class="page-body">
					<!-- Container-fluid starts-->
					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-14">
								<div class="card">
									<div class="card-header pb-0">
										<h4 class="card-title mb-0">My Profile</h4>
										<div class="card-options">
											<a class="card-options-collapse" href="javascript:void(0)"
												data-bs-toggle="card-collapse"><i
												class="fe fe-chevron-up"></i></a><a class="card-options-remove"
												href="javascript:void(0)" data-bs-toggle="card-remove"><i
												class="fe fe-x"></i></a>
										</div>
									</div>
									<div class="card-body">
										<div class="row mb-2">
											<div class="profile-title">
												<div class="d-flex align-items-center">

													<div class="position-relative">
														<img class="img-70 rounded-circle" alt=""
															src="../assets/images/dashboard/profile.jpg">

														<!-- Pencil icon beside the image -->
														<a href="edit_account.jsp"><i
															class="icofont icofont-pencil-alt-5 edit-icon"></i></a>
													</div>

													<div class="flex-grow-1 ms-3">
														<h3 class="mb-1 f-20 txt-primary"><%=c.getFullName()%></h3>
														<p class="f-12">MEMBER</p>
													</div>

												</div>
											</div>
										</div>
										<br>

										<div class="mb-3">
											<label class="form-label">Email</label> <input
												class="form-control" value="<%=c.getEmail()%>" disabled>
										</div>
										<div class="mb-3">
											<label class="form-label">Phone Number</label> <input
												class="form-control" value="<%=c.getPhoneNum()%>" disabled>
										</div>
										<div class="mb-3">
											<label class="form-label">Address</label>
											<textarea class="form-control" rows="3"
												placeholder="Enter Address" disabled><%=(c.getAddress() == null) ? "-" : c.getAddress()%></textarea>
										</div>
									</div>
								</div>
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
	<script src="../assets/js/time-picker/highlight.min.js"></script>
	<script src="../assets/js/script.js"></script>

</body>
</html>