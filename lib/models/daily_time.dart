/// Egy napon belüli időpont (óra:perc), függetlenül a naptári dátumtól.
/// Gyógyszerezési ütemtervekhez és csendes időszak beállításához használt.
class DailyTime {
  final int hour;
  final int minute;

  const DailyTime(this.hour, this.minute);

  String get label =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  DateTime onDate(DateTime date) =>
      DateTime(date.year, date.month, date.day, hour, minute);

  @override
  String toString() => label;
}
