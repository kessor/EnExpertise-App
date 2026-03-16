import SwiftUI

struct MultiSiteView: View {
    @State private var viewModel = MultiSiteViewModel()
    
    // Temporäre States für neue Eingaben
    @State private var newSiteName: String = ""
    @State private var newSiteConsumption: Double? = nil
    @State private var isComparable: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Neuen Standort erfassen")) {
                    TextField("Name (z.B. Filiale Nord)", text: $newSiteName)
                    TextField("Verbrauch (kWh)", value: $newSiteConsumption, format: .number)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.blue)
                    Toggle("Ist vergleichbarer Standort?", isOn: $isComparable)
                    
                    Button(action: addSite) {
                        Text("Standort hinzufügen")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 8)
                    .background(Color.green)
                    .cornerRadius(8)
                    .disabled(newSiteName.isEmpty || newSiteConsumption == nil)
                }
                
                if !viewModel.sites.isEmpty {
                    Section(header: Text("Gesamtübersicht")) {
                        HStack {
                            Text("Gesamtverbrauch:")
                            Spacer()
                            Text("\(viewModel.totalConsumption, specifier: "%.0f") kWh")
                                .bold()
                        }
                    }
                    
                    Section(header: Text("Audit-Pool (90%-Regel)")) {
                        let poolIds = viewModel.auditPoolSites.map { $0.id }
                        
                        ForEach(viewModel.sites.sorted(by: { $0.consumptionKWh > $1.consumptionKWh })) { site in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(site.name).font(.headline)
                                    if site.isComparable {
                                        Text("Vergleichbar").font(.caption).foregroundColor(.secondary)
                                    }
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("\(site.consumptionKWh, specifier: "%.0f") kWh")
                                    if poolIds.contains(site.id) {
                                        Text("Auditpflichtig").font(.caption).foregroundColor(.red)
                                    } else {
                                        Text("Ausgenommen (<10%)").font(.caption).foregroundColor(.green)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Multi-Site Audit")
        }
    }
    
    private func addSite() {
        guard let consumption = newSiteConsumption, !newSiteName.isEmpty else { return }
        let newSite = AuditSite(name: newSiteName, consumptionKWh: consumption, isComparable: isComparable)
        viewModel.sites.append(newSite)
        
        // Formular zurücksetzen
        newSiteName = ""
        newSiteConsumption = nil
        isComparable = false
    }
}