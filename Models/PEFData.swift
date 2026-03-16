import Foundation

struct PEFEntry: Identifiable {
    let id = UUID()
    let name: String
    let factor: Double // Primärenergiefaktor
    let co2Factor: Double // CO2-Emissionsfaktor in kg/kWh
    let category: String
}

struct PEFData {
    static let entries = [
        PEFEntry(name: "Heizöl", factor: 1.1, co2Factor: 0.266, category: "Fossil"),
        PEFEntry(name: "Erdgas", factor: 1.1, co2Factor: 0.201, category: "Fossil"),
        PEFEntry(name: "Flüssiggas", factor: 1.1, co2Factor: 0.227, category: "Fossil"),
        PEFEntry(name: "Steinkohle", factor: 1.1, co2Factor: 0.338, category: "Fossil"),
        PEFEntry(name: "Braunkohle", factor: 1.2, co2Factor: 0.399, category: "Fossil"),
        PEFEntry(name: "Biogas", factor: 1.1, co2Factor: 0.144, category: "Biogen"),
        PEFEntry(name: "Bioöl", factor: 1.1, co2Factor: 0.074, category: "Biogen"),
        PEFEntry(name: "Holz", factor: 0.2, co2Factor: 0.039, category: "Biogen"),
        PEFEntry(name: "Netzstrom", factor: 1.8, co2Factor: 0.434, category: "Strom"), // Durchschnitts-Mix
        PEFEntry(name: "PV / Wind (gebäudenah)", factor: 0.0, co2Factor: 0.0, category: "Strom")
    ]
}