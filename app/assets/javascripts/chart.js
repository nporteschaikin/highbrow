(function(win, $) {
  var Chart = function(el) {
    this.el = el;
  }

  Chart.prototype = {
    render: function() {
      var data = $(this.el).data();
      var ctx = this.el.getContext("2d");

      $.getJSON(data.chartJsonPath, function(json) {
        new win.Chart(ctx, json);
      });
    }
  }

  $(function() {
    $("[data-chart-json-path]").each(function() {
      new Chart(this).render();
    });
  });
})(window, jQuery);
