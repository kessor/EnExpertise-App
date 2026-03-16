import SwiftUI

struct WasteHeatView: View {
    @State private var viewModel = WasteHeatViewModel()
    @State private var generatedPDFUrl: URL? // Speichert das fertige PDF
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Anlagendaten")) {
                    HStack {
                        Text("Nennleistung (kW)")
                        Spacer()
                        TextField("kW", value: $viewModel.calculation.nennleistungKW, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.blue)
                    }
                }
                
                Section(header: Text("Betriebszeiten")) {
                    Stepper("Stunden pro Tag: \(Int(viewModel.calculation.betriebsStundenProTag))", 
                            value: $viewModel.calculation.betriebsStundenProTag, in: 1...24)
                    Stepper("Tage pro Woche: \(Int(viewModel.calculation.betriebsTageProWoche))", 
                            value: $viewModel.calculation.betriebsTageProWoche, in: 1...7)
                    Stepper("Wochen pro Jahr: \(Int(viewModel.calculation.betriebsWochenProJahr))", 
                            value: $viewModel.calculation.betriebsWochenProJahr, in: 1...52)
                }
                
                Section(header: Text("Kostenansätze")) {
                    HStack {
                        Text("Brennstoffpreis (€/kWh)")
                        Spacer()
                        TextField("€", value: $viewModel.calculation.brennstoffpreis, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Ergebnis (Wirtschaftlichkeit)")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Jährliche Ersparnis:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(viewModel.formattedErsparnis)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.green)
                        
                        Divider()
                        
                        Text("Max. wirtschaftliche Investition:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(viewModel.wirtschaftlicheInvestition)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 5)
                }
                
                // NEU: PDF Export Sektion
                Section("Reporting") {
                    Button(action: {
                        generatedPDFUrl = ReportGenerator.generateWasteHeatReport(
                            nennleistung: viewModel.calculation.nennleistungKW,
                            ersparnis: viewModel.formattedErsparnis,
                            investition: viewModel.wirtschaftlicheInvestition
                        )
                    }) {
                        HStack {
                            Spacer()
                            Label("Bericht generieren", systemImage: "doc.text.fill")
                                .bold()
                            Spacer()
                        }
                    }
                    
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
            .navigationTitle("Abwärmerechner")
            // Setzt das PDF zurück, wenn sich Eingaben ändern
            .onChange(of: viewModel.calculation.nennleistungKW) { _, _ in generatedPDFUrl = nil }
        }
    }
}