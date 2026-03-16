import Foundation

struct MathFormulas {
    
    /// Berechnet den Rentenbarwertfaktor (RVF) für die Wirtschaftlichkeit
    /// i = Zinssatz (z.B. 0.025 für 2,5%), n = Jahre
    static func calculateRVF(interest: Double, years: Int) -> Double {
        guard interest > 0 else { return Double(years) }
        let powFactor = pow(1 + interest, Double(years))
        return (powFactor - 1) / (interest * powFactor)
    }
    
    /// Berechnet die maximale wirtschaftliche Investition
    static func maxInvestment(annualSavings: Double, interest: Double, years: Int) -> Double {
        return annualSavings * calculateRVF(interest: interest, years: years)
    }
    
    /// Multi-Site Stichprobenberechnung (Quadratwurzel-Regel)
    static func calculateSampleSiteCount(totalComparableSites: Int) -> Int {
        return Int(ceil(sqrt(Double(totalComparableSites))))
    }
}
