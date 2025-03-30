// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
  // Znajdź wszystkie elementy z klasą 'alert' w #flash-messages
  const alerts = document.querySelectorAll('#flash-messages .alert');

  // Ustaw timer, aby ukryć każdy alert po 5 sekundach (5000 ms)
  alerts.forEach(alert => {
    setTimeout(() => {
      // Stopniowo zmniejszaj opacność, aby uzyskać efekt zanikania
      alert.style.transition = 'opacity 1s ease';
      alert.style.opacity = '0';

      // Po zakończeniu animacji zanikania usuń element z DOM
      setTimeout(() => {
        alert.remove();
      }, 1000); // Dodatkowy 1s na zakończenie animacji zanikania
    }, 5000);
  });
});



