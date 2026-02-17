$(document).ready(function() {
    
    // === 1. CALENDAR LOGIC ===
    if ($('#main-appt-calendar').length) {
        $('#main-appt-calendar').datepicker({
            language: 'en',
            todayButton: new Date(),
            inline: true,
            navTitles: {
                days: ' MM, <i>yyyy</i>' 
            },
            onRenderCell: function (date, cellType) {
                if (cellType == 'day') {
                    var year = date.getFullYear();
                    var month = ('0' + (date.getMonth() + 1)).slice(-2);
                    var day = ('0' + date.getDate()).slice(-2);
                    var dateString = year + '-' + month + '-' + day;

                    // Reference the bridge object
                    var dates = window.dashboardData.apptDates;

                    if (dates.confirmed.indexOf(dateString) !== -1) {
                        return { classes: '-has-confirmed-' };
                    }
                    if (dates.pending.indexOf(dateString) !== -1) {
                        return { classes: '-has-pending-' };
                    }
                    if (dates.completed.indexOf(dateString) !== -1) {
                        return { classes: '-has-completed-' };
                    }
                }
            },
            onSelect: function(formattedDate, date, inst) {
                if (date) {
                    var year = date.getFullYear();
                    var month = ('0' + (date.getMonth() + 1)).slice(-2);
                    var day = ('0' + date.getDate()).slice(-2);
                    var clickedDate = year + '-' + month + '-' + day;

                    var dates = window.dashboardData.apptDates;
                    var hasAppt = dates.pending.includes(clickedDate) || 
                                 dates.confirmed.includes(clickedDate) || 
                                 dates.completed.includes(clickedDate);

                    if (hasAppt) {
                        window.location.href = window.dashboardData.urls.appointmentView;
                    }
                }
            }
        });
    }

    // === 2. RADIAL CHART LOGIC ===
    if ($('#chart-widget5').length) {
        var options5 = {
            chart: {
                height: 350,
                type: 'radialBar',
            },
            series: [window.dashboardData.stats.percentage], 
            plotOptions: {
                radialBar: {
                    hollow: { size: '70%' },
                    dataLabels: {
                        show: true,
                        name: { show: true, fontSize: '16px', color: '#888', offsetY: -10 },
                        value: {
                            show: true,
                            fontSize: '22px',
                            fontWeight: 'bold',
                            color: '#111',
                            offsetY: 5,
                            formatter: function (val) { return val + "%"; }
                        },
                        total: {
                            show: true,
                            label: 'Grand Total',
                            formatter: function (w) {
                                return window.dashboardData.stats.grandTotal;
                            }
                        }
                    }
                }
            },
            colors: ['#fbd148'],
            stroke: { lineCap: 'round' },
            labels: ['Performance'],
        };

        $("#chart-widget5").empty();
        var chart5 = new ApexCharts(document.querySelector("#chart-widget5"), options5);
        chart5.render();
    }
});