var Api = (function() {
  var s;

  return {
    settings: {
      apiBase: '/game'
    },

    init: function() {
      s = this.settings;
    },

    board: function(callback) {
      $.get(this.path(), callback);
    },

    attack: function(x, y, callback) {
      var point = {x: x, y: y};
      $.post(this.path('attack'), point, callback);
    },

    restart: function(callback) {
      $.get(this.path('reset'), callback);
    },

    path: function(path) {
      if(path) {
        return s.apiBase + '/' + path;
      } else {
        return s.apiBase;
      }
    }
  };
})();
