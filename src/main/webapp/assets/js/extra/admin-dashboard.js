$(document).ready(function() {
    const data = window.adminDashboardData;

    // === 1. Monthly Barber Appointments (Bar Chart) ===
    if (document.querySelector("#barber-appointments-chart")) {
        var optionsBar = {
            chart: { type: 'bar', height: 300, toolbar: { show: false } },
            series: [{ name: 'Appointments', data: data.monthlyData }],
            plotOptions: { bar: { borderRadius: 5, columnWidth: '45%', distributed: true } },
            colors: ['#fbd148', '#56382a', '#fbd148', '#56382a', '#fbd148', '#56382a', 
                     '#fbd148', '#56382a', '#fbd148', '#56382a', '#fbd148', '#56382a'],
            xaxis: { categories: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'] }
        };
        new ApexCharts(document.querySelector("#barber-appointments-chart"), optionsBar).render();
    }

    // === 2. Popular Services (Pie Chart) ===
    if (document.querySelector("#services-chart")) {
        var optionsPie = {
            chart: { type: 'pie', height: 300, toolbar: { show: false } },
            labels: data.servicePie.labels,
            series: data.servicePie.series,
            colors: ['#fbd148', '#56382a', '#755139', '#a89078', '#d8c3aa'],
            legend: { position: 'bottom' }
        };
        new ApexCharts(document.querySelector("#services-chart"), optionsPie).render();
    }

    // === 3. Items Slider (Slick) ===
    if ($('.items-slider').length) {
        $('.items-slider').slick({
            slidesToShow: 3, autoplay: true, arrows: true, dots: false,
            responsive: [{ breakpoint: 1200, settings: { slidesToShow: 2 } }, { breakpoint: 768, settings: { slidesToShow: 1 } }]
        });
    }

    // === 4. Sell Overview (Horizontal Bar Chart) ===
    if (document.querySelector("#sell-view")) {
        var optionsSell = {
            chart: { type: 'bar', height: 320, toolbar: { show: false } },
            series: [{ name: 'Products Sold', data: data.sellOverview.qty }, { name: 'Revenue (RM)', data: data.sellOverview.revenue }],
            plotOptions: { bar: { horizontal: true, barHeight: '60%', borderRadius: 4 } },
            colors: ['#fbd148', '#755139'],
            xaxis: { categories: data.sellOverview.labels }
        };
        new ApexCharts(document.querySelector("#sell-view"), optionsSell).render();
    }
});