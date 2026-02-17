<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="demo_barbershop.admin.appointment.*"%>
<%@ page import="demo_barbershop.customer.Customer"%>
<%
// retrieve logged in customer
Customer c = (Customer) session.getAttribute("loggedInCustomer");

// redirect to login page if customer not authenticated
if (c == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}

// retrieve appointment list
@SuppressWarnings("unchecked")
ArrayList<Appointment> appointmentList = (ArrayList<Appointment>) request.getAttribute("appointmentList");
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
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/view-appointment.css">
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
								<li><a href="#"><i data-feather="book"></i><span>Booking
									</span></a></li>
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

		if (session.getAttribute("appointment_cancel") != null) {
			message = "appointment_cancel";
			request.setAttribute("appointment_cancel", session.getAttribute("appointment_cancel"));
			session.removeAttribute("appointment_cancel");
		} else if (session.getAttribute("appointment_error") != null) {
			message = "appointment_error";
			request.setAttribute("appointment_error", session.getAttribute("appointment_error"));
			session.removeAttribute("appointment_error");
		} else if (session.getAttribute("receipt_error") != null) {
			message = "receipt_error";
			request.setAttribute("receipt_error", session.getAttribute("receipt_error"));
			session.removeAttribute("receipt_error");
		}

		if (message != null) {
			switch (message) {
			case "appointment_cancel":
		%>
		<div
			style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
			<div
				class="alert alert-success alert-dismissible fade show position-relative"
				role="alert" style="padding-right: 3rem;">
				<strong><%=request.getAttribute("appointment_cancel")%></strong>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close" style="position: absolute;"></button>
			</div>
		</div>
		<%
		break;
		case "appointment_error":
		%>
		<div
			style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
			<div
				class="alert alert-danger alert-dismissible fade show position-relative"
				role="alert" style="padding-right: 3rem;">
				<strong><%=request.getAttribute("appointment_error")%></strong>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close" style="position: absolute;"></button>
			</div>
		</div>
		<%
		break;
		case "receipt_error":
		%>
		<div
			style="position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 250px;">
			<div
				class="alert alert-danger alert-dismissible fade show position-relative"
				role="alert" style="padding-right: 3rem;">
				<strong><%=request.getAttribute("receipt_error")%></strong>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close" style="position: absolute;"></button>
			</div>
		</div>
		<%
		break;
		}
		}
		%>
		
		<!-- Cancel Appointment Modal -->
		<%
		if (appointmentList != null && !appointmentList.isEmpty()) {
			for (Appointment appt : appointmentList) {
		%>
		<div class="modal fade" id="cancelModal_<%=appt.getAppointmentId()%>"
			tabindex="-1" role="dialog"
			aria-labelledby="cancelModalLabel_<%=appt.getAppointmentId()%>"
			aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title"
							id="cancelModalLabel_<%=appt.getAppointmentId()%>">Confirm
							Cancellation</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>

					<div class="modal-body">
						Are you sure you want to cancel this appointment ?<br>This
						action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary"
							data-bs-dismiss="modal">Cancel</button>
						<a
							href="<%=request.getContextPath()%>/customer/CancelAppointmentView?appointment_id=<%=appt.getAppointmentId()%>"
							class="btn btn-warning">Confirm</a>
					</div>
				</div>
			</div>
		</div>
		<%
		} 
		}
		%>

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
										<h4 class="card-title mb-0">My Appointment</h4>
										<div class="card-options">
											<a class="card-options-collapse" href="javascript:void(0)"
												data-bs-toggle="card-collapse"><i
												class="fe fe-chevron-up"></i></a><a class="card-options-remove"
												href="javascript:void(0)" data-bs-toggle="card-remove"><i
												class="fe fe-x"></i></a>
										</div>
									</div>

									<div class="col-sm-12">
										<div class="card-body">
											<div class="table-responsive">
												<table class="display" id="basic-1">
													<thead>
														<tr>
															<th>Appt. Date</th>
															<th>Appt. Start</th>
															<th>Appt. Finish</th>
															<th>Remarks</th>
															<th>Service</th>
															<th>Status</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody>
														<%
														if (appointmentList != null && !appointmentList.isEmpty()) {
															for (Appointment appt : appointmentList) {
														%>
														<tr>

															<%
															DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

															DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a", Locale.ENGLISH);

															String apptDate = (appt.getAppointmentDate() != null) ? appt.getAppointmentDate().format(dateFormatter) : "-";

															String apptStart = (appt.getAppointmentStart() != null) ? appt.getAppointmentStart().format(timeFormatter).toUpperCase()
																	: "-";

															String apptFinish = (appt.getAppointmentFinish() != null)
																	? appt.getAppointmentFinish().format(timeFormatter).toUpperCase()
																	: "-";
															%>

															<td><%=apptDate%></td>
															<td><%=apptStart%></td>
															<td><%=apptFinish%></td>
															<td><%=appt.getRemarks()%></td>

															<!-- SERVICES MODAL -->
															<td>
																<ul class="action">
																	<li class="view"><a href="#"
																		data-bs-toggle="modal"
																		data-bs-target="#serviceModal_<%=appt.getAppointmentId()%>">
																			<i class="fa fa-list-ul" style="color: slateblue;"></i>
																	</a></li>
																</ul>

																<div class="modal fade"
																	id="serviceModal_<%=appt.getAppointmentId()%>"
																	tabindex="-1">

																	<div class="modal-dialog modal-dialog-centered">
																		<div class="modal-content">

																			<div class="modal-header">
																				<h5 class="modal-title">Services</h5>
																				<button class="btn-close" data-bs-dismiss="modal"></button>
																			</div>

																			<div class="modal-body">
																				<ul class="list-group">
																					<%
																					double total = 0.0;

																					if (appt.getServices() != null && !appt.getServices().isEmpty()) {
																						for (AppointmentService s : appt.getServices()) {
																							total += s.getPrice();
																					%>
																					<li
																						class="list-group-item d-flex justify-content-between align-items-center">
																						<span><%=s.getServiceName()%></span> <span>RM
																							<%=String.format("%.2f", s.getPrice())%></span>
																					</li>
																					<%
																					}
																					} else {
																					%>
																					<li class="list-group-item text-muted text-center">
																						No service selected</li>
																					<%
																					}
																					%>
																				</ul>

																				<hr>

																				<p class="text-end fw-bold">
																					Total Price: RM
																					<%=String.format("%.2f", total)%>
																				</p>
																			</div>

																		</div>
																	</div>
																</div>
															</td>

															<!-- STATUS -->
															<td>
																<%
																String status = appt.getStatus();
																String badgeClass = "badge-light-secondary";

																if ("Pending".equalsIgnoreCase(status)) {
																	badgeClass = "badge-light-warning";
																} else if ("Confirmed".equalsIgnoreCase(status)) {
																	badgeClass = "badge-light-info";
																} else if ("Completed".equalsIgnoreCase(status)) {
																	badgeClass = "badge-light-success";
																} else if ("Cancelled".equalsIgnoreCase(status)) {
																	badgeClass = "badge-light-danger";
																}
																%> <span class="badge rounded-pill <%=badgeClass%>">
																	<%=status%>
															</span>
															</td>

															<!-- ACTION -->
															<td>
																<ul class="action">
																	<%
																	String currentStatus = appt.getStatus();

																	if ("Completed".equals(appt.getStatus())) {
																	%>
																	<li class="view"><a
																		href="<%=request.getContextPath()%>/customer/CustomerReceiptView?id=<%=appt.getAppointmentId()%>">
																			<i class="fa fa-file-text-o"
																			style="color: slateblue;"></i>
																	</a></li>
																	<%
																	} else if ("Cancelled".equalsIgnoreCase(currentStatus)) {

																	} else {
																	%>
																	<li class="cancel"><a href="#"
																		data-bs-toggle="modal"
																		data-bs-target="#cancelModal_<%=appt.getAppointmentId()%>"><i
																			class="fa fa-ban" style="color: red;"></i></a></li>
																	<%
																	}
																	%>
																</ul>
															</td>
														</tr>
														<%
														}
														} else {
														%>
														<tr>
															<td colspan="7" class="text-center text-muted">No
																appointment found</td>
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
	<script src="../assets/js/extra/alert-timeout.js"></script>

</body>
</html>