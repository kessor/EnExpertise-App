import SwiftUI

struct PEFView: View {
    @State private var viewModel = PEFViewModel()
    
    // NEU: @AppStorage speichert diese Eingabe automatisch und dauerhaft auf dem Gerät
    @AppStorage("pefInputKWh") private var inputKWh: Double = 1000.0
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Schnellrechner")) {
                    HStack {
                        Text("Endenergie (kWh)")
                        Spacer()
                        TextField("z. B. 1000", value: $inputKWh, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.blue)
                    }
                }
                
                Section(header: Text("Katalog (PEF & CO₂-Faktor)")) {
                    ForEach(viewModel.filteredEntries) { entry in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(entry.name).font(.headline)
                                    Text(entry.category).font(.caption).foregroundColor(.secondary)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("PEF: \(entry.factor, specifier: "%.1f")").bold()
                                    Text("CO₂: \(entry.co2Factor, specifier: "%.3f") kg")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            // Live-Berechnung für PE und CO2
                            HStack {
                                Text("= \(inputKWh * entry.factor, specifier: "%.0f") kWh PE")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                
                                Spacer()
                                
                                Text("= \(inputKWh * entry.co2Factor, specifier: "%.0f") kg CO₂")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            }
                            .padding(.top, 4)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("PEF & CO₂ Rechner")
            .searchable(text: $viewModel.searchText, prompt: "Suchen (z. B. Holz, Strom)")
        }
    }
}