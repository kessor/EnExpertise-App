import Foundation
import Observation

@Observable
class ComplianceViewModel {
    var annualConsumptionGWh: Double = 0.0
    var isKMU: Bool = false
    
    var statusMessage: String {
        // Logik basierend auf EnEfG & EDL-G Entscheidungsbaum
        if annualConsumptionGWh < 0.5 {
            return "Keine gesetzliche Verpflichtung nach EDL-G/EnEfG."
        } else if isKMU {
            if annualConsumptionGWh >= 2.5 {
                return "Meldepflicht Abwärme (§ 16, 17 EnEfG) auf Plattform für Abwärme."
            }
            return "KMU: Aktuell keine direkte Auditpflicht."
        } else {
            // Nicht-KMU
            if annualConsumptionGWh >= 7.5 {
                return "Pflicht: EnMS (ISO 50001) oder UMS (EMAS) & Umsetzungspläne (§ 8, 9 EnEfG)."
            } else if annualConsumptionGWh >= 2.5 {
                return "Pflicht: Energieaudit (EDL-G) + Abwärme-Meldepflicht."
            } else {
                return "Pflicht: Energieaudit (EDL-G) alle 4 Jahre."
            }
        }
    }
}
