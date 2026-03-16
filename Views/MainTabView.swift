import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ComplianceView()
                .tabItem { Label("Gesetze", systemImage: "doc.text.magnifyingglass") }
            Text("Abwärme Analyse (In Arbeit)")
                .tabItem { Label("Abwärme", systemImage: "thermometer.sun") }
            Text("PEF Katalog (In Arbeit)")
                .tabItem { Label("Faktoren", systemImage: "leaf") }
            Text("Multi-Site Audit (In Arbeit)")
                .tabItem { Label("Standorte", systemImage: "network") }
        }
    }
}
