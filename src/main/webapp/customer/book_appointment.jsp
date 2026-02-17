<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/book-appointment.css">
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
						<li><a href="#">Book Now</a></li>
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
		
		<!-- display message on user actions -->
		<%
		String message = null;

		if (session.getAttribute("check_date") != null) {
			message = "check_date";
			request.setAttribute("check_date", session.getAttribute("check_date"));
			session.removeAttribute("check_date");
		}

		if (message != null) {
			switch (message) {
				case "check_date" :
		%>
		<div
			style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
			<div
				class="alert alert-danger alert-dismissible fade show position-relative"
				role="alert" style="padding-right: 3rem;">
				<strong><%=request.getAttribute("check_date")%></strong>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close" style="position: absolute;"></button>
			</div>
		</div>
		<%
		break;
		}
		}
		%>
		<!-- booking page start-->
		<div class="container-fluid">
			<div class="row justify-content-center align-items-center vh-110"
				style="margin-top: 120px;">
				<div class="col-sm-10 col-md-6 col-lg-8">
					<div class="card">
						<div class="card-body">
							<div class="d-flex align-items-center mb-2">
								<i class="fa fa-user me-2"></i> <span class="fw-bold">Personal
									Details</span>
							</div>
							<hr class="mt-0 mb-3">
							<form class="f1 needs-validation"
								action="<c:url value='/customer/AddAppointmentView' />"
								method="post" novalidate>
								<input type="hidden" name="action" value="load">
								<!-- Personal Info -->
								<div class="mb-2">
									<label for="first-name">Full Name</label> <input
										class="form-control" type="text" placeholder="Enter Full Name"
										value="<%=c.getFullName()%>" required>

									<div class="valid-feedback">Full name looks good!</div>
									<div class="invalid-feedback">Please enter full name.</div>
								</div>
								<div class="mb-2">
									<label class="form-label">Email</label>
									<div class="input-group left-radius">
										<span class="input-group-text" id="inputGroupPrepend">@</span>
										<input class="form-control" type="email"
											placeholder="example@email.com" value="<%=c.getEmail()%>"
											aria-describedby="inputGroupPrepend" required>
										<div class="valid-feedback">Email looks valid!</div>
										<div class="invalid-feedback">Please enter a valid email
											address.</div>
									</div>
								</div>
								<div class="mb-2">
									<label class="form-label">Phone Number</label> <input
										class="form-control" type="tel" placeholder="e.g. 0182733029"
										value="<%=c.getPhoneNum()%>" pattern="[0-9]{10,11}" required>
									<div class="valid-feedback">Phone number looks good!</div>
									<div class="invalid-feedback">Please enter a valid phone
										number.</div>
								</div>
								<br>

								<!-- Appointment -->
								<div class="d-flex align-items-center mb-2">
									<i class="fa fa-calendar me-2"></i> <span class="fw-bold">Appointment</span>
								</div>
								<hr class="mt-0 mb-3">
								<div class="mb-2">
									<label class="form-label">Barber</label> <select
										name="barberId" class="form-select"
										onchange="this.form.action.value='load'; this.form.submit();"
										required>
										<option selected disabled value="">Choose barber...</option>
										<c:forEach var="barber" items="${barbers}">
											<option value="${barber.barberId}"
												<c:if test="${barber.barberId == selectedBarberId}">selected</c:if>>${barber.fullName}
											</option>
										</c:forEach>
									</select>
									<div class="valid-feedback">Barber selected!</div>
									<div class="invalid-feedback">Please select barber.</div>
								</div>
								<br>


								<div class="mb-2"
									<c:if test="${empty services}">style="display:none;"</c:if>>
									<label class="form-label">Service</label>
									<div class="card">
										<div class="card-body animate-chk" id="serviceGroup">
											<div class="row">
												<div class="col">
													<c:forEach var="s" items="${services}" varStatus="loop">
														<div class="form-check mb-2 service-item">
															<input class="form-check-input" type="checkbox"
																name="serviceIds" value="${s.serviceId}"
																id="service_${loop.index}"> <label
																class="form-check-label" for="service_${s.serviceId}">
																${s.serviceName} - RM ${String.format("%.2f", s.price)}<c:if
																	test="${not empty s.skillLevel}">
                            (<small>${s.skillLevel}</small>)
                        </c:if>
															</label>
														</div>
													</c:forEach>

													<div class="invalid-feedback">Please select at least
														one service.</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="mb-2">
									<label class="input-group">Appointment Date</label>
									<div class="date-input">
										<input class="form-control" id="minMaxExample" type="text"
											name="appointment_date" placeholder="dd/mm/yyyy" required
											value="${appointment}">
										<div class="valid-feedback">Appointment Date selected!</div>
										<div class="invalid-feedback">Please select appointment
											date.</div>
									</div>
								</div>

								<div class="mb-2">
									<label class="form-label">Appointment Start</label>
									<div class="input-group clockpicker">
										<select class="form-select" id="startTime"
											name="appointment_start" onchange="updateEndTime()" required>

											<option value="">Choose time...</option>

											<c:forEach var="entry" items="${dayTimeSlots}">

												<!-- Day header -->
												<optgroup label="${entry.key}">

													<c:choose>
														<c:when test="${empty entry.value}">
															<option disabled>Not Available</option>
														</c:when>

														<c:otherwise>
															<c:forEach var="t" items="${entry.value}">
																<option value="${t[0]}">${t[1]}</option>
															</c:forEach>
														</c:otherwise>
													</c:choose>

												</optgroup>

											</c:forEach>
										</select>
										<div class="valid-feedback">Appointment Start Time looks
											valid!</div>
										<div class="invalid-feedback">Please enter a valid
											appointment start time.</div>
									</div>
								</div>

								<div class="mb-2">
									<label class="form-label">Appointment Finish</label> <input
										class="form-control" id="endTime" name="appointment_finish"
										readonly>
								</div>

								<div class="mb-2">
									<label class="form-label">Remarks</label>
									<textarea class="form-control" rows="3" name="remarks"
										placeholder="Enter Remarks" required></textarea>
									<div class="form-text text-muted">
										Please type <strong>No</strong> if you have no special requests.
									</div>
									<div class="valid-feedback">Remarks looks good!</div>
									<div class="invalid-feedback">Please enter remarks.</div>
								</div>
								<br>
								<div class="f1-buttons">
									<a href="../index.jsp" class="btn btn-secondary ms-2 px-4">Cancel</a>
									<button type="submit" class="btn btn-primary"
										onclick="this.form.action.value='book';">Confirm</button>
								</div>
							</form>
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
	<script src="../assets/js/form-wizard/form-wizard-three.js"></script>
	<script src="../assets/js/form-wizard/jquery.backstretch.min.js"></script>
	<script src="../assets/js/form-validation-custom.js"></script>
	<script src="../assets/js/time-picker/jquery-clockpicker.min.js"></script>
	<script src="../assets/js/time-picker/highlight.min.js"></script>
	<script src="../assets/js/time-picker/clockpicker.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.en.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.custom.js"></script>
	<script src="../assets/js/extra/book-appointment.js"></script>
	<script src="../assets/js/extra/alert-timeout.js"></script>
	<script src="../assets/js/script.js"></script>
	
</body>
</html>