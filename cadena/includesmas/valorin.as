_global.valorin = function(valoruno, valorentre, valordos) {
	//devuelve true o false si 'valorentre' está entre 'valoruno' y 'valordos', ambos incluidos
	//Ej.  valorin(10,15,20) devuelve 'true'
	if (valorentre != valoruno && valorentre != valordos) {
		return ((valorentre>valoruno) == (valorentre<valordos));
	} else {
		return true;
	}
};
