# EnExpertise - Professional Energy Toolbox
**Status: Phase 1 (MVP)**

## 1. Vision
Professionelles Werkzeug für Energieberater und Auditoren. Lokal, datenschutzkonform, präzise.

## 2. Technische Spezifikationen (Specs)
- **Framework:** SwiftUI (iOS 17+)
- **Architektur:** MVVM mit `@Observable`
- **Module:**
    1. **PEF-Rechner:** Primärenergiefaktoren gemäß GEG Anlage 4.
    2. **Abwärmerechner:** Wirtschaftlichkeit inkl. Amortisation und Zinsrechnung.
    3. **Compliance-Checker:** Entscheidungsbaum für EnEfG und EDL-G Schwellenwerte.
    4. **Multi-Site:** 90%-Regel und Stichprobenberechnung ($\sqrt{n}$).

## 3. Datenbasis & Formeln
### Primärenergiefaktoren (PEF):
- Heizöl/Erdgas: 1,1 | Biogas: 1,1 | Holz: 0,2 | Netzstrom: 1,8

### Abwärme-Logik:
- Jährliche Ersparnis = Nutzbare Abwärme (kWh) * Energiepreis (€)
- Max. Investition = Ersparnis * Rentenbarwertfaktor (RVF)

### Compliance-Schwellen:
- Auditpflicht (EDL-G): Nicht-KMU.
- EnEfG (EnMS/UMS): Ab 7,5 GWh/a Gesamtenergieverbrauch.
- Abwärme-Plattform: Ab 2,5 GWh/a Gesamtenergieverbrauch.
