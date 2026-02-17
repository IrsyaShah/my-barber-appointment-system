$(document).ready(function() {
    // Handle click-to-copy for Barber IDs
    document.querySelectorAll('.copy-barber-id').forEach(item => {
        item.addEventListener('click', () => {
            const text = item.textContent.trim();
            
            // Use browser Clipboard API
            navigator.clipboard.writeText(text).then(() => {
                // Trigger Bootstrap Notify (Premium template plugin)
                $.notify(
                    {
                        title: 'Copied!',
                        message: `Barber ID <strong>${text}</strong> has been copied to clipboard.`,
                    },
                    {
                        type: 'success',
                        allow_dismiss: true,
                        placement: { from: 'top', align: 'right' },
                        animate: { 
                            enter: 'animated fadeInDown', 
                            exit: 'animated fadeOutUp' 
                        },
                        delay: 2000
                    }
                );
            });
        });
    });
});