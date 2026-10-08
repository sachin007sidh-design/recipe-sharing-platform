/* Login / register page helpers: show-hide password, live confirm check, strength meter */
(function () {
  // Eye button toggles password visibility
  document.querySelectorAll('[data-toggle-pass]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var input = document.getElementById(btn.dataset.togglePass);
      var show = input.type === 'password';
      input.type = show ? 'text' : 'password';
      btn.querySelector('i').className = show ? 'bi bi-eye-slash' : 'bi bi-eye';
    });
  });

  var pw = document.getElementById('password');
  var confirmBox = document.getElementById('confirm');
  var bar = document.getElementById('strengthBar');
  var label = document.getElementById('strengthLabel');

  // Browser shows a message if the two passwords differ
  if (pw && confirmBox) {
    var check = function () {
      confirmBox.setCustomValidity(confirmBox.value && confirmBox.value !== pw.value ? 'Passwords do not match' : '');
    };
    pw.addEventListener('input', check);
    confirmBox.addEventListener('input', check);
  }

  // Simple strength meter (length + variety of characters)
  if (pw && bar) {
    pw.addEventListener('input', function () {
      var v = pw.value, score = 0;
      if (v.length >= 6) score++;
      if (v.length >= 10) score++;
      if (/[A-Z]/.test(v) && /[a-z]/.test(v)) score++;
      if (/\d/.test(v) && /[^A-Za-z0-9]/.test(v)) score++;
      var levels = [
        { w: '0%',   c: '#e9ecef', t: '' },
        { w: '25%',  c: '#e03131', t: 'Weak' },
        { w: '50%',  c: '#f59f00', t: 'Fair' },
        { w: '75%',  c: '#74b816', t: 'Good' },
        { w: '100%', c: '#2f9e44', t: 'Strong' }
      ];
      var l = v ? levels[Math.max(score, 1)] : levels[0];
      bar.style.width = l.w;
      bar.style.background = l.c;
      if (label) label.textContent = l.t;
    });
  }
})();
