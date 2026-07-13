import '../models/models.dart';

/// Statikus katalógustartalom: segédeszközök és edukációs anyagok.
/// Ezek szerkesztői tartalmak, nem felhasználói adatok, ezért nincsenek
/// az adatbázisban — a személyes adatok (gyógyszerek, naplók stb.) az
/// AppRepositories-en és a helyi adatbázison keresztül érhetők el.
class MockData {
  MockData._();

  static final assistiveDevices = [
    const AssistiveDevice(
      id: 'device-cane',
      name: 'Négylábú járóbot',
      category: AssistiveDeviceCategory.gait,
      description: 'Szélesebb alátámasztási felületet adó bot, amely javítja az egyensúlyt járás közben.',
      whenUseful: 'Bizonytalan járás vagy gyakori egyensúlyvesztés esetén.',
      recommendedFor: 'Enyhe-közepes egyensúlyzavarral élő betegek.',
      usageInstructions: 'A bot magasságát úgy állítsd be, hogy csuklóhajlatig érjen álló helyzetben.',
      sourceReferences: ['Parkinson\'s Foundation — Mobility Aids Guide'],
    ),
    const AssistiveDevice(
      id: 'device-cueing',
      name: 'Ritmikus jelzőeszköz (cueing)',
      category: AssistiveDeviceCategory.gait,
      description: 'Hallható vagy látható ütemjelzés, amely segít a megtorpanás (freezing) leküzdésében.',
      whenUseful: 'Freezing of gait epizódok esetén, különösen ajtóátjárókban, fordulásnál.',
      recommendedFor: 'Freezing-gel érintett betegek.',
      usageInstructions: 'A ritmust az első lépés előtt indítsd el, és tartsd a lépésekkel szinkronban.',
      sourceReferences: ['European Physiotherapy Guideline for Parkinson\'s Disease'],
    ),
    const AssistiveDevice(
      id: 'device-weighted-cutlery',
      name: 'Súlyozott evőeszköz',
      category: AssistiveDeviceCategory.eating,
      description: 'A megnövelt súly csökkenti a kéztremor étkezés közbeni hatását.',
      whenUseful: 'Kéztremor miatt nehézkes önálló étkezés esetén.',
      recommendedFor: 'Közepes-erős kéztremorral élő betegek.',
      usageInstructions: 'Normál evőeszközként használható, nem igényel különleges technikát.',
      sourceReferences: ['Occupational Therapy Practice Guidelines'],
    ),
  ];

  static final educationContents = [
    const EducationContent(
      id: 'edu-fog',
      title: 'Mi az a freezing of gait, és mit tehetek ellene?',
      category: 'Járás',
      summary: 'Rövid, közérthető áttekintés a hirtelen megtorpanásról és gyakorlati stratégiákról.',
      sourceReferences: ['Parkinson\'s Foundation'],
    ),
    const EducationContent(
      id: 'edu-swallow',
      title: 'Biztonságos nyelés — mikor forduljak logopédushoz?',
      category: 'Nyelés',
      summary: 'Figyelmeztető jelek és mikor érdemes szakembert bevonni a nyelészavar kezelésébe.',
      sourceReferences: ['European Parkinson\'s Disease Association'],
    ),
  ];
}
