_global.desdeymas = function(desdeymasini, desdeymassuma, desdeymasi) {
	// devuelve un valor
	// iniciado desde 'desdeymasini'
	// y aumentado en porcetajes iguales a 'desdeymassuma'
	// ( desdeymasi siempre ser� del tipo "i++" )
	//Ej.     desdeymas(1,10,i++)    devolver�a los valores: 1, 11, 21 ,31 ,41 ...
	var desdeymasini;
	var desdeymassuma;
	var desdeymasi;
	return (desdeymasini+(desdeymassuma*desdeymasi));
};
