import SwiftUI
import PDFKit
import UIKit // Für Schriftarten und Zeichen-Tools

class ReportGenerator {
    
    // 1. Compliance Report
    static func generateComplianceReport(consumptionGWh: Double, isKMU: Bool, resultMessage: String) -> URL? {
        let pdfMetaData = [
            kCGPDFContextCreator: "EnExpertise App",
            kCGPDFContextAuthor: "Energieberater"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 595.2
        let pageHeight = 841.8
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            
            let title = "EnExpertise - Compliance Audit Report"
            let titleAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.18, green: 0.55, blue: 0.34, alpha: 1.0)
            ]
            title.draw(at: CGPoint(x: 50, y: 50), withAttributes: titleAttributes)
            
            let kmuText = isKMU ? "Ja" : "Nein"
            let body = """
            Datum: \(Date().formatted(date: .abbreviated, time: .shortened))
            
            Unternehmensdaten:
            Gesamtenergieverbrauch: \(String(format: "%.2f", consumptionGWh)) GWh/a
            KMU-Status: \(kmuText)
            
            Gesetzliche Bewertung (EDL-G / EnEfG):
            \(resultMessage)
            """
            
            let bodyAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let textRect = CGRect(x: 50, y: 120, width: pageWidth - 100, height: pageHeight - 150)
            body.draw(in: textRect, withAttributes: bodyAttributes)
        }
        
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("Compliance_Report.pdf")
        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            return nil
        }
    }
    
    // 2. NEU: Abwärme Report
    static func generateWasteHeatReport(nennleistung: Double, ersparnis: String, investition: String) -> URL? {
        let pdfMetaData = [kCGPDFContextCreator: "EnExpertise App", kCGPDFContextAuthor: "Energieberater"]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 595.2
        let pageHeight = 841.8
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            
            let title = "EnExpertise - Abwärme-Analyse"
            let titleAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.18, green: 0.55, blue: 0.34, alpha: 1.0)
            ]
            title.draw(at: CGPoint(x: 50, y: 50), withAttributes: titleAttributes)
            
            let body = """
            Datum: \(Date().formatted(date: .abbreviated, time: .shortened))
            
            Anlagendaten:
            Kälteaggregat Nennleistung: \(String(format: "%.0f", nennleistung)) kW
            
            Ergebnisse der Wirtschaftlichkeitsberechnung:
            Jährliche Brennstoffkosten-Ersparnis: \(ersparnis)
            Wirtschaftlich vertretbare Investition: \(investition)
            
            Bewertung:
            Die gewählte Abwärmenutzungsart ist technisch möglich.
            Ein Wärmespeicher verbessert die Wärmenutzung.
            Das Projekt ist voraussichtlich rentabel, die weitere Projektentwicklung ist sinnvoll.
            """
            
            let bodyAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let textRect = CGRect(x: 50, y: 120, width: pageWidth - 100, height: pageHeight - 150)
            body.draw(in: textRect, withAttributes: bodyAttributes)
        }
        
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("Abwaerme_Report.pdf")
        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            return nil
        }
    }
}