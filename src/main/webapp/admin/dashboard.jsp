<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="demo_barbershop.admin.Admin"%>
<%
// retrieve logged in admin
Admin admin = (Admin) session.getAttribute("loggedInAdmin");

// redirect to login page if admin not authenticated
if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
	return;
}

// get number of pending appointment for notification
Integer pendingCount = (Integer) request.getAttribute("pendingCount");
if (pendingCount == null)
	pendingCount = 0;

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
									href="<%=request.getContextPath()%>/admin/ListAppointmentView">
											<i class="fa fa-circle-o me-3 font-primary"></i>
											<%=(pendingCount > 0) ? "Total " + pendingCount + " pending bookings" : "No pending appointments"%>
								</a></p></li>

								<li><a class="btn btn-primary"
									href="<%=request.getContextPath()%>/admin/ListAppointmentView">
										Manage All Bookings </a></li>
							</ul>
						</li>
						<li class="maximize"><a class="text-dark" href="#!"
							onclick="javascript:toggleFullScreen()"><i
								data-feather="maximize"></i></a></li>
						<li class="profile-nav onhover-dropdown p-0 me-0">
							<div class="d-flex profile-media">
								<img class="b-r-50"
									src="../assets/images/dashboard/profile_admin.jpg" alt="">
								<div class="flex-grow-1">
									<span><%=admin.getFullName()%></span>
									<p class="mb-0 font-roboto">
										Supervisor <i class="middle fa fa-angle-down"></i>
									</p>
								</div>
							</div>
							<ul class="profile-dropdown onhover-show-div">
								<li><a href="<c:url value='/admin/AdminLogout' />"><i
										data-feather="log-out"></i><span>Logout</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- Page Header Ends-->
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
													href="<c:url value='/admin/ListAppointmentView' />"><span>Manage
															Appointment</span></a></li>
											</ul></li>
										<li class="sidebar-list"><a
											class="sidebar-link sidebar-title" href="javascript:void(0)"><i
												data-feather="scissors"></i><span>Service</span></a>
											<ul class="sidebar-submenu">
												<li><a href="<c:url value='/admin/ListServiceView' />"><span>Manage
															Service</span></a></li>
											</ul></li>
									</ul>
								</li>

								<li class="sidebar-main-title">
									<h6>User Management</h6>
								</li>
								<li class="menu-box">
									<ul>
										<li class="sidebar-list"><a
											class="sidebar-link sidebar-title" href="javascript:void(0)"><i
												data-feather="user-check"></i><span>Staff</span></a>
											<ul class="sidebar-submenu">
												<li><a href="<c:url value='/admin/ListBarberView' />"><span>Manage
															Barber</span></a></li>
												<li><a href="<c:url value='/admin/ListShiftView' />"><span>Manage
															Shift</span></a></li>
											</ul></li>
										<li class="sidebar-list"><a
											class="sidebar-link sidebar-title" href="javascript:void(0)"><i
												data-feather="users"></i><span>Customer</span></a>
											<ul class="sidebar-submenu">
												<li><a href="<c:url value='/admin/ListCustomerView' />"><span>View
															Customer</span></a></li>
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

						<!-- BAR CHART: Barber Appointments -->
						<div class="col-xl-8 col-md-6 box-col-50 xl-50">
							<div class="card company-view">
								<div
									class="card-header card-no-border d-flex justify-content-between p-b-0">
									<h5>Monthly Barber Appointments</h5>
									<div class="right-content">
										<!-- DYNAMIC AVERAGE -->
										<p>Average ${monthlyAverage} appointments / month</p>
									</div>
								</div>
								<div class="card-body">
									<div id="barber-appointments-chart" style="height: 300px;"></div>
								</div>
							</div>
						</div>

						<!-- PIE CHART: Popular Services -->
						<div class="col-xl-4 col-md-6 box-col-50 xl-50">
							<div class="card company-view">
								<div
									class="card-header card-no-border d-flex justify-content-between p-b-0">
									<h5>Popular Services</h5>
									<div class="right-content">
										<p>Based on last month's bookings</p>
									</div>
								</div>
								<div class="card-body">
									<!-- Use this ID -->
									<div id="services-chart" style="height: 300px;"></div>
								</div>
							</div>
						</div>

						<!-- Slider -->
						<div class="col-xl-12">
							<div class="items-slider">
								<div class="col-xl-2 col-lg-4 col-sm-4 des-xsm-50 box-col-33">
									<div class="card investment-sec">
										<div class="animated-bg">
											<i></i><i></i><i></i>
										</div>
										<div class="card-body">
											<div class="icon">
												<i data-feather="clipboard"></i>
											</div>
											<p>Total Haircuts</p>
											<h3>${stats.totalHaircuts}</h3>
										</div>
									</div>
								</div>
								<div class="col-xl-2 col-lg-4 col-sm-4 des-xsm-50 box-col-33">
									<div class="card investment-sec">
										<div class="animated-bg">
											<i></i><i></i><i></i>
										</div>
										<div class="card-body">
											<div class="icon">
												<i data-feather="database"></i>
											</div>
											<p>Active Barbers</p>
											<h3>${stats.activeBarbers}</h3>
										</div>
									</div>
								</div>
								<div class="col-xl-2 col-lg-4 col-sm-4 des-xsm-50 box-col-33">
									<div class="card investment-sec">
										<div class="animated-bg">
											<i></i><i></i><i></i>
										</div>
										<div class="card-body">
											<div class="icon">
												<i data-feather="user"></i>
											</div>
											<p>Monthly Appointments</p>
											<h3>${stats.monthlyAppointments}</h3>
										</div>
									</div>
								</div>
								<div class="col-xl-2 col-lg-4 col-sm-4 des-xsm-50 box-col-33">
									<div class="card investment-sec">
										<div class="animated-bg">
											<i></i><i></i><i></i>
										</div>
										<div class="card-body">
											<div class="icon">
												<i data-feather="dollar-sign"></i>
											</div>
											<p>Total Revenue</p>
											<h3>
												RM
												<fmt:formatNumber value="${stats.totalRevenue}"
													pattern="#,###.00" />
											</h3>
										</div>
									</div>
								</div>
								<div class="col-xl-2 col-lg-4 col-sm-4 des-xsm-50 box-col-33">
									<div class="card investment-sec">
										<div class="animated-bg">
											<i></i><i></i><i></i>
										</div>
										<div class="card-body">
											<div class="icon">
												<i data-feather="file-text"></i>
											</div>
											<p>Popular Service</p>
											<h3>${stats.popularService}</h3>
										</div>
									</div>
								</div>
								<div class="col-xl-2 col-lg-4 col-sm-4 des-xsm-50 box-col-33">
									<div class="card investment-sec">
										<div class="animated-bg">
											<i></i><i></i><i></i>
										</div>
										<div class="card-body">
											<div class="icon">
												<i data-feather="check-circle"></i>
											</div>
											<p>Completed Appointments</p>
											<h3>${stats.completedAppts}</h3>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Sell Overview -->
						<div class="col-xl-4 col-md-12 box-col-4 xl-10">
							<div class="card sellview-sec">
								<div class="card-header card-no-border pb-0">
									<h5>Sell Overview</h5>
									<div class="center-content">
										<p>Yearly selling product overview</p>
									</div>
								</div>
								<div class="card-body">
									<div id="sell-view"></div>
									<div class="code-box-copy">
										<button class="code-box-copy__btn btn-clipboard"
											data-clipboard-target="#sellview" title=""
											data-bs-original-title="Copy" aria-label="Copy">
											<i class="icofont icofont-copy-alt"></i>
										</button>
									</div>
								</div>
							</div>
						</div>

						<!-- Best Selling Product -->
						<div class="col-xl-8 box-col-6 best-selling">
							<div class="card bestselling-sec">
								<div class="card-header p-b-0">
									<h5>Appointment Summary</h5>
									<div class="center-content">
										<p>Real-time booking status overview</p>
									</div>

									<ul class="selling-list">
										<li>
											<div class="icon">
												<i data-feather="clock" class="font-warning"></i>
											</div>
											<div>
												<p>Pending</p>
												<h6>${statusCounts.Pending}</h6>
											</div>
										</li>
										<li>
											<div class="icon">
												<i data-feather="check-circle" class="font-info"></i>
											</div>
											<div>
												<p>Confirmed</p>
												<h6>${statusCounts.Confirmed}</h6>
											</div>
										</li>
										<li>
											<div class="icon">
												<i data-feather="thumbs-up" class="font-success"></i>
											</div>
											<div>
												<p>Completed</p>
												<h6>${statusCounts.Completed}</h6>
											</div>
										</li>
										<li>
											<div class="icon">
												<i data-feather="x-circle" class="font-danger"></i>
											</div>
											<div>
												<p>Cancelled</p>
												<h6>${statusCounts.Cancelled}</h6>
											</div>
										</li>
									</ul>
								</div>

								<div class="card-body pt-0">
									<h6 class="mb-3 mt-2 px-1">Recent Bookings</h6>
									<div class="recent-table table-responsive">
										<table class="table table-bordernone">
											<thead>
												<tr class="text-muted"
													style="font-size: 12px; border-bottom: 1px solid #eee;">
													<th>Customer</th>
													<th>Barber</th>
													<th>Date and Time</th>
													<th>Status</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="appt" items="${recentAppointments}">
													<tr>
														<td>
															<div class="t-title">
																<div class="d-inline-block align-middle">
																	<span class="fw-bold text-dark">${appt.customer}</span>
																</div>
															</div>
														</td>
														<td class="text-muted">${appt.barber}</td>
														<td><span class="digits"><fmt:formatDate
																	value="${appt.date}" pattern="dd MMM" />, </span> <span
															class="digits text-muted"><fmt:formatDate
																	value="${appt.time}" pattern="hh:mm a" /></span></td>
														<td><c:choose>
																<c:when test="${appt.status == 'Pending'}">
																	<span class="badge badge-light-warning">${appt.status}</span>
																</c:when>
																<c:when test="${appt.status == 'Confirmed'}">
																	<span class="badge badge-light-info">${appt.status}</span>
																</c:when>
																<c:when test="${appt.status == 'Completed'}">
																	<span class="badge badge-light-success">${appt.status}</span>
																</c:when>
																<c:otherwise>
																	<span class="badge badge-light-danger">${appt.status}</span>
																</c:otherwise>
															</c:choose></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
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
	<script src="../assets/js/clock/clock.js"></script>
	<script src="../assets/js/extra/admin-dashboard.js"></script>
	<script src="../assets/js/script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
	
	<script>
    window.adminDashboardData = {
        monthlyData: [
            <c:forEach var="val" items="${monthlyData}" varStatus="s">
                ${val}${!s.last ? ',' : ''}
            </c:forEach>
        ],
        servicePie: {
            labels: [<c:forEach var="l" items="${serviceLabels}" varStatus="s">'${l}'${!s.last ? ',' : ''}</c:forEach>],
            series: [<c:forEach var="v" items="${serviceValues}" varStatus="s">${v}${!s.last ? ',' : ''}</c:forEach>]
        },
        sellOverview: {
            labels: [<c:forEach var="l" items="${sellLabels}" varStatus="s">'${l}'${!s.last ? ',' : ''}</c:forEach>],
            qty: [<c:forEach var="v" items="${sellQty}" varStatus="s">${v}${!s.last ? ',' : ''}</c:forEach>],
            revenue: [<c:forEach var="v" items="${sellRevenue}" varStatus="s">${v}${!s.last ? ',' : ''}</c:forEach>]
        }
    };
</script>
</body>
</html>