_global.menosdeuno = function(a,b){
	// devuelve true si la diferencia de los dos valores es menos de 1
	// Ej. menosdeuno(0.5,1); devuelve True
	if(a<b){
		var c = a;
		a = b;
		b = c;
	}
	if((a-b)<1) {
		return true;
	} else {
		return false;
	}
};
