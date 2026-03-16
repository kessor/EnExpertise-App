import Foundation

struct WasteHeatCalculation {
    
    // Wir nutzen Computed Properties mit direkter Speicheranbindung
    var nennleistungKW: Double {
        get { UserDefaults.standard.object(forKey: "whNennleistung") as? Double ?? 80.0 }
        set { UserDefaults.standard.set(newValue, forKey: "whNennleistung") }
    }
    
    var betriebsStundenProTag: Double {
        get { UserDefaults.standard.object(forKey: "whStunden") as? Double ?? 16.0 }
        set { UserDefaults.standard.set(newValue, forKey: "whStunden") }
    }
    
    var betriebsTageProWoche: Double {
        get { UserDefaults.standard.object(forKey: "whTage") as? Double ?? 5.0 }
        set { UserDefaults.standard.set(newValue, forKey: "whTage") }
    }
    
    var betriebsWochenProJahr: Double {
        get { UserDefaults.standard.object(forKey: "whWochen") as? Double ?? 48.0 }
        set { UserDefaults.standard.set(newValue, forKey: "whWochen") }
    }
    
    var brennstoffpreis: Double {
        get { UserDefaults.standard.object(forKey: "whPreis") as? Double ?? 0.07 }
        set { UserDefaults.standard.set(newValue, forKey: "whPreis") }
    }
    
    var amortisationszeitJahre: Int {
        get { UserDefaults.standard.object(forKey: "whAmort") as? Int ?? 15 }
        set { UserDefaults.standard.set(newValue, forKey: "whAmort") }
    }
    
    var zinssatz: Double {
        get { UserDefaults.standard.object(forKey: "whZins") as? Double ?? 0.025 }
        set { UserDefaults.standard.set(newValue, forKey: "whZins") }
    }

    // Die Berechnungen bleiben exakt gleich
    var jahresAbwaermeMengeKWh: Double {
        return nennleistungKW * 0.75 * (betriebsStundenProTag * betriebsTageProWoche * betriebsWochenProJahr)
    }

    var jaehrlicheErsparnisEuro: Double {
        return jahresAbwaermeMengeKWh * brennstoffpreis
    }
}