function validateServiceSelection() {

  const checked = document.querySelectorAll(".service-checkbox:checked");
  const alertBox = document.getElementById("serviceAlert");

  if (checked.length === 0) {
    alertBox.classList.remove("d-none");

    setTimeout(() => {
      alertBox.classList.add("d-none");
    }, 4000);

    return false;
  }

  // Hide alert if valid
  alertBox.classList.add("d-none");
  return true;
}

document.addEventListener("DOMContentLoaded", function () {

    const checkboxes = document.querySelectorAll(".service-checkbox");
    const summary = document.getElementById("serviceSummary");

    function updateSummary() {
        const count = document.querySelectorAll(".service-checkbox:checked").length;
        summary.textContent = count > 0
            ? count + " service(s) assigned"
            : "No service assigned";
    }

    checkboxes.forEach(cb => {
        const row = cb.closest("tr");
        const select = row.querySelector(".skill-select");

        cb.addEventListener("change", function () {
            if (this.checked) {
                select.disabled = false;
                select.required = true;
            } else {
                select.disabled = true;
                select.required = false;
                select.value = "";
            }
            updateSummary();
        });
    });

});