//= require api.js
//= require battleship.js

Api.init();

$(function(){
  d3.xml('/assets/app.svg', 'image/svg+xml', function (error, data) {
    d3.select('body #battleship').node().appendChild(data.documentElement);
    Battleship.init(d3.select('svg'));
  });
});
