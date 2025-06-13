# Vehicle-Position-Tool (MTA:SA)

Dieses Tool dient dazu, **exakte Fahrzeug-Positionen** für jedes Fahrzeugmodell in MTA:SA manuell zu bestimmen und automatisch zu speichern.

## 🔧 Funktionen

- Manuelle **Verschiebung eines gelben Preview-Markierungspunktes** entlang der X-, Y- und Z-Achse direkt am Fahrzeug.
- Speichern von **vier präzisen Positionen** (vorne links/rechts, hinten links/rechts) je Modell.
- Automatische serverseitige Speicherung der Offsets in einer lesbaren Datei.
- **Live-Feedback**, wenn alle vier Positionen vollständig gespeichert sind.
- Optional: Modellnummern-Abruf bei Einstieg zur Überprüfung, ob Offsets bereits vorhanden sind.
- Unterstützt **komplett symmetrisches Arbeiten** durch präzise Darstellung.

## 🕹️ Steuerung (Client)

| Taste | Aktion |
|-------|--------|
| `A` / `D` | Marker nach links/rechts verschieben (X-Achse) |
| `W` / `S` | Marker nach vorn/zurück verschieben (Y-Achse) |
| `Z` / `K` | Marker nach oben/unten verschieben (Z-Achse) |
| `3` | Speichert aktuelle Markerposition als „vorne links“ |
| `4` | Speichert aktuelle Markerposition als „vorne rechts“ |
| `5` | Speichert aktuelle Markerposition als „hinten links“ |
| `6` | Speichert aktuelle Markerposition als „hinten rechts“ |
| `1` | Spawnt das nächste Fahrzeugmodell (400–611) zum Vermessen (optional) | (veh_spawn_c und veh_spawn_s)

## 💾 Speicherung

- Sobald **alle vier Positionen** für ein Modell eingetragen wurden, wird folgender Eintrag in `blinkeroffsets.txt` geschrieben:

Modell: 496
vorne links: -0.800, 2.200, -0.100
vorne rechts: 0.800, 2.200, -0.100
hinten links: -0.800, -2.150, -0.050
hinten rechts: 0.800, -2.150, -0.050

- Bereits gespeicherte Modelle werden beim Einstieg erkannt (optional). (Dafür wird check_client und check_server gebraucht)

## 📦 Installation

1. Lege das Resource-Verzeichnis z. B. als `blinkeroffsettool` an.
2. Platziere `client.lua`, `server.lua`, 'check_client.lua', 'check_server.lua', 'veh_spawn_c.lua', 'veh_spawn_s.lua und `meta.xml` dort.
3. Starte die Resource mit `/start blinkertable` oder im Autostart.
4. Steig in ein Fahrzeug, Taste '1' zum Fahrzeug spawnen und justiere, speichere – fertig!

## 🧠 Hinweis

Dieses Tool ist für Entwickler gedacht, die zum Beispiel ein Blinkerscript mit **realistischen und exakten Positionen pro Fahrzeugmodell** umsetzen möchten.  
Für eine bessere Übersicht empfiehlt sich, die Einträge später in eine Lua-Tabelle zu exportieren.

## 📣 Credits

Entwickelt in Zusammenarbeit mit [ERL Reallife] – Idee, Anwendungszweck und Konzept von Eurosat

