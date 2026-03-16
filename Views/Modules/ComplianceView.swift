import SwiftUI

struct ComplianceView: View {
    @State private var viewModel = ComplianceViewModel()
    
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
            }
            .navigationTitle("Compliance Check")
        }
    }
}
