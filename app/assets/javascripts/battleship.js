var Battleship = (function() {
  var s;

  return {
    settings: function(svg) {
      return {
        board: svg.select('#board'),
        message: svg.select('#message'),
        messageBar: svg.select('#message-bar'),
        restartButton: svg.select('#btn-restart'),
        ptWidth: 56,
        ptMargin: 8,
        boardMarginTop: 30,
        boardMarginLeft: 10
      };
    },

    init: function(svg) {
      s = this.settings(svg);
      this.initControls();
      this.render();
    },

    initControls: function() {
      s.restartButton
        .style('cursor', 'pointer')
        .on('mouseenter', function(){
          d3.select(this).transition().duration(300).attr('fill', '#157DFB');
        })
        .on('mouseleave', function(){
          d3.select(this).transition().duration(300).attr('fill', '#4A4A4A');
        })
        .on('click', this.restart);
    },

    render: function() {
      Api.board(function(data) {
        for(var i=0; i<10; i++) {
          for(var j=0; j<10; j++) {
            Battleship.setBoardPt(i, j);
          }
        }
        $.each(data.attacked_positions, function(index, value){
          Battleship.setPt('#pt-miss', value.x, value.y);
        });
      });
    },

    setPt: function(type, x, y) {
      var _x = x * (s.ptWidth + s.ptMargin) + s.boardMarginLeft;
      var _y = y * (s.ptWidth + s.ptMargin) + s.boardMarginTop;

      this.pt(x, y).remove();

      return s.board
        .append('use')
        .attr("xlink:href", type)
        .attr('id', this.ptId(x, y))
        .attr('x', _x)
        .attr('y', _y)
        .on('mouseenter', this.animateMouseHover(1.2))
        .on('mouseleave', this.animateMouseHover(1));
    },

    setBoardPt: function(x, y) {
      var pt = this.setPt('#pt', x, y);

      pt.style('cursor', 'pointer')
        .on('click', this.fire(x, y));
    },

    fire: function(x, y) {
      var fireFunction = function() {
        Api.attack(x, y, function(data) {
          var type = data.missed ? '#pt-miss' : '#pt-hit';
          Battleship.setPt(type, x, y);
          Battleship.attackMessage(data);
        });
      };

      return fireFunction;
    },

    attackMessage: function(attackResult) {
      this.flashMessageBar();
      if(attackResult.missed) {
        s.message.text('You missed!!!');
      } else if(attackResult.ship_destroyed) {
        s.message.text('You destroyed a ' + attackResult.attacked_ship);
      } else {
        s.message.text('You hit something!!!');
      }
    },

    restart: function() {
      Api.restart(function(){
        Battleship.render();
      });
    },

    ptId: function(x, y) {
      return 'pt-' + x + '-' + y;
    },

    pt: function(x, y) {
      return s.board.select('#' + this.ptId(x, y));
    },

    animateMouseHover: function(scale) {
      var animateFunction = function () {
        var node = d3.select(this);
        var x = +node.attr('x');
        var y = +node.attr('y');

        node.transition()
          .duration(300)
          .attr('transform', Battleship.scaleTransform(scale, x, y, s.ptWidth));
      };

      return animateFunction;
    },

    scaleTransform: function(scale, x, y, width) {
      _x = -(x + width / 2) * (scale - 1);
      _y = -(y + width / 2) * (scale - 1);

      return "translate(" + _x + ", " + _y + ") scale(" + scale + ")";
    },

    flashMessageBar: function(){
      var oldColor = s.messageBar.attr('fill');

      s.messageBar
        .transition()
        .duration(500)
        .attr('fill', 'red')
        .transition()
        .duration(500)
        .attr('fill', oldColor);
    }
  };
})();
