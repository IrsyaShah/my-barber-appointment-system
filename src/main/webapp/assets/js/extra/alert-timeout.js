
document.addEventListener("DOMContentLoaded", function() {

	const alerts = document.querySelectorAll('.alert-dismissible');

	alerts.forEach(function(alert) {
		setTimeout(function() {
			// Check if bootstrap is loaded to close it nicely
			if (window.bootstrap && bootstrap.Alert) {
				const bsAlert = new bootstrap.Alert(alert);
				bsAlert.close();
			} else {
				alert.style.display = 'none'; // Fallback
			}
		}, 4000); // 4 seconds
	});
});