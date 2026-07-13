# Parkinson Társ (parkinson_companion)

Parkinson-kórral élő betegek, hozzátartozóik és gondozóik mobil- és
okosóra-alkalmazása: gyógyszeremlékeztető, fehérjeablak-kezelés,
gyógyszernapló, tünet-/motoros napló, segédeszköz-tár és edukációs tartalom.

**Klinikai felelősségi kizárás:** az alkalmazás nem helyettesíti az orvosi
döntést, diagnózist vagy terápiás javaslatot. A gyógyszerelést és az
étrendi szabályokat mindig egyeztetni kell a kezelőorvossal vagy
gyógyszerésszel.

## Állapot

Ez a jelenlegi kód egy **UI-vázlat (skeleton)**: statikus/mock adatokkal
működő képernyők, akadálymentes (WCAG 2.2 AA-orientált) elrendezéssel és a
tervezett adatmodellel — backend, perzisztencia és valós helyi/push
értesítési logika nélkül. A teljes termékspecifikációt lásd a fejlesztői
briefben.

### Amit ez a vázlat tartalmaz

- `lib/models/` — a brief §5 adatmodell-entitásai (User, PatientProfile,
  Medication, MedicationSchedule, MedicationIntakeLog,
  ProteinRestrictionWindow, ConsentGrant, SymptomLog stb.)
- `lib/data/mock_data.dart` — mintaadatok a képernyők demonstrálásához
- `lib/screens/` — a brief §4-ben felsorolt 11 képernyő
- `lib/theme/` — akadálymentes, nagy célterületű, magas kontrasztú téma,
  rendszerszintű szövegméretezés-támogatással

### Amit ez a vázlat szándékosan NEM tartalmaz még

- Valódi helyi/perzisztens adattárolás és backend-szinkronizáció
- Tényleges helyi/push értesítés-ütemezés (iOS Critical Alerts, Android
  exact alarm, eszkalációs állapotgép végrehajtása)
- Hitelesítés és jogosultságkezelés (RBAC), audit log tényleges írása
- Natív Wear OS / Apple Watch cél (a 11. képernyő csak telefonos előnézet)

## Fejlesztői parancsok

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Getting Started (Flutter alapok)

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter online documentation](https://docs.flutter.dev/)
