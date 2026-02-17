<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.*"%>
<%@ page import="demo_barbershop.customer.Customer"%>
<%
// retrieve logged in staff
Customer c = (Customer) session.getAttribute("loggedInCustomer");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="pixelstrap">
<link rel="icon" href="assets/images/favicon/favicon.png"
	type="image/x-icon">
<link rel="shortcut icon" href="assets/images/favicon/favicon.png"
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
	href="assets/css/vendors/font-awesome.css">
<!-- ico-font-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/icofont.css">
<!-- Themify icon-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/themify.css">
<!-- Flag icon-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/flag-icon.css">
<!-- Feather icon-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/feather-icon.css">
<!-- Plugins css start-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/animate.css">
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="assets/css/vendors/extra/customer-index.css">
<link rel="stylesheet" type="text/css" href="assets/css/style.css">
<link id="color" rel="stylesheet" href="assets/css/color-6.css"
	media="screen">
<!-- Responsive css-->
<link rel="stylesheet" type="text/css" href="assets/css/responsive.css">
</head>
<body class="landing-page">
	<!-- page-wrapper Start-->
	<div class="page-wrapper compact-wrapper">
		<!-- Page Body Start-->
		<!-- header start-->
		<header class="landing-header">
			<div class="page-header">
				<div class="header-wrapper row m-0">
					<div
						class="header-logo-wrapper col-auto d-flex align-items-center p-0">

						<a href="index.jsp" class="me-3"> <img
							src="assets/images/logo/logo-icon.png"
							alt="Demo Barbershop Logo"
							style="height: 45px; margin-left: 20px;">
						</a>
						<!-- NAVIGATION MENU -->
						<ul class="custom-nav d-flex align-items-center m-0 p-0">
							<li><a href="#home">Home</a></li>
							<li><a href="#services">Services</a></li>
							<li><a href="#barbers">Our Barbers</a></li>
							<li>
								<%
								if (c != null) {
								%> <a href="<c:url value='/customer/AddAppointmentView' />">Book
									Now</a> <%
 } else {
 %> <a
								href="<c:url value='/login.jsp' />?redirect=<c:url value='/customer/AddAppointmentView' />">Book
									Now</a> <%
 }
 %>
							</li>
							<li><a href="#contact">Contact</a></li>
						</ul>

					</div>
					<div class="nav-right col-8 pull-right right-header p-0">
						<%
						if (c != null) {
						%>
						<!-- display profile when customer logged in -->
						<ul class="nav-menus">
							<li class="profile-nav onhover-dropdown p-0 me-0">
								<div class="d-flex profile-media">
									<img class="b-r-50" src="assets/images/dashboard/profile.jpg"
										alt="">
									<div class="flex-grow-1">
										<span><%=c.getFullName()%></span>
										<p class="mb-0 font-roboto">
											Member <i class="middle fa fa-angle-down"></i>
										</p>
									</div>
								</div>
								<ul class="profile-dropdown onhover-show-div">
									<li><a href="customer/view_account.jsp"><i
											data-feather="user"></i><span>Account </span></a></li>
									<li><a href="<c:url value='/customer/AppointmentView' />"><i
											data-feather="book"></i><span>Booking </span></a></li>
									<li><a href="<c:url value='/customer/CustomerLogout' />"><i
											data-feather="log-out"></i><span>Logout</span></a></li>
								</ul>
							</li>
						</ul>
						<%
						} else {
						%>
						<!-- display button when customer not logged in -->
						<a href="login.jsp" class="btn btn-primary">Login / Register</a>
						<%
						}
						%>
					</div>
					</div>
					</div>
		</header>

		<!-- Home-->
		<section class="site-hero overlay" id="home"
			data-stellar-background-ratio="0.5"
			style="background-image: url(assets/images/landing/landing-home/big_image_1.jpg); height: 700px; background-size: cover;">
			<div class="container">
				<div
					class="row align-items-center site-hero-inner justify-content-center">
					<div class="col-md-8 text-center">

						<div class="mb-5 element-animate">
							<img src="assets/images/landing/landing-home/banner_text_1.png"
								alt="Image placeholder" class="img-md-fluid"
								style="margin-top: 250px;">
						</div>

					</div>
				</div>
			</div>
		</section>

		<!-- Service-->
		<section class="core-feature section-py-space" id="services">
			<div class="col-sm-12 wow pulse">
				<div class="title">
					<div class="logo-wrraper">
						<img class="img-fluid bg-img"
							src="assets/images/logo/logo-icon.png" alt="">
					</div>
					<h2>Service Provided</h2>
					<p style="font-size: 16px; color: #555;">Quality grooming
						services for everyone</p>
				</div>
			</div>
			<div class="custom-container">
				<div class="row feature-block">
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
									<i data-feather="scissors"></i>
								</div>
								<h4>Haircut</h4>
								<p>Sharp and stylish cuts tailored to your face shape and
									personal style.</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
									<i data-feather="user"></i>
								</div>
								<h4>Beard Trim</h4>
								<p>A clean and sharp beard trim to keep your facial hair
									neat and well-defined.</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
									<i data-feather="check-circle"></i>
								</div>
								<h4>Shaving</h4>
								<p>A smooth and refreshing traditional shave for the
									cleanest look.</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
									<i data-feather="droplet"></i>
								</div>
								<h4>Hair Wash</h4>
								<p>A relaxing hair wash using premium shampoo to refresh
									your scalp and hair.</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
									<i data-feather="wind"></i>
								</div>
								<h4>Hair Styling</h4>
								<p>Professional styling to shape your look with high-quality
									grooming products.</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
								<i data-feather="sun"></i>
								</div>
								<h4>Facial Treatment</h4>
								<p>A gentle cleansing facial to refresh your skin and remove
									impurities.</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
									<i data-feather="star"></i>
								</div>
								<h4>Hair Coloring</h4>
								<p>Vibrant and long-lasting hair coloring to give you a
									bold, fresh appearance.</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-sm-6">
						<div class="feature-box">
							<div>
								<div class="icon-wrraper">
									<i data-feather="heart"></i>
								</div>
								<h4>Kids Haircut</h4>
								<p>Fun, friendly, and comfortable haircut session specially
									for kids.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Barber-->
		<section class="counter-sec section-py-space" id="barbers"
			style="background-color: #ededed;">
			<div class="col-sm-12 wow pulse">
				<div class="title">
					<div class="logo-wrraper">
						<img class="img-fluid bg-img"
							src="assets/images/logo/logo-icon.png" alt="">
					</div>
					<h2>Our Barbers</h2>
					<p style="font-size: 16px; color: #555;">Trusted barbers,
						perfect cuts</p>
				</div>
			</div>
			<div class="custom-container">
				<!-- Scrollable row -->
				<div class="row counter-block"
					style="display: flex; gap: 20px; overflow-x: auto; scroll-snap-type: x mandatory; padding-bottom: 10px; flex-wrap: wrap;">

					<!-- BARBER 1 -->
					<div class="col-lg-6 col-sm-6"
						style="flex: 0 0 calc(50% - 10px); scroll-snap-align: start;">
						<div class="counter-box d-flex align-items-start"
							style="gap: 20px; text-align: left; border: 1px solid #c5c5c5;">
							<img src="assets/images/barbers/barber1.jpg" alt="Barber 1"
								style="width: 120px; height: 120px; object-fit: cover; border-radius: 50%; margin-top: 30px;">
							<!-- DETAILS -->
							<div class="count-detail">
								<h4 class="mb-1">Muhammad Aiman Syafiq</h4>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Services:</strong>
								</p>
								<ul class="mb-1">
									<li>Haircut - Professional</li>
									<li>Beard Trim - Professional</li>
									<li>Facial - Professional</li>
								</ul>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Contact:</strong> 01x-xxxxxxx
								</p>

								<%
								if (c != null) {
								%>
								<a href="customer/AddAppointmentView" class="book-btn">Book
									Now</a>
								<%
								} else {
								%>
								<a href="login.jsp?redirect=customer/AddAppointmentView"
									class="book-btn">Book Now</a>
								<%
								}
								%>
							</div>
						</div>
					</div>

					<!-- BARBER 2 -->
					<div class="col-lg-6 col-sm-6"
						style="flex: 0 0 calc(50% - 10px); scroll-snap-align: start;">
						<div class="counter-box d-flex align-items-start"
							style="gap: 20px; text-align: left; border: 1px solid #c5c5c5;">
							<img src="assets/images/barbers/barber2.jpg" alt="Barber 2"
								style="width: 120px; height: 120px; object-fit: cover; border-radius: 50%; margin-top: 30px;">
							<!-- DETAILS -->
							<div class="count-detail">
								<h4 class="mb-1">Mohd Ahmad Faiz</h4>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Services:</strong>
								</p>
								<ul class="mb-1">
									<li>Haircut - Intermediate</li>
									<li>Beard Trim - Intermediate</li>
									<li>Facial - Beginner</li>
								</ul>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Contact:</strong> 01x-xxxxxxx
								</p>

								<%
								if (c != null) {
								%>
								<a href="customer/AddAppointmentView" class="book-btn">Book
									Now</a>
								<%
								} else {
								%>
								<a href="login.jsp?redirect=customer/AddAppointmentView"
									class="book-btn">Book Now</a>
								<%
								}
								%>
							</div>
						</div>
					</div>

					<!-- BARBER 3 -->
					<div class="col-lg-6 col-sm-6"
						style="flex: 0 0 calc(50% - 10px); scroll-snap-align: start;">
						<div class="counter-box d-flex align-items-start"
							style="gap: 20px; text-align: left; border: 1px solid #c5c5c5;">
							<img src="assets/images/barbers/barber3.jpg" alt="Barber 3"
								style="width: 120px; height: 120px; object-fit: cover; border-radius: 50%; margin-top: 30px;">
							<div class="count-detail">
								<h4 class="mb-1">Muhd Naim Hakim</h4>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Services:</strong>
								</p>
								<ul class="mb-1">
									<li>Haircut - Intermediate</li>
									<li>Facial - Beginner</li>
								</ul>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Contact:</strong> 01x-xxxxxxx
								</p>

								<%
								if (c != null) {
								%>
								<a href="customer/AddAppointmentView" class="book-btn">Book
									Now</a>
								<%
								} else {
								%>
								<a href="login.jsp?redirect=customer/AddAppointmentView"
									class="book-btn">Book Now</a>
								<%
								}
								%>
							</div>
						</div>
					</div>

					<!-- BARBER 4 -->
					<div class="col-lg-6 col-sm-6"
						style="flex: 0 0 calc(50% - 10px); scroll-snap-align: start;">
						<div class="counter-box d-flex align-items-start"
							style="gap: 20px; text-align: left; border: 1px solid #c5c5c5;">
							<img src="assets/images/barbers/barber4.jpg" alt="Barber 4"
								style="width: 120px; height: 120px; object-fit: cover; border-radius: 50%; margin-top: 30px;">
							<div class="count-detail">
								<h4 class="mb-1">Tasnim Hafizi</h4>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Services:</strong>
								</p>
								<ul class="mb-1">
									<li>Haircut - Intermediate</li>
									<li>Beard Trim - Intermediate</li>
									<li>Hair and Beard coloring - Professional</li>
								</ul>
								<p class="mb-1" style="color: rgb(97, 96, 96);">
									<strong>Contact:</strong> 01x-xxxxxxx
								</p>

								<%
								if (c != null) {
								%>
								<a href="customer/AddAppointmentView" class="book-btn">Book
									Now</a>
								<%
								} else {
								%>
								<a href="login.jsp?redirect=customer/AddAppointmentView"
									class="book-btn">Book Now</a>
								<%
								}
								%>
							</div>
						</div>
					</div>

				</div>
			</div>
		</section>

		<!-- Contact-->
		<section class="framework section-py-space" id="contact"
			style="background-color: #f9f9f9; padding: 60px 0;">
			<div class="custom-container">

				<!-- Section Title -->
				<div class="row">
					<div class="col-sm-12 text-center mb-4">
						<div class="title">
							<div class="logo-wrraper">
								<img class="img-fluid bg-img"
									src="assets/images/logo/logo-icon.png" alt="">
							</div>
							<h2 style="font-size: 32px; margin-top: 15px;">Our Shop</h2>
							<p style="font-size: 16px; color: #555;">Everything you need
								under one roof</p>
						</div>
					</div>
				</div>

				<!-- Single Card with Image and Map -->
				<div class="row justify-content-center align-items-center">
					<div class="col-lg-10">
						<div class="card d-flex flex-row flex-wrap"
							style="border-radius: 15px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); overflow: hidden;">

							<!-- Left Image -->
							<div class="col-md-5 p-0" style="flex: 1 1 300px;">
								<img src="assets/images/landing/landing-home/contact.png"
									alt="Shop Image"
									style="width: 100%; height: 550px; object-fit: contain; object-position: left; display: block;">
							</div>

							<!-- Right Details + Map -->
							<div class="col-md-7 p-0"
								style="flex: 1 1 350px; display: flex; flex-direction: column; align-items: flex-start; padding-left: 20px; box-sizing: border-box; margin-right: 100px;">

								<!-- Shop Details -->
								<div style="width: 100%; margin-bottom: 20px;">
									<h3
										style="margin-bottom: 20px; font-weight: 600; font-size: 28px;">Meet
										Us</h3>
									<p style="margin-bottom: 12px; font-size: 16px;">
										<strong>Location:</strong> Demo Barbershop, Penang, Malaysia.
									</p>
									<p style="margin-bottom: 12px; font-size: 16px;">
										<strong>Hours:</strong> Mon - Sat: 8:00 AM - 10:00 PM |
										Sunday: Closed
									</p>
									<p style="margin-bottom: 12px; font-size: 16px;">
										<strong>Contact:</strong> 01x-xxxxxxx | demobarbershop@hotmail.com
									</p>
								</div>

								<!-- Google Map -->
								<div
									style="width: 100%; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);">
									<iframe class="gmap_iframe"
										src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d57512.30425541423!2d100.30934649999999!3d5.4058798999999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x304ac397ad2b7bd5%3A0x239ae45978a9b934!2sGeorge%20Town%2C%20Penang!5e1!3m2!1sen!2smy!4v1771323738699!5m2!1sen!2smy"
										style="width: 100%; height: 250px; border: 0; overflow: hidden;">
									</iframe>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</section>

		<!--footer start-->
		<footer class="footer">
			<div class="container-fluid">
				<div class="row">
					<p class="mb-0">
						Copyright &copy;
						<%= LocalDate.now().getYear() %>
						Demo Barbershop. All rights reserved.
					</p>
				</div>
			</div>
		</footer>
		<!--footer end-->
	</div>
	
	<!-- Bootstrap -->
	<script src="assets/js/jquery-3.6.0.min.js"></script>
	<script src="assets/js/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="assets/js/icons/feather-icon/feather.min.js"></script>
	<script src="assets/js/icons/feather-icon/feather-icon.js"></script>
	<script src="assets/js/config.js"></script>
	<script src="assets/js/animation/wow/wow.min.js"></script>
	<script src="assets/js/landing_wow.js"></script>
	<script src="assets/js/script.js"></script>
</body>
</html>