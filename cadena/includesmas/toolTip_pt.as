MovieClip.prototype.toolTip = function(str, bgcolor, niveltt) {
	// Ej. logoClip_mc.toolTip("ir a inicio", 0xffffff, 123)
	// (si no se pone color de fondo, ya hay uno por defecto)
	// (si no se pone nivel, se calcula el mas alto posible)
	// esto último puede fallar si el swf carga otro swf que mantiene su propio _root
	if (bgcolor == undefined) {
		bgcolor = "0xFFFFE1";
	}
	format = new TextFormat("arial", 11, 0x000000);
	this.onRollOver = function() {
		if (niveltt == undefined) {
			// se calcula el nivel mas alto para el toolTip
			for (posicion in _root) {
				if (typeof (_root[posicion]) == "movieclip") {
					nivel = _root[posicion].getDepth();
					break;
				}
			}
			if (nivel<0) {
				nivel = 0;
			}
			nivel += 2;
		} else {
			nivel = niveltt;
		}
		//
		_root.createTextField("tip", nivel, 0, 0, 0, 0);
		_root.tip.html = true;
		_root.tip.htmlText = " "+str+" ";
		_root.tip.autoSize = "left";
		_root.tip.background = true;
		_root.tip.border = false;
		_root.tip.selectable = false;
		_root.tip.backgroundColor = bgcolor;
		//_root.tip.borderColor = 0x000000;
		_root.tip.setTextFormat(format);
		_root.tip._x = _xmouse+4;
		if(_ymouse<29){
				coeficientetip = (( ( _ymouse - 6 ) * -29 ) / 22 )  + 25 ;
			} else {
				coeficientetip = -4;
			}
		_root.tip._y = _ymouse-_root.tip._height+coeficientetip;
		// creando la sombra
		_root.createEmptyMovieClip("tipsombra_mc", nivel-1);
		with (_root.tipsombra_mc) {
			clear();
			ancho = _root.tip._width;
			alto = _root.tip._height;
			beginFill(0x000000, 50);
			/*lineStyle (5, 0xFF00FF, 100);*/
			moveTo(0, 0);
			lineTo(ancho, 0);
			lineTo(ancho, alto);
			lineTo(0, alto);
			lineTo(0, 0);
			endFill();
			_x = _root.tip._x+3;
			_y = _root.tip._y+3;
		}
		// control de posicion
		this.ID_TOOLTIP = setInterval(function (_this) {
			_root.tip.posx = _xmouse+4;
			_root.tip.posy = _ymouse-_root.tip._height-4;
			if ((_root.tip.posx+_root.tip._width)>=Stage.width) {
				_root.tip.posx = Stage.width-_root.tip._width-1;
			}
			if (_root.tip.posy<=0) {
				_root.tip.posy = _root.tip.posy+_root.tip._height+24;
			}
			_root.tip._x += (_root.tip.posx-_root.tip._x)/10;
			_root.tip._y += (_root.tip.posy-_root.tip._y)/10;
			_root.tipsombra_mc._x = _root.tip._x+3;
			_root.tipsombra_mc._y = _root.tip._y+3;
			// 
		}, 20);
	};
	this.onRollOut = function() {
		_root.tip.removeTextField();
		_root.tipsombra_mc.unloadMovie();
		clearInterval(this.ID_TOOLTIP);
	};
};
