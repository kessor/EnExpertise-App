import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ComplianceView()
                .tabItem { Label("Gesetze", systemImage: "doc.text.magnifyingglass") }
            
            WasteHeatView()
                .tabItem { Label("Abwärme", systemImage: "flame") }
                
            Text("PEF Katalog (In Arbeit)")
                .tabItem { Label("Faktoren", systemImage: "leaf") }
                
            Text("Multi-Site Audit (In Arbeit)")
                .tabItem { Label("Standorte", systemImage: "building.2") }
        }
        .accentColor(.green)
    }
}