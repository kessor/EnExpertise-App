import SwiftUI
import PDFKit
import UIKit // Für Schriftarten und Zeichen-Tools

class ReportGenerator {
    
    // Generiert ein A4 PDF-Dokument aus den Compliance-Daten
    static func generateComplianceReport(consumptionGWh: Double, isKMU: Bool, resultMessage: String) -> URL? {
        // PDF Metadaten
        let pdfMetaData = [
            kCGPDFContextCreator: "EnExpertise App",
            kCGPDFContextAuthor: "Energieberater"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // A4 Format in Punkten (72 dpi)
        let pageWidth = 595.2
        let pageHeight = 841.8
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            
            // Titel zeichnen
            let title = "EnExpertise - Compliance Audit Report"
            let titleAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.18, green: 0.55, blue: 0.34, alpha: 1.0) // Energie-Grün
            ]
            title.draw(at: CGPoint(x: 50, y: 50), withAttributes: titleAttributes)
            
            // Textinhalte zusammenbauen
            let kmuText = isKMU ? "Ja" : "Nein"
            let body = """
            Datum: \(Date().formatted(date: .abbreviated, time: .shortened))
            
            Unternehmensdaten:
            Gesamtenergieverbrauch: \(String(format: "%.2f", consumptionGWh)) GWh/a
            KMU-Status: \(kmuText)
            
            Gesetzliche Bewertung (EDL-G / EnEfG):
            \(resultMessage)
            """
            
            let bodyAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
            ]
            
            // Textblock auf das PDF zeichnen
            let textRect = CGRect(x: 50, y: 120, width: pageWidth - 100, height: pageHeight - 150)
            body.draw(in: textRect, withAttributes: bodyAttributes)
        }
        
        // Datei temporär auf dem Gerät speichern, damit der Nutzer sie teilen kann
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("Compliance_Report.pdf")
        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            print("Fehler beim Erstellen des PDFs: \(error.localizedDescription)")
            return nil
        }
    }
}