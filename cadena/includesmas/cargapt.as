//La función
MovieClip.prototype.cargapt = function(peliacargar, nameinstancia, nivelinstancia, alphainstancia, posxinstancia, posyinstancia) {
	//funcion para cargar un jpg o swf
	//parentclip_mc.cargapt("clip.swf","clip_mc",nivel,alpha,x,y);
	//devuelve el % de la carga en _root.clip_mc.cargaxcien
	//devuelve el % de la carga en _root.clip_mc.cargakbs
	//cuando termine la carga llamará a la funcion clip_mc_callback()
	//parentclip_mc.clip_mc_callback = function() {// el callback}
	//
	//Crea una pelicula vacia con su nombre de instancia y nivel
	eval(this).createEmptyMovieClip(nameinstancia, nivelinstancia);
	//se le dan los valores de posicion y transparencia
	var rutainstancia = eval("this."+nameinstancia);
	rutainstancia._alpha = alphainstancia;
	rutainstancia._x = posxinstancia;
	rutainstancia._y = posyinstancia;
	rutainstancia.cargaxcien = 0;
	rutainstancia.cargakbs = "";
	//se carga el jpg o swf
	rutainstancia.loadMovie(peliacargar);
	//se crea una funcion para obtener en % de carga
	if (cargajpg_interval.length == undefined) {
		cargajpg_interval = new Array();
	}
	rutainstancia.cargando = function() {
		rutainstancia.cargaxcien = Math.round((rutainstancia.getBytesLoaded()*100)/rutainstancia.getBytesTotal());
		rutainstancia.cargakbs = Math.round(rutainstancia.getBytesLoaded()/1024)+"/"+Math.round(rutainstancia.getBytesTotal()/1024);
		if (isNaN(rutainstancia.cargaxcien) || rutainstancia.cargaxcien<0 || rutainstancia.cargaxcien == undefined) {
			rutainstancia.cargaxcien = 0;
			rutainstancia.cargakbs = "";
		}
		//trace(rutainstancia+": "+rutainstancia.cargaxcien);               
		if (rutainstancia.cargaxcien == 100) {
			//trace("fin de la carga");
			eval(rutainstancia+"_callback").call(rutainstancia);
			clearInterval(carga_interval);
		}
	};
	var carga_interval = setInterval(rutainstancia.cargando, 40);
};