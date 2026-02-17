<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="demo_barbershop.admin.barber.*"%>
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

// retrieve barber list
@SuppressWarnings("unchecked")
ArrayList<Barber> barberList = (ArrayList<Barber>) request.getAttribute("barbers");

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
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/datatables.css">
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
						<a href="<c:url value='/admin/AdminDashboardView' />"><img
							class="img-fluid" src="../assets/images/logo/login.png" alt=""></a>
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
		<!-- Page Header Ends                              -->
		<!-- Page Body Start-->
		<div class="page-body-wrapper horizontal-menu">
			<!-- Page Sidebar Start-->
			<div class="sidebar-wrapper">
				<div>
					<div class="logo-wrapper">
						<a href="<c:url value='/admin/AdminDashboardView' />"><img
							class="img-fluid for-light" src="../assets/images/logo/logo.png"
							alt=""></a>
						<div class="back-btn">
							<i class="fa fa-angle-left"></i>
						</div>
						<div class="toggle-sidebar">
							<i class="fa fa-cog status_toggle middle sidebar-toggle"> </i>
						</div>
					</div>
					<div class="logo-icon-wrapper">
						<a href="<c:url value='/admin/AdminDashboardView' />"><img
							class="img-fluid" src="../assets/images/logo/logo-icon1.png"
							alt=""></a>
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
										<li class="sidebar-list"><a class="sidebar-link"
											href="dashboard.html"><i data-feather="home"></i><span>Home</span></a></li>
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
												<li><a href="#"><span>Manage Barber</span></a></li>
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
				<div class="container-fluid">
					<div class="page-title">
						<div class="row">
							<div class="col-sm-6">
								<h5>Barber Management</h5>
							</div>
							<div class="col-sm-6">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a
										href="<c:url value='/admin/AdminDashboardView' />"> <i
											data-feather="home"></i></a></li>
									<li class="breadcrumb-item">Staff</li>
									<li class="breadcrumb-item active">Manage Barber</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
				
				<!-- display message on user actions -->
				<%
				String message = null;

				if (session.getAttribute("acc_created") != null) {
					message = "acc_created";
					request.setAttribute("acc_created", session.getAttribute("acc_created"));
					session.removeAttribute("acc_created");
				} else if (session.getAttribute("barber_updated") != null) {
					message = "barber_updated";
					request.setAttribute("barber_updated", session.getAttribute("barber_updated"));
					session.removeAttribute("barber_updated");
				}

				if (message != null) {
					switch (message) {
						case "acc_created" :
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
				case "barber_updated" :
				%>
				<div
					style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
					<div
						class="alert alert-success alert-dismissible fade show position-relative"
						role="alert" style="padding-right: 3rem;">
						<strong><%=request.getAttribute("barber_updated")%></strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close" style="position: absolute;"></button>
					</div>
				</div>
				<%
				break;
				}
				}
				%>
				<!-- Container-fluid starts-->
				<div class="container-fluid">
					<div class="row">
						<!-- Zero Configuration  Starts-->
						<div class="col-sm-12">
							<div class="card">
								<div class="card-body">
									<a href="<c:url value='/admin/BarberView' />"
										class="btn btn-primary mb-3">+ New Barber</a>
									<div class="table-responsive">
										<table class="display" id="basic-1">
											<thead>
												<tr>
													<th>Barber ID</th>
													<th>Full Name</th>
													<th>Email</th>
													<th>Phone No</th>
													<th>Address</th>
													<th>Service</th>
													<th>Status</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<%
													if (barberList != null && !barberList.isEmpty()) {
														for (Barber b : barberList) {
													%>
													<td><span class="copy-barber-id text-primary"
														style="cursor: pointer; text-decoration: underline;"><%=b.getBarberId()%></span></td>
													<td><%=b.getFullName()%></td>
													<td><span class="copy-email text-primary"
														style="cursor: pointer; text-decoration: underline;"><%=b.getEmail()%></span></td>
													<td><%=b.getPhoneNum()%></td>
													<td><%=b.getAddress()%></td>
													<td><a href="#" data-bs-toggle="modal"
														data-bs-target="#skillModal_<%=b.getBarberId()%>"><i
															class="fa fa-list-ul" style="color: slateblue;"></i></a>
														<div class="modal fade"
															id="skillModal_<%=b.getBarberId()%>">
															<div class="modal-dialog modal-dialog-centered">
																<div class="modal-content">
																	<div class="modal-header">
																		<h5 class="modal-title">Service and Skill</h5>
																		<button class="btn-close" data-bs-dismiss="modal"></button>
																	</div>
																	<div class="modal-body">
																		<ul>
																			<%
																			if (b.getServices() != null && !b.getServices().isEmpty()) {
																				for (BarberService bs : b.getServices()) {
																			%>
																			<li><%=bs.getServiceName()%> -<%
																			String skill = bs.getSkillLevel();
																			String badgeClass = "badge-light-secondary";

																			if ("Professional".equalsIgnoreCase(skill)) {
																				badgeClass = "badge-light-success";
																			} else if ("Intermediate".equalsIgnoreCase(skill)) {
																				badgeClass = "badge-light-warning";
																			} else if ("Beginner".equalsIgnoreCase(skill)) {
																				badgeClass = "badge-light-danger";
																			}
																			%> <span class="badge rounded-pill <%=badgeClass%>">
																					<%=skill%>
																			</span></li>
																			<%
																			}
																			}
																			%>
																		</ul>
																	</div>
																</div>
															</div>
														</div></td>
													<td>
														<%
														String status = b.getStatus();
														String badgeClass = "badge-light-primary";

														if ("active".equalsIgnoreCase(status)) {
															badgeClass = "badge-light-success";
															status = "Active";
														} else if ("resign".equalsIgnoreCase(status)) {
															badgeClass = "badge-light-danger";
															status = "Resign";
														}
														%> <span class="badge rounded-pill <%=badgeClass%>"><%=status%></span>
													</td>
													<td>
														<ul class="action">
															<li class="edit"><a
																href="<%=request.getContextPath()%>/admin/GetBarberView?barber_id=<%=b.getBarberId()%>"><i
																	class="icon-pencil-alt"></i></a></li>
														</ul>
													</td>
												</tr>
												<%
												}
												} else {
												%>
												<tr>
													<td colspan="8" class="text-center">No barber found</td>
												</tr>
												<%
												}
												%>
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
	<script src="../assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
	<script src="../assets/js/datatable/datatables/datatable.custom.js"></script>
	<script src="../assets/js/clock/clock.js"></script>
	<script src="../assets/js/extra/copy-barber.js"></script>
	<script src="../assets/js/extra/copy-email.js"></script>
	<script src="../assets/js/extra/ordertable.js"></script>
	<script src="../assets/js/script.js"></script>
	<script src="../assets/js/notify/bootstrap-notify.min.js"></script>
	<script src="../assets/js/icons/icons-notify.js"></script>
	<script src="../assets/js/icons/icon-clipart.js"></script>
	<script src="../assets/js/extra/alert-timeout.js"></script>
	
</body>
</html>