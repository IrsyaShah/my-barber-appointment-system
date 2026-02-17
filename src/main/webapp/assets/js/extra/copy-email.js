    // Handle click-to-copy for Barber Email
  document.querySelectorAll('.copy-email').forEach(item => {
    item.addEventListener('click', () => {
      const text = item.textContent.trim();
      navigator.clipboard.writeText(text).then(() => {
        $.notify(
          {
            title: 'Copied!',
            message: `Email <strong>${text}</strong> has been copied.`,
          },
          {
            type: 'success',
            allow_dismiss: true,
            placement: { from: 'top', align: 'right' },
            animate: { enter: 'animated fadeInDown', exit: 'animated fadeOutUp' }
          }
        );
      });
    });
  });