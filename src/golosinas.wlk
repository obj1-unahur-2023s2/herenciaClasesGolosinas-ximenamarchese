/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 
 class Golosina {
 	var peso = 0
 	method peso() = peso
 	method libreDeGluten() = true
 }
 
class Bombon inherits Golosina{
	
	method precio() { return 5 }
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
}


class Alfajor inherits Golosina{
		
	method precio() { return 12 }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
}

class Caramelo inherits Golosina{
	var property sabor
		
	method precio() { return 12 }
	method mordisco() { peso = peso - 1 }
}

class CorazonChocolate inherits Caramelo{
	override method mordisco(){
		super()
		sabor = chocolate
	}
	override method precio() = super() + 1
}

class Chupetin inherits Golosina{
	
	method precio() { return 2 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
}

class Oblea inherits Golosina{

	method precio() { return 5 }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
	override method libreDeGluten() { return false }
}

class Chocolatin inherits Golosina {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	override method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	override method libreDeGluten() { return false }

}

class GolosinaBaniada inherits Golosina {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	override method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	override method libreDeGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreDeGluten()) 7 else 10) }
	override method peso() { return 5 }
	override method libreDeGluten() { return libreDeGluten }	
	method libreDeGluten(valor) { libreDeGluten = valor }
}

class BombonDuro inherits Bombon {
	
	override method mordisco(){
		peso = 0.max(peso-1)
	}
	
	method gradoDeDureza(){
		if (peso > 12){
			return 3
		}
		else if (8 <= peso and peso <= 12){
			return 2
		}
		else {
			return 1
		}
	}
}

class ObleaCrujiente inherits Oblea {
	var property cantMordiscos = 0
	
	override method mordisco(){
		super()
		if (cantMordiscos < 3){
			peso = peso-3
		} 
		cantMordiscos += 1 
	}
	method estaDebil() = cantMordiscos > 3 
}

class ChocolatinVip inherits Chocolatin {
	var humedad
	
	method humedad() = humedad 
	method humedad(nuevaHumedad){  //duda : se puede override de una var 
		humedad = nuevaHumedad
	}
	override method peso(){
		return super() * 1 + humedad
	}
}

class ChocolatinPremium inherits ChocolatinVip {
	
	override method humedad(){
		return super()/2	
	}
}