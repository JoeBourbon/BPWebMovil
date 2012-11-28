_global.ondula = function(anguloini, longradio) {
	/* devuelve la longitud de un cateto de un triangulo rectangulo
	 se logran movimientos tipo sinoidal
	 'anguloini' es el angulo del cateto con la hipotenusa
	 y determina la posición de inicio del bucle
	 'longradio'es la hipotenusa (o radio del circulo imaginario)
	 Ej.
	 onClipEvent (enterFrame) {
	 this._x = 275+ondula(desdeymas(0, -10, a++), 50);
	 this._y = 200+ondula(desdeymas(90, -10, b++), 50);
	 this._alpha = ((ondula(desdeymas(90, -10, c++), 50)+50)*100)/100;
	//ojo a la variable de incremento, a y b,
	//deben ser diferentes o irá más rápido
	}
	*/
	return ((Math.sin(Math.PI/180*anguloini))*longradio);
};
