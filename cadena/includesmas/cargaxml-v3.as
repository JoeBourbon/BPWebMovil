//cargaxml("index-accesible.htm", 50, 20, 0xff0000, "doc_xml", "cargando datos");
//
// con el método CALL (this) se logra parar la linea de tiempo donde se ejecuta la función
//cargaxml.call(this, "index-accesible.htm", 50, 20, 0xff0000, "doc_xml", "cargando datos");
//
// el script devuelve el documento XML en (nombre de instancia)+('file_xml')
// Ej.'_root.doc_xml.file_xml'
_global.cargaxml = function(filexml, xcarga, ycarga, colorcarga, nom_instancia, mensaje) {
	//se para la linea de tiempo actual hasta cargar el XML
	var calldesde = eval(this);
	calldesde.stop();
	//se busca un nivel vacio
	for (posicion in _root) {
		if (typeof (_root[posicion]) == "movieclip") {
			nivelsup = _root[posicion].getDepth();
			break;
		}
	}
	if (nivelsup<0) {
		nivelsup = 0;
	}
	nivelcarga = nivelsup+1;
	//se crea un MC vacio que contenga el XML
	_root.createEmptyMovieClip(nom_instancia, nivelcarga);
	xml_mc = eval("_root."+nom_instancia);
	// inicio del valor de carga
	xml_mc.cargadelxml = 0;
	// para leer el UTF-8 con AS1:
	//System.UseCodePage = false;
	// se crea el objeto xml que contendrá el documento
	xml_mc.file_xml = new XML();
	xml_mc.file_xml.ignoreWhite = true;
	xml_mc.file_xml.onLoad = function(success) {
		if (success) {
			switch (xml_mc.file_xml.status) {
			case 0 :
				//trace("Se han cargados los datos, sin errores en la estructura ");
				xml_mc.mytext_txt.removeTextField();
				xml_mc.cargaxml_mc.removeMovieClip();
				xml_mc.cargadelxml = 100;
				calldesde.play();
				break;
			case -2 :
				respuesta = "Se han cargados los datos, pero una sección CDATA no se finalizó correctamente.";
				break;
			case -3 :
				respuesta = "Se han cargados los datos, pero la declaración XML no se finalizó correctamente.";
				break;
			case -4 :
				respuesta = "Se han cargados los datos, pero la declaración DOCTYPE no se finalizó correctamente.";
				break;
			case -5 :
				respuesta = "Se han cargados los datos, pero un comentario no se finalizó correctamente.";
				break;
			case -6 :
				respuesta = "Se han cargados los datos, pero un elemento XML estaba mal formado.";
				break;
			case -7 :
				respuesta = "Se han cargados los datos, pero la memoria es insuficiente.";
				break;
			case -8 :
				respuesta = "Se han cargados los datos, pero un valor de atributo no se finalizó correctamente.";
				break;
			case -9 :
				respuesta = "Se han cargados los datos, pero una etiqueta de inicio no coincidía con una etiqueta final.";
				break;
			case -10 :
				respuesta = "Se han cargados los datos, pero se ha encontrado una etiqueta final que no coincide con una etiqueta de inicio.";
				break;
			default :
				respuesta = "Se han cargado los datos, pero se ha encontrado un error desconocido";
			}
		} else {
			respuesta = "No se logró la conexión. Los datos no pueden ser cargados";
		}
		xml_mc.mytext_txt.text = respuesta;
		xml_mc.mytext_txt.setTextFormat(xml_mc.myformat_fmt);
	};
	// campo de texto
	xml_mc.createTextField("mytext_txt", 10, xcarga, ycarga, 300, 100);
	xml_mc.mytext_txt.multiline = true;
	xml_mc.mytext_txt.wordWrap = true;
	xml_mc.mytext_txt.html = true;
	// formato
	xml_mc.myformat_fmt = new TextFormat();
	xml_mc.myformat_fmt.font = "Arial";
	xml_mc.myformat_fmt.size = 10;
	xml_mc.myformat_fmt.color = colorcarga;
	xml_mc.idcarga = 0;
	xml_mc.file_xml.load(filexml);
	xml_mc.createEmptyMovieClip("cargaxml_mc", 20);
	xml_mc.cargaxml_mc.onEnterFrame = function() {
		bandatext = "";
		for (i=0; i<33; i++) {
			if (i<=(xml_mc.idcarga*33)/100) {
				bandatext += "l";
			} else {
				bandatext += ".";
			}
		}
		xml_mc.mytext_txt.htmlText = mensaje+": "+xml_mc.idcarga+" %<BR>"+bandatext;
		xml_mc.mytext_txt.setTextFormat(xml_mc.myformat_fmt);
		pesototal = xml_mc.file_xml.getBytesTotal();
		pesocargado = xml_mc.file_xml.getBytesLoaded();
		if ((pesototal>0) && (pesocargado == pesototal)) {
			idcarga = 100;
			delete this.onEnterFrame;
		} else if (pesocargado>0) {
			xml_mc.idcarga = Math.round((pesocargado*100)/pesototal);
			xml_mc.cargadelxml = xml_mc.idcarga;
		}
	};
};