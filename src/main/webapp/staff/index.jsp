<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="demo_barbershop.staff.Staff"%>
<%
// retrieve logged in staff
Staff s = (Staff) session.getAttribute("loggedInStaff");

// redirect to login page if staff not authenticated 
if (s == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}

// get number of pending appointment for notification
Integer pendingCount = (Integer) request.getAttribute("pendingCount");
if (pendingCount == null)
	pendingCount = 0;

// dashboard handling
// get today earnings
Double todayEarnings = (Double) request.getAttribute("todayEarnings");
if (todayEarnings == null)
	todayEarnings = 0.0;

// get current month earnings
Double monthEarnings = (Double) request.getAttribute("monthEarnings");
if (monthEarnings == null)
	monthEarnings = 0.0;

// get current year earnings
Double yearEarnings = (Double) request.getAttribute("yearEarnings");
if (yearEarnings == null)
	yearEarnings = 0.0;

// retrieve earning percentage 
Object pctObj = request.getAttribute("earningPercentage");
int earningPercentage = (pctObj != null) ? (Integer) pctObj : 0;

// retrieve total earnings
Object allTimeObj = request.getAttribute("totalAllEarnings");
double totalAllEarnings = (allTimeObj != null) ? (Double) allTimeObj : 0.0;

// get current malaysia timezone
ZonedDateTime serverNow = ZonedDateTime.now(ZoneId.of("Asia/Kuala_Lumpur"));
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy, hh:mm:ss a", Locale.ENGLISH);
String initialTime = serverNow.format(formatter).toUpperCase();
long serverMillis = serverNow.toInstant().toEpochMilli();
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
	href="../assets/css/vendors/slick.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/slick-theme.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/date-picker.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/owlcarousel.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/prism.css">
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/staff-index.css">
<link rel="stylesheet" type="text/css" href="../assets/css/style.css">
<link id="color" rel="stylesheet" href="../assets/css/color-6.css"
	media="screen">
<!-- Responsive css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/responsive.css">
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
	<div class="page-wrapper compact-wrapper" id="pageWrapper">
		<!-- Page Header Start-->
		<div class="page-header">
			<div class="header-wrapper row m-0">
				<div class="header-logo-wrapper col-auto p-0">
					<div class="logo-wrapper">
						<a href="#"><img class="img-fluid"
							src="../assets/images/logo/login.png" alt=""></a>
					</div>
					<div class="toggle-sidebar">
						<i class="status_toggle middle sidebar-toggle"
							data-feather="align-center"></i>
					</div>
				</div>
				<div class="left-header col horizontal-wrapper ps-0">
					<div class="d-flex align-items-center">
						<i class="icofont icofont-location-pin me-2"></i>

						<div id="datetime-display" class="fw-bold text-dark"
							data-server-time="<%=serverMillis%>">

							<span class="text-muted">Penang, Malaysia -</span> <span
								id="ticking-clock"><%=initialTime%></span>
						</div>
					</div>
				</div>
				<div class="nav-right col-8 pull-right right-header p-0">
					<ul class="nav-menus">
						<li class="onhover-dropdown">
							<div class="notification-box">
								<i class="fa fa-bell-o"></i>
								<%
								if (pendingCount > 0) {
								%>
								<span class="badge rounded-pill badge-primary"><%=pendingCount%></span>
								<%
								}
								%>
							</div>

							<ul class="notification-dropdown onhover-show-div">
								<li><i data-feather="bell"></i>
									<h6 class="f-18 mb-0">Notifications</h6></li>

								<li><p><a
									href="<%=request.getContextPath()%>/staff/CustomerAppointmentView">
										
											<i class="fa fa-circle-o me-3 font-primary"></i>
											<%=(pendingCount > 0) ? "You have " + pendingCount + " new bookings" : "No new appointments"%>
								</a></p></li>

								<li><a class="btn btn-primary"
									href="<%=request.getContextPath()%>/staff/CustomerAppointmentView">
										View All Appointments </a></li>
							</ul>
						</li>
						<li class="maximize"><a class="text-dark" href="#!"
							onclick="javascript:toggleFullScreen()"><i
								data-feather="maximize"></i></a></li>
						<li class="profile-nav onhover-dropdown p-0 me-0">
							<div class="d-flex profile-media">
								<img class="b-r-50"
									src="../assets/images/dashboard/profile_staff.jpg" alt="">
								<div class="flex-grow-1">
									<span><%=s.getFullName()%></span>
									<p class="mb-0 font-roboto">
										Staff <i class="middle fa fa-angle-down"></i>
									</p>
								</div>
							</div>
							<ul class="profile-dropdown onhover-show-div">
								<li><a href="view_account.jsp"><i data-feather="user"></i><span>Account
									</span></a></li>
								<li><a href="<c:url value='/staff/StaffLogout' />"><i
										data-feather="log-out"></i><span>Logout</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- Page Header Ends -->
		<!-- Page Body Start-->
		<div class="page-body-wrapper horizontal-menu">
			<!-- Page Sidebar Start-->
			<div class="sidebar-wrapper">
				<div>
					<div class="logo-wrapper">
						<a href="#"><img class="img-fluid for-light"
							src="../assets/images/logo/logo.png" alt=""></a>
						<div class="back-btn">
							<i class="fa fa-angle-left"></i>
						</div>
						<div class="toggle-sidebar">
							<i class="fa fa-cog status_toggle middle sidebar-toggle"> </i>
						</div>
					</div>
					<div class="logo-icon-wrapper">
						<a href="#"><img class="img-fluid"
							src="../assets/images/logo/logo-icon1.png" alt=""></a>
					</div>
					<nav class="sidebar-main">
						<div class="left-arrow" id="left-arrow">
							<i data-feather="arrow-left"></i>
						</div>
						<div id="sidebar-menu">
							<ul class="sidebar-links" id="simple-bar">
								<li class="sidebar-main-title">
									<h6>General</h6>
								</li>
								<li class="menu-box">
									<ul>
										<li class="sidebar-list"><a class="sidebar-link" href="#"><i
												data-feather="home"></i><span>Home</span></a></li>
										<li class="sidebar-list"><a
											class="sidebar-link sidebar-title" href="javascript:void(0)"><i
												data-feather="calendar"></i><span>Appointment</span></a>
											<ul class="sidebar-submenu">
												<li><a
													href="<c:url value='/staff/CustomerAppointmentView' />"><span>View
															Appointment</span></a></li>
											</ul></li>
										<li class="sidebar-list"><a
											class="sidebar-link sidebar-title" href="javascript:void(0)"><i
												data-feather="clock"></i><span>Schedule</span></a>
											<ul class="sidebar-submenu">
												<li><a href="<c:url value='/staff/ScheduleView' />"><span>View
															Schedule</span></a></li>
											</ul></li>
									</ul>
								</li>
							</ul>
						</div>
						<div class="right-arrow" id="right-arrow">
							<i data-feather="arrow-right"></i>
						</div>
					</nav>
				</div>
			</div>
			<!-- Page Sidebar Ends-->
			<div class="page-body">

				<div class="container-fluid default-dash">
					<div class="row">

						<!-- Upcoming Appointments -->
						<div class="col-sm-6 col-lg-4">
							<div class="card o-hidden shadow-sm border-0">
								<div class="card-body">
									<div class="d-flex justify-content-between align-items-center">
										<div>
											<h6 class="text-muted">Upcoming Appointments</h6>
											<h4 class="mb-0 fw-bold"><%=request.getAttribute("upcomingCount")%></h4>
										</div>
										<i class="bi bi-calendar-check-fill text-success fs-1"></i>
									</div>
								</div>
							</div>
						</div>

						<!-- Most Requested Service -->
						<div class="col-sm-6 col-lg-4">
							<div class="card o-hidden shadow-sm border-0">
								<div class="card-body">
									<div class="d-flex justify-content-between align-items-center">
										<div>
											<h6 class="text-muted">Most Requested Service</h6>
											<h4 class="mb-0 fw-bold"><%=request.getAttribute("mostRequested")%></h4>
										</div>
										<i class="bi bi-scissors text-danger fs-1"></i>
									</div>
								</div>
							</div>
						</div>

						<!-- Total Bookings -->
						<div class="col-sm-6 col-lg-4">
							<div class="card o-hidden shadow-sm border-0">
								<div class="card-body">
									<div class="d-flex justify-content-between align-items-center">
										<div>
											<h6 class="text-muted">Total Bookings</h6>
											<h4 class="mb-0 fw-bold"><%=request.getAttribute("totalBookings")%></h4>
										</div>
										<i class="bi bi-clipboard-data-fill text-warning fs-1"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="container-fluid general-widget">
							<div class="row">
								<!-- Calendar -->
								<div class="col-lg-6 col-md-12 box-col-5">
									<div class="card">
										<div class="card-header pb-0">
											<h5>Appointment Calendar</h5>
										</div>
										<div class="card-body">
											<!-- Removed cal-date-widget class -->
											<div class="custom-calendar-container">
												<!-- Removed float-sm-end, added an ID for power -->
												<div id="main-appt-calendar" class="datepicker-here"></div>
											</div>

											<!-- Legend Section -->
											<div class="calendar-legend">
												<div class="legend-item">
													<span class="legend-dot dot-confirmed"></span> <span>Confirmed</span>
												</div>
												<div class="legend-item">
													<span class="legend-dot dot-pending"></span> <span>Pending</span>
												</div>
												<div class="legend-item">
													<span class="legend-dot dot-completed"></span> <span>Completed</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- Total Earnings -->
								<div class="col-lg-6 col-md-12 box-col-5">
									<div class="card o-hidden">
										<div class="card-header pb-0">
											<h5>Total Earning</h5>
										</div>
										<div class="bar-chart-widget">
											<div class="top-content bg-primary"></div>
											<div class="bottom-content card-body">
												<div class="row">
													<div class="col-12">
														<div id="chart-widget5"></div>
													</div>
												</div>
												<div class="row text-center">
													<div class="col-4 b-r-light">
														<div>
															<span class="text-muted block-bottom">Year</span>
															<h4 class="num m-0">
																RM
																<%=String.format("%.2f", yearEarnings)%></h4>
														</div>
													</div>
													<div class="col-4 b-r-light">
														<div>
															<span class="text-muted block-bottom">Month</span>
															<h4 class="num m-0">
																RM
																<%=String.format("%.2f", monthEarnings)%></h4>
														</div>
													</div>
													<div class="col-4">
														<div>
															<span class="text-muted block-bottom">Today</span>
															<h4 class="num m-0">
																RM
																<%=String.format("%.2f", todayEarnings)%></h4>
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
				</div>
			</div>
			<!-- footer start-->
			<footer class="footer">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6 p-0 footer-left">
							<p class="mb-0">
								Copyright &copy;
								<%= LocalDate.now().getYear() %>
								Demo Barbershop. All rights reserved.
							</p>
						</div>
					</div>
				</div>
			</footer>
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
	<script src="../assets/js/script.js"></script>
	<script src="../assets/js/chart/apex-chart/moment.min.js"></script>
	<script src="../assets/js/chart/apex-chart/apex-chart.js"></script>
	<script src="../assets/js/chart/apex-chart/stock-prices.js"></script>
	<script src="../assets/js/chart-widget.js"></script>
	<script src="../assets/js/counter/jquery.waypoints.min.js"></script>
	<script src="../assets/js/counter/jquery.counterup.min.js"></script>
	<script src="../assets/js/counter/counter-custom.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.en.js"></script>
	<script src="../assets/js/datepicker/date-picker/datepicker.custom.js"></script>
	<script src="../assets/js/owlcarousel/owl.carousel.js"></script>
	<script src="../assets/js/general-widget.js"></script>
	<script src="../assets/js/height-equal.js"></script>
	<script src="../assets/js/tooltip-init.js"></script>
	<script src="../assets/js/clock/clock.js"></script>
	<script src="../assets/js/dashboard/staff.js"></script>

<script>
    window.dashboardData = {
        apptDates: {
            pending: [
                <c:forEach var="d" items="${apptDates.Pending}" varStatus="s">
                    "${d}"${!s.last ? ',' : ''}
                </c:forEach>
            ],
            confirmed: [
                <c:forEach var="d" items="${apptDates.Confirmed}" varStatus="s">
                    "${d}"${!s.last ? ',' : ''}
                </c:forEach>
            ],
            completed: [
                <c:forEach var="d" items="${apptDates.Completed}" varStatus="s">
                    "${d}"${!s.last ? ',' : ''}
                </c:forEach>
            ]
        },
        stats: {
            percentage: <%= earningPercentage %>,
            grandTotal: "RM <%= String.format("%.2f", totalAllEarnings) %>"
        },
        urls: {
            appointmentView: "<c:url value='/staff/CustomerAppointmentView' />"
        }
    };
</script>
</body>
</html>