import Foundation

struct AuditSite: Identifiable, Codable {
    var id = UUID()
    var name: String
    var consumptionKWh: Double
    var isComparable: Bool = false
}
