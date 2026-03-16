import SwiftUI

struct MultiSiteView: View {
    @State private var viewModel = MultiSiteViewModel()
    
    @State private var newSiteName: String = ""
    @State private var newSiteConsumption: Double? = nil
    @State private var isComparable: Bool = false
    
    @State private var generatedPDFUrl: URL? // NEU: Für das PDF
    
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
                                        Text("Ausgenommen").font(.caption).foregroundColor(.green)
                                    }
                                }
                            }
                        }.onDelete(perform: deleteSite)
                    }
                    
                    // NEU: PDF Export Sektion
                    Section("Reporting") {
                        Button(action: {
                            let poolIds = viewModel.auditPoolSites.map { $0.id }
                            generatedPDFUrl = ReportGenerator.generateMultiSiteReport(
                                totalConsumption: viewModel.totalConsumption,
                                allSites: viewModel.sites,
                                poolIds: poolIds
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
            }
            .navigationTitle("Multi-Site Audit")
            .onChange(of: viewModel.sites.count) { _, _ in generatedPDFUrl = nil }
        }
    }
    
    private func addSite() {
        guard let consumption = newSiteConsumption, !newSiteName.isEmpty else { return }
        let newSite = AuditSite(name: newSiteName, consumptionKWh: consumption, isComparable: isComparable)
        viewModel.sites.append(newSite)
        
        newSiteName = ""
        newSiteConsumption = nil
        isComparable = false
    }
    
    // NEU: Funktion zum Löschen von versehentlich falschen Einträgen
    private func deleteSite(at offsets: IndexSet) {
        // Da die Liste sortiert angezeigt wird, müssen wir den echten Index finden
        let sortedSites = viewModel.sites.sorted(by: { $0.consumptionKWh > $1.consumptionKWh })
        for index in offsets {
            let siteToDelete = sortedSites[index]
            if let realIndex = viewModel.sites.firstIndex(where: { $0.id == siteToDelete.id }) {
                viewModel.sites.remove(at: realIndex)
            }
        }
    }
}