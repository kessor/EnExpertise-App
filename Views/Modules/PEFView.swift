import SwiftUI

struct PEFView: View {
    @State private var viewModel = PEFViewModel()
    @State private var inputKWh: Double? = nil
    
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
                
                Section(header: Text("Katalog (Anlage 4 GEG)")) {
                    ForEach(viewModel.filteredEntries) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(entry.name).font(.headline)
                                Text(entry.category).font(.caption).foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("PEF: \(entry.factor, specifier: "%.1f")")
                                    .bold()
                                
                                // Wenn der Nutzer oben einen Wert eingibt, berechnen wir sofort die Primärenergie
                                if let input = inputKWh {
                                    Text("= \(input * entry.factor, specifier: "%.1f") kWh PE")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("PEF Katalog")
            .searchable(text: $viewModel.searchText, prompt: "Suchen (z. B. Holz, Strom)")
        }
    }
}