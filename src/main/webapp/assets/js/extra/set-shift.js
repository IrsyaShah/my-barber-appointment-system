function setShiftTime() {
  const shift = document.getElementById("shiftType").value;
  const start = document.getElementById("startTime");
  const end = document.getElementById("finishTime");

  if (shift === "morning") {
    start.value = "08:00";
    end.value = "13:00";
  } else if (shift === "afternoon") {
    start.value = "13:00";
    end.value = "18:00";
  } else if (shift === "evening") {
    start.value = "18:00";
    end.value = "23:00";
  } else {
    start.value = "";
    end.value = "";
  }
}