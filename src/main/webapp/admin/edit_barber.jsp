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
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/edit-barber.css">
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
		<!-- Page Header Ends -->
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
											href="<c:url value='/admin/AdminDashboardView' />"><i
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
									<li class="breadcrumb-item active">Edit Barber</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
                
                <!-- retrieve service for the selected barber  -->
				<%
				Barber b = (Barber) request.getAttribute("getbarber");
				if (b == null) {
					String idStr = request.getParameter("barber_id");
					if (idStr != null) {
						int barberId = Integer.parseInt(idStr);
						BarberDAO dao = new BarberDAO();
						b = dao.getBarberById(barberId);
					} else {
						b = new Barber();
					}
				}
				%>

				<!-- display message on user actions -->
				<%
				String message = null;

				if (request.getAttribute("email_exists") != null)
					message = "email_exists";

				if (message != null) {
					switch (message) {
						case "email_exists" :
				%>
				<div
					style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
					<div
						class="alert alert-danger alert-dismissible fade show position-relative"
						role="alert" style="padding-right: 3rem;">
						<strong><%=request.getAttribute("email_exists")%></strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close" style="position: absolute;"></button>
					</div>
				</div>
				<%
				break;
				}
				}
				%>

				<div id="serviceAlert"
					style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;"
					class="d-none">
					<div
						class="alert alert-danger alert-dismissible fade show position-relative"
						role="alert" style="padding-right: 3rem;">
						<strong>Please assign at least one service.</strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</div>

				<!-- Container-fluid starts-->
				<div class="container-fluid">
					<div class="row">
						<div class="col-sm-12">
							<div class="card shadow-sm rounded-4">
								<div class="card-body">
									<form class="needs-validation"
										action="<c:url value='/admin/UpdateBarberView' />"
										onsubmit="return validateServiceSelection()" method="post" 
										novalidate>
										<!-- Top Row -->
										<div class="row g-3">
											<!-- Barber ID -->
											<div class="col-md-6">
												<label class="form-label">Barber ID</label> <input
													class="form-control" type="text" name="barber_id"
													value="<%=b.getBarberId()%>" readonly>
											</div>

											<!-- Full Name -->
											<div class="col-md-6">
												<label class="form-label">Full Name</label> <input
													class="form-control" type="text" name="full_name"
													placeholder="Enter Full Name" value="<%=b.getFullName()%>"
													required>
												<div class="valid-feedback">Full name looks good!</div>
												<div class="invalid-feedback">Please enter full name.</div>
											</div>

											<!-- Email -->
											<div class="col-md-6">
												<label class="form-label">Email</label>
												<div class="input-group left-radius">
													<span class="input-group-text" id="inputGroupPrepend">@</span>
													<input class="form-control" type="email" name="email"
														placeholder="example@email.com" value="<%=b.getEmail()%>"
														aria-describedby="inputGroupPrepend" required>
													<div class="valid-feedback">Email looks valid!</div>
													<div class="invalid-feedback">Please enter a valid
														email address.</div>
												</div>
											</div>

											<!-- Phone Number -->
											<div class="col-md-6">
												<label class="form-label">Phone Number</label> <input
													class="form-control" type="tel" name="phone_num"
													placeholder="e.g. 0182733029" value="<%=b.getPhoneNum()%>"
													pattern="[0-9]{10,11}" required>
												<div class="valid-feedback">Phone number looks good!</div>
												<div class="invalid-feedback">Please enter a valid
													phone number.</div>
											</div>

											<!-- Service -->
											<div class="col-sm-12 mt-3">
												<label class="form-label">Service</label>

												<div class="d-flex align-items-center gap-3">
													<button type="button" class="btn btn-primary"
														data-bs-toggle="modal"
														data-bs-target="#assignServiceModal">Assign
														Service</button>
												</div>
											</div>

											<!-- Assign Service Modal -->
											<div class="modal fade" id="assignServiceModal" tabindex="-1">
												<div
													class="modal-dialog modal-lg modal-dialog-scrollable modal-center-screen">
													<div class="modal-content">

														<div class="modal-header">
															<h5 class="modal-title">Assign Service</h5>
															<button type="button" class="btn-close"
																data-bs-dismiss="modal"></button>
														</div>

														<div class="modal-body p-0">
															<table class="table table-bordered mb-0">
																<thead class="table-light sticky-top">
																	<tr>
																		<th width="45%">Service</th>
																		<th>Skill Level</th>
																	</tr>
																</thead>
																<tbody>
																	<c:forEach var="s" items="${serviceList}">
																		<c:set var="skill"
																			value="${assignService[s.serviceId]}" />
																		<tr>
																			<td>
																				<div class="form-check">
																					<input class="form-check-input service-checkbox"
																						type="checkbox" name="serviceIds"
																						value="${s.serviceId}" id="service_${s.serviceId}"
																						${skill != null ? "checked" : ""}> <label
																						class="form-check-label"
																						for="service_${s.serviceId}">${s.serviceName}</label>
																				</div>
																			</td>

																			<td><select class="form-select skill-select"
																				name="skillLevel_${s.serviceId}"
																				${skill == null ? "disabled" : ""}>
																					<option value="">-- Select Skill Level --</option>
																					<option value="Beginner"
																						${skill == 'Beginner' ? 'selected' : ''}>Beginner</option>
																					<option value="Intermediate"
																						${skill == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
																					<option value="Professional"
																						${skill == 'Professional' ? 'selected' : ''}>Professional</option>
																			</select></td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-primary"
																data-bs-dismiss="modal">Done</button>
														</div>
													</div>
												</div>
											</div>
										</div>

										<!-- Address -->
										<div class="col-sm-12 mt-3">
											<div>
												<label class="form-label">Address</label>
												<textarea class="form-control" rows="3"
													placeholder="Enter Address" name="address" required><%=b.getAddress()%></textarea>
												<div class="valid-feedback">Address looks good!</div>
												<div class="invalid-feedback">Please enter address.</div>
											</div>
										</div>

										<!-- Status -->
										<div class="col-sm-12 mt-3">
											<label class="form-label">Status</label> <select
												name="status" class="form-select">
												<option selected disabled value="">Choose status...</option>
												<option value="active"
													<%="active".equals(b.getStatus()) ? "selected" : ""%>>Active</option>
												<option value="resign"
													<%="resign".equals(b.getStatus()) ? "selected" : ""%>>Resign</option>
											</select>
										</div><br>

										<div class="col-sm-12 mt-2">
											<div class="alert alert-info py-2 px-3 small mb-3 rounded-3"
												role="alert">Note: Assign shifts later so customers
												can pick the barber.</div>
										</div>

										<!-- Buttons -->
										<div class="mt-4">
											<a href="<c:url value='/admin/ListBarberView' />"
												class="btn btn-secondary ms-2 px-4">Cancel</a>
											<button class="btn btn-primary px-4" type="submit">Save</button>
										</div>
									</form>
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
	<script src="../assets/js/form-validation-custom.js"></script>
	<script src="../assets/js/extra/validation-service.js"></script>
	<script src="../assets/js/clock/clock.js"></script>
	<script src="../assets/js/script.js"></script>
	<script src="../assets/js/extra/alert-timeout.js"></script>

</body>
</html>