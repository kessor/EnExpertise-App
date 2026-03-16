import Foundation

struct PEFEntry: Identifiable {
    let id = UUID()
    let name: String
    let factor: Double
    let category: String
}

struct PEFData {
    static let entries = [
        PEFEntry(name: "Heizöl", factor: 1.1, category: "Fossil"),
        PEFEntry(name: "Erdgas", factor: 1.1, category: "Fossil"),
        PEFEntry(name: "Flüssiggas", factor: 1.1, category: "Fossil"),
        PEFEntry(name: "Steinkohle", factor: 1.1, category: "Fossil"),
        PEFEntry(name: "Braunkohle", factor: 1.2, category: "Fossil"),
        PEFEntry(name: "Biogas", factor: 1.1, category: "Biogen"),
        PEFEntry(name: "Bioöl", factor: 1.1, category: "Biogen"),
        PEFEntry(name: "Holz", factor: 0.2, category: "Biogen"),
        PEFEntry(name: "Netzstrom", factor: 1.8, category: "Strom"),
        PEFEntry(name: "PV / Wind (gebäudenah)", factor: 0.0, category: "Strom")
    ]
}
