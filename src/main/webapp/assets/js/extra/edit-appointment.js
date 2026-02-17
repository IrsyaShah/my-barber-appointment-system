document.addEventListener("DOMContentLoaded", function() {
	const form = document.querySelector("form.needs-validation");
	const serviceGroup = document.getElementById("serviceGroup");
	const checkboxes = document.querySelectorAll("input[name='serviceIds']");
	const feedback = serviceGroup.querySelector(".invalid-feedback");

	function updateServiceState() {
		const checked = Array.from(checkboxes).some(cb => cb.checked);

		if (checked) {
			serviceGroup.classList.remove("is-invalid");
			serviceGroup.classList.add("is-valid");
			feedback.style.display = "none";
		} else {
			serviceGroup.classList.remove("is-valid");
			serviceGroup.classList.add("is-invalid");
			feedback.style.display = "block";
		}
	}

	checkboxes.forEach(cb => cb.addEventListener("change", updateServiceState));

	form.addEventListener("submit", function(e) {
		updateServiceState();
		if (!Array.from(checkboxes).some(cb => cb.checked)) {
			e.preventDefault();
			e.stopPropagation();
		}
	});
});

function updateEndTime() {
	const startTime = document.getElementById("startTime").value;
	const endInput = document.getElementById("endTime");

	if (!startTime) {
		endInput.value = "";
		return;
	}

	// startTime format: HH:mm
	const parts = startTime.split(":");
	let hours = parseInt(parts[0], 10);
	let minutes = parseInt(parts[1], 10);

	// add 30 minutes
	minutes += 30;
	if (minutes >= 60) {
		minutes -= 60;
		hours += 1;
	}

	// handle overflow
	if (hours >= 24) {
		hours = 23;
		minutes = 59;
	}

	// convert to 12-hour format
	const ampm = hours >= 12 ? "PM" : "AM";
	let displayHours = hours % 12;
	displayHours = displayHours === 0 ? 12 : displayHours;

	// format final string
	const endTime =
		String(displayHours).padStart(2, "0") + ":" +
		String(minutes).padStart(2, "0") + " " + ampm;

	endInput.value = endTime;
}

$(document).ready(function() {
	var input = $('#minMaxExample');
	var dateStr = input.val(); // "31/12/2025"

	if (dateStr) {
		var parts = dateStr.split('/');
		var day = parseInt(parts[0], 10);
		var month = parseInt(parts[1], 10) - 1; // JS months are 0-indexed
		var year = parseInt(parts[2], 10);
		var dateObj = new Date(year, month, day);

		input.datepicker({
			language: 'en',
			dateFormat: 'dd/mm/yyyy',
			autoClose: true
		}).data('datepicker').selectDate(dateObj);
	} else {
		input.datepicker({
			language: 'en',
			dateFormat: 'dd/mm/yyyy',
			autoClose: true
		});
	}
});