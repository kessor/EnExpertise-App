import Foundation
import Observation

@Observable
class WasteHeatViewModel {
    var calculation = WasteHeatCalculation()
    
    var formattedErsparnis: String {
        let total = calculation.jaehrlicheErsparnisEuro
        return String(format: "%.2f €", total)
    }
    
    var wirtschaftlicheInvestition: String {
        let rvf = MathFormulas.calculateRVF(interest: calculation.zinssatz, years: calculation.amortisationszeitJahre)
        let maxInvest = calculation.jaehrlicheErsparnisEuro * rvf
        return String(format: "%.0f €", maxInvest)
    }
}
