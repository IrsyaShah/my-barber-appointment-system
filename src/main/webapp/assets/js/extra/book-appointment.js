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

	checkboxes.forEach(cb => {
		cb.addEventListener("change", updateServiceState);
	});

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

	const parts = startTime.split(":");
	let hours = parseInt(parts[0], 10);
	let minutes = parseInt(parts[1], 10);

	minutes += 30;
	if (minutes >= 60) {
		minutes -= 60;
		hours += 1;
	}

	if (hours >= 24) {
		hours = 23;
		minutes = 59;
	}

	const ampm = hours >= 12 ? "PM" : "AM";
	let displayHours = hours % 12;
	displayHours = displayHours === 0 ? 12 : displayHours;

	const endTime =
		String(displayHours).padStart(2, "0") + ":" +
		String(minutes).padStart(2, "0") + " " + ampm;

	endInput.value = endTime;
}

const currentDate = $('#minMaxExample').val();

$(document).ready(function() {
	$('#minMaxExample').datepicker({
		language: 'en',
		dateFormat: 'dd/mm/yyyy',
		autoClose: true
	});
});

if (currentDate) {
	$('#minMaxExample').datepicker('setDate', currentDate);
}