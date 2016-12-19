(function($){

var Thumbnailer = function(core,options){
  this.core = core;
  $.extend(this,Thumbnailer.defaults,options);
  this.init();
};

$.extend(Thumbnailer,{
  defaults: {
    // Set to a specific Selection object
    // If this value is set, the preview will only track that Selection
    selection: null,

    fading: true,
    fadeDelay: 1000,
    fadeDuration: 1000,
    autoHide: false,
    width: 80,
    height: 80,
    _hiding: null
  },
  prototype: {
    init: function(){
      this.initEvents();
      this.refresh();
      this.insertElements();
      if (this.selection) {
        this.renderSelection(this.selection);
        this.selectionTarget = this.selection.element[0];
      } else if (this.core.ui.selection) {
        this.renderSelection(this.core.ui.selection);
      }
    },
    updateImage: function(imgel){
      this.preview.remove();
      this.preview = $($.Jcrop.imageClone(imgel));
      this.element.append(this.preview);
      this.refresh();
      return this;
    },
    insertElements: function(){
      this.preview = $($.Jcrop.imageClone(this.core.opt.imgTarget));

      this.element = $('<div />').addClass('jcrop-thumb')
        .width(this.width).height(this.height)
        .append(this.preview)
        .appendTo(this.core.container);
    },
    resize: function(w,h){
      this.width = w;
      this.height = h;
      this.element.width(w).height(h);
      this.renderCoords(this.last);
    },
    refresh: function(){
      this.cw = (this.core.opt.xscale * this.core.container.width());
      this.ch = (this.core.opt.yscale * this.core.container.height());
      if (this.last) {
        this.renderCoords(this.last);
      }
    },
    renderCoords: function(c){
      var rx = this.width / c.w;
      var ry = this.height / c.h;

      this.preview.css({
        width: Math.round(rx * this.cw) + 'px',
        height: Math.round(ry * this.ch) + 'px',
        marginLeft: '-' + Math.round(rx * c.x) + 'px',
        marginTop: '-' + Math.round(ry * c.y) + 'px'
      });

      this.last = c;
      return this;
    },
    renderSelection: function(s){
      return this.renderCoords(s.core.unscale(s.get()));
    },
    selectionStart: function(s){
      this.renderSelection(s);
    },
    show: function(){
      if (this._hiding) clearTimeout(this._hiding);

      if (!this.fading) this.element.stop().css({ opacity: 1 });
      else this.element.stop().animate({ opacity: 1 },{ duration: 80, queue: false });
    },
    hide: function(){
      var t = this;
      if (!t.fading) t.element.hide();
      else t._hiding = setTimeout(function(){
        t._hiding = null;
        t.element.stop().animate({ opacity: 0 },{ duration: t.fadeDuration, queue: false });
      },t.fadeDelay);
    },
    initEvents: function(){
      var t = this;
      t.core.container.on('cropimage cropstart cropmove cropend',function(e,s,c){
        if (t.selectionTarget && (t.selectionTarget !== e.target)) return false;

        switch(e.type){
          case 'cropimage':
            t.updateImage(c);
            break;
          case 'cropstart':
            t.selectionStart(s);
            t.show();
            break;
          case 'cropend':
            t.renderCoords(c);
            if (t.autoHide) t.hide();
            break;
          case 'cropmove':
            t.renderCoords(c);
            break;
        }
      });
    }
  }
});

$.Jcrop.component.Thumbnailer = Thumbnailer;

})(jQuery);
