import Foundation

struct WasteHeatCalculation {
    var nennleistungKW: Double = 80.0 
    var betriebsStundenProTag: Double = 16.0 
    var betriebsTageProWoche: Double = 5.0 
    var betriebsWochenProJahr: Double = 48.0 
    var brennstoffpreis: Double = 0.07 
    var amortisationszeitJahre: Int = 15 
    var zinssatz: Double = 0.025 

    var jahresAbwaermeMengeKWh: Double {
        return nennleistungKW * 0.75 * (betriebsStundenProTag * betriebsTageProWoche * betriebsWochenProJahr)
    }

    var jaehrlicheErsparnisEuro: Double {
        return jahresAbwaermeMengeKWh * brennstoffpreis
    }
}
