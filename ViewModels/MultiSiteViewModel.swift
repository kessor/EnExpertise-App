import Foundation
import Observation

@Observable
class MultiSiteViewModel {
    
    // Die Liste der Standorte. Das "didSet" ruft bei jeder Änderung unsere Speicher-Funktion auf.
    var sites: [AuditSite] = [] {
        didSet {
            saveSites()
        }
    }
    
    // Wenn das ViewModel startet (App öffnet sich), laden wir die alten Daten
    init() {
        loadSites()
    }
    
    var totalConsumption: Double {
        sites.reduce(0) { $0 + $1.consumptionKWh }
    }
    
    var auditPoolSites: [AuditSite] {
        let sorted = sites.sorted { $0.consumptionKWh > $1.consumptionKWh }
        var currentSum = 0.0
        var pool: [AuditSite] = []
        for site in sorted {
            if currentSum < totalConsumption * 0.9 {
                pool.append(site)
                currentSum += site.consumptionKWh
            }
        }
        return pool
    }
    
    func sampleSize(for count: Int) -> Int {
        return Int(ceil(sqrt(Double(count))))
    }
    
    // MARK: - Daten-Persistenz (Speicherung)
    
    private let saveKey = "SavedAuditSites"
    
    private func saveSites() {
        // Wandelt die Liste in speicherbare JSON-Daten um
        if let encoded = try? JSONEncoder().encode(sites) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadSites() {
        // Sucht nach gespeicherten Daten und wandelt sie zurück in eine Liste
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([AuditSite].self, from: savedData) {
            self.sites = decoded
        }
    }
}