import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ComplianceView()
                .tabItem { Label("Gesetze", systemImage: "doc.text.magnifyingglass") }
            
            WasteHeatView()
                .tabItem { Label("Abwärme", systemImage: "flame") }
                
            PEFView()
                .tabItem { Label("Faktoren", systemImage: "leaf") }
                
            MultiSiteView()
                .tabItem { Label("Standorte", systemImage: "building.2") }
        }
        .accentColor(.green)
    }
}