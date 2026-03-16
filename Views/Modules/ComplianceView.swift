import SwiftUI

struct ComplianceView: View {
    @State private var viewModel = ComplianceViewModel()
    @State private var generatedPDFUrl: URL? // Speichert den Pfad zum fertigen PDF
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Unternehmensdaten") {
                    Toggle("KMU-Status", isOn: $viewModel.isKMU)
                    HStack {
                        Text("Gesamtverbrauch")
                        Spacer()
                        TextField("GWh", value: $viewModel.annualConsumptionGWh, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.blue)
                    }
                }
                
                Section("Rechtliche Bewertung (EDL-G / EnEfG)") {
                    Text(viewModel.statusMessage)
                        .font(.headline)
                        .foregroundColor(.green)
                }
                
                // NEU: PDF Export Sektion
                Section("Reporting") {
                    Button(action: {
                        // PDF-Engine starten und URL speichern
                        generatedPDFUrl = ReportGenerator.generateComplianceReport(
                            consumptionGWh: viewModel.annualConsumptionGWh,
                            isKMU: viewModel.isKMU,
                            resultMessage: viewModel.statusMessage
                        )
                    }) {
                        HStack {
                            Spacer()
                            Label("Bericht generieren", systemImage: "doc.text.fill")
                                .bold()
                            Spacer()
                        }
                    }
                    
                    // Der Teilen-Button erscheint erst, wenn das PDF fertig generiert wurde
                    if let pdfUrl = generatedPDFUrl {
                        ShareLink(item: pdfUrl) {
                            HStack {
                                Spacer()
                                Label("PDF Teilen / Speichern", systemImage: "square.and.arrow.up")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                    }
                }
            }
            .navigationTitle("Compliance Check")
            // Wenn der Nutzer die Werte ändert, setzen wir das alte PDF zurück
            .onChange(of: viewModel.annualConsumptionGWh) { _, _ in generatedPDFUrl = nil }
            .onChange(of: viewModel.isKMU) { _, _ in generatedPDFUrl = nil }
        }
    }
}