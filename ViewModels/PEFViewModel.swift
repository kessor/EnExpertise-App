import Foundation
import Observation

@Observable
class PEFViewModel {
    var searchText = ""
    var allEntries = PEFData.entries
    
    // Filtert die Liste basierend auf der Sucheingabe
    var filteredEntries: [PEFEntry] {
        if searchText.isEmpty {
            return allEntries
        } else {
            return allEntries.filter { 
                $0.name.localizedCaseInsensitiveContains(searchText) || 
                $0.category.localizedCaseInsensitiveContains(searchText) 
            }
        }
    }
}