<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="demo_barbershop.staff.Staff"%>
<%@ page import="demo_barbershop.receipt.Receipt"%>
<%@ page import="demo_barbershop.admin.appointment.AppointmentService"%>
<%
// retrieve logged in staff
Staff sf = (Staff) session.getAttribute("loggedInStaff");

// redirect to login page if staff not authenticated
if (sf == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}

// retrieve receipt
Receipt r = (Receipt) request.getAttribute("receipt");

// format appointment date and time for display
DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("dd MMM yyyy");
DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("hh:mm a", Locale.ENGLISH);
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
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="../assets/css/vendors/extra/receipt.css">
<link rel="stylesheet" type="text/css" href="../assets/css/style.css">
<link id="color" rel="stylesheet" href="../assets/css/color-6.css"
	media="all">
<!-- Responsive css-->
<link rel="stylesheet" type="text/css"
	href="../assets/css/responsive.css">
</head>
<body>
	<div class="container invoice mt-5">
		<div class="row">
			<div class="col-sm-12">
				<div class="card">
					<div class="card-body">

						<!-- Header -->
						<div class="row invo-header">
							<div class="col-sm-6">
								<div class="d-flex">
									<img src="../assets/images/logo/logo-icon.png"
										class="img-60 me-3" />
									<div>
										<h4 class="f-w-600">Demo Barbershop</h4>
										<p style="text-transform: none;">
											demobarbershop@hotmail.com<br> <span class="digits">01x-xxxxxxx</span>
										</p>
									</div>
								</div>
							</div>

							<div class="col-sm-6 text-end">
								<h3>
									Receipt #<span class="digits">KB-<%=String.format("%02d", r.getReceiptId())%></span>
								</h3>
								<p>
									Issued: <span class="digits"><%=r.getIssuedDate().toLocalDateTime().format(dateFmt)%></span><br />
									Payment: <strong><%=r.getPaymentName()%></strong>
								</p>
							</div>
						</div>

						<!-- Customer and Appointment Info -->
						<div class="row invo-profile mt-4">
							<div class="col-xl-4">
								<div class="d-flex">
									<div>
										<h4 class="f-w-600"><%=r.getBarberName()%></h4>
										<p>
											Barber<br> <span class="digits"><%=r.getBarberPhone()%></span>
										</p>
									</div>
								</div>
							</div>

							<div class="col-xl-8">
								<div>
									<h6>Customer Appointment Details</h6>
									<p>
										<strong>Customer:</strong>
										<%=r.getCustomerName()%><br> <strong>Appointment
											Date:</strong>
										<%=r.getAppointmentDate().format(dateFmt)%><br> <strong>Time:</strong>
										<%=r.getStartTime().format(timeFmt)%>
										-
										<%=r.getFinishTime().format(timeFmt)%><br> <strong>Remarks:</strong>
										<%=r.getRemarks()%>
									</p>
								</div>
							</div>
						</div>

						<!-- Table (Service and Price) -->
						<div class="table-responsive invoice-table mt-4">
							<table class="table table-bordered table-striped">
								<tbody>
									<tr>
										<td><h6>Service</h6></td>
										<td><h6>Qty</h6></td>
										<td><h6>Price</h6></td>
										<td><h6>Total</h6></td>
									</tr>
									<%
									double subtotal = 0;
									for (AppointmentService s : r.getServices()) {
										subtotal += s.getPrice();
									%>
									<tr>
										<td><%=s.getServiceName()%></td>
										<td class="digits">1</td>
										<td class="digits">RM <%=String.format("%.2f", s.getPrice())%></td>
										<td class="digits">RM <%=String.format("%.2f", s.getPrice())%></td>
									</tr>
									<%
									}
									%>

									<tr>
										<td></td>
										<td></td>
										<td><strong>Subtotal</strong></td>
										<td class="digits">RM <%=String.format("%.2f", subtotal)%></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td><h6 class="mb-0 p-2">Total</h6></td>
										<td class="payment digits"><h6 class="mb-0 p-2">
												RM
												<%=String.format("%.2f", r.getTotalAmount())%></h6></td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- Footer -->
						<div class="row mt-4">
							<div class="col-md-8">
								<p>
									<strong>Thank you for choosing Demo Barbershop!</strong><br>
									We appreciate your visit. Hope to see you again soon!
								</p>
							</div>

							<div class="col-md-4 text-end">
								<button class="btn btn-primary" onclick="window.print()">Print
									Receipt</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap -->
	<script src="../assets/js/bootstrap/bootstrap.js"></script>
	<script src="../assets/js/script.js"></script>

</body>
</html>
