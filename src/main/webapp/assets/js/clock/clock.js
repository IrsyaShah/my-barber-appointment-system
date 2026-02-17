document.addEventListener("DOMContentLoaded", () => {

    const container = document.getElementById("datetime-display");
    if (!container) return;

    let serverTime = parseInt(container.dataset.serverTime, 10);

    setInterval(() => {
        serverTime += 1000;

        const date = new Date(serverTime);

        const options = {
            timeZone: "Asia/Kuala_Lumpur",
            hour12: true,
            year: "numeric",
            month: "2-digit",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit",
            second: "2-digit"
        };

        let formatted = date.toLocaleString("en-MY", options)
            .replace(/am|pm/g, m => m.toUpperCase());

        const clock = document.getElementById("ticking-clock");
        if (clock) {
            clock.textContent = formatted;
        }

    }, 1000);
});
