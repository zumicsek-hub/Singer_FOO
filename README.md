# Parkinson Társ (parkinson_companion)

Parkinson-kórral élő betegek, hozzátartozóik és gondozóik mobil- és
okosóra-alkalmazása: gyógyszeremlékeztető, fehérjeablak-kezelés,
gyógyszernapló, tünet-/motoros napló, segédeszköz-tár és edukációs tartalom.

**Klinikai felelősségi kizárás:** az alkalmazás nem helyettesíti az orvosi
döntést, diagnózist vagy terápiás javaslatot. A gyógyszerelést és az
étrendi szabályokat mindig egyeztetni kell a kezelőorvossal vagy
gyógyszerésszel.

## Állapot

Ez a jelenlegi kód egy **UI-vázlat valódi helyi perzisztenciával és valódi
helyi értesítés-ütemezéssel**: a képernyők akadálymentes (WCAG 2.2
AA-orientált) elrendezéssel és a tervezett adatmodellel dolgoznak, az adatok
egy helyi SQLite adatbázisban tárolódnak, a gyógyszeremlékeztetők pedig
tényleges, az operációs rendszer által kézbesített helyi értesítésként
vannak beütemezve — backend-szinkronizáció és valós gondozói push nélkül.
A teljes termékspecifikációt lásd a fejlesztői briefben.

**Fontos korlát:** ebben a fejlesztői környezetben nincs elérhető
fizikai eszköz vagy emulátor, ezért az értesítés-kézbesítés (hangzás,
műveletgombok, full-screen intent, Critical Alerts) és a diagramok tényleges
vizuális megjelenése csak forráskód-szinten lett ellenőrizve
(`flutter analyze` + `flutter test`), valós eszközön még nem lett
kipróbálva.

### Amit ez a vázlat tartalmaz

- `lib/models/` — a brief §5 adatmodell-entitásai (User, PatientProfile,
  Medication, MedicationSchedule, MedicationIntakeLog,
  ProteinRestrictionWindow, ConsentGrant, SymptomLog stb.)
- `lib/data/database/` — drift/SQLite séma, első indításkor lefutó
  seed-adatok (`seed.dart`) és a generált `app_database.g.dart`
- `lib/data/repository/` — reaktív (stream-alapú) repository-réteg a
  gyógyszerekhez, ütemtervekhez, bevételi naplókhoz, gondozói
  hozzájárulásokhoz és tünetnaplóhoz, plusz egyszeri (nem reaktív)
  lekérdezések az indításkori egyeztetéshez/ütemezéshez
- `lib/notifications/` — `NotificationService` (flutter_local_notifications
  + timezone): 1-3. eszkalációs szint valódi, OS-szintű helyi értesítésként
  való beütemezése (brief §3.2/§7), csendes időszak szerinti csatornaválasztás,
  „Bevettem"/„Később" műveletgombok előtér- és háttér-feldolgozással
  (`background_handler.dart`), Android pontos ébresztés / iOS Critical
  Alerts engedélykérés
- `lib/data/export/csv_export.dart` — a gyógyszernapló CSV riportjának
  előállítása (tiszta függvény, I/O nélkül); a Beállítások képernyő ebből
  épít fájlt és nyitja meg a natív megosztás-párbeszédet (`share_plus`) —
  brief §3.4 „exportálható riport" és §8 GDPR adathordozhatóság
- minden repository kapott egy `deleteAllForPatient` metódust
  (`AppRepositories.deleteAllPatientData` fogja össze) a Beállítások „Fiók
  és adatok törlése" GDPR-törléséhez
- `lib/data/mock_data.dart` — csak a statikus katalógustartalom (segédeszköz-
  és edukációs listák), amelyek nem felhasználói adatok
- `lib/screens/` — a brief §4-ben felsorolt 11 képernyő, a fenti
  repository- és értesítés-rétegre kötve, plusz egy „Gyógyszereim"
  lista-/szerkesztő képernyő (Beállításokból elérhető) meglévő gyógyszerek
  szerkesztéséhez és törléséhez (soft-delete: az előzmények megmaradnak)
- Tünet-/motoros napló idővonal-diagram (`lib/widgets/symptom_trend_chart.dart`,
  fl_chart): a mai tremor-súlyosság alakulása a visszaigazolt
  gyógyszerbevételek időpontjaival jelölve — a dózisidő és a motoros
  állapot közötti összefüggés megjelenítése (brief §3.7 célja). A
  diagramhoz szükséges adat-transzformáció tiszta, unit tesztelt
  függvényekben él (`lib/data/charts/symptom_chart_data.dart`)
- `lib/theme/` — akadálymentes, nagy célterületű, magas kontrasztú téma,
  rendszerszintű szövegméretezés-támogatással

### Amit ez a vázlat szándékosan NEM tartalmaz még

- Backend-szinkronizáció és többeszközös adatmegosztás
- Valódi gondozói push-értesítés (4. eszkalációs szint) — nincs
  backend/FCM-infrastruktúra a gondozó saját eszközének eléréséhez. Helyette
  az app előtérbe kerülésekor lefutó egyeztetés (`AppRepositories.
  reconcileMissedIntakes`) jelöli `escalatedToCaregiver`-nek a rég lejárt,
  visszaigazolatlan bejegyzéseket, ha van arra jogosult hozzátartozó — ez a
  Fázis 2/3 backend-munka (brief §9) része lesz.
- iOS Critical Alerts ténylegesen működő entitlement-je — ehhez Xcode-ban
  fel kell venni a capability-t és Apple jóváhagyása szükséges; a kódban a
  kérési/fallback-logika megvan (`requestIosCriticalAlerts`), de az
  entitlements-fájlt és a Runner Xcode-projekt-beállítást ebben a
  környezetben (nincs Xcode/macOS) nem lehetett biztonságosan szerkeszteni
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
