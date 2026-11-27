import '../../domain/entities/history_entry.dart';

enum HistoryStatus { loading, ready, failure }

typedef HistoryGroup = ({String label, List<HistoryEntry> entries});

class HistoryState {
  const HistoryState({
    this.status = HistoryStatus.loading,
    this.entries = const [],
  });

  final HistoryStatus status;

  /// Da leitura mais recente para a mais antiga.
  final List<HistoryEntry> entries;

  bool get isEmpty => entries.isEmpty;

  HistoryState copyWith({HistoryStatus? status, List<HistoryEntry>? entries}) {
    return HistoryState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
    );
  }
}

/// Junta as leituras por dia, mantendo a ordem recebida.
List<HistoryGroup> groupHistoryByDay(
  List<HistoryEntry> entries,
  DateTime now,
) {
  final groups = <HistoryGroup>[];
  DateTime? currentDay;

  for (final entry in entries) {
    final day = _dateOnly(entry.scannedAt.toLocal());
    if (day != currentDay) {
      currentDay = day;
      groups.add((label: historyDayLabel(day, now), entries: <HistoryEntry>[]));
    }
    groups.last.entries.add(entry);
  }
  return groups;
}

/// "Hoje", "Ontem", "Sáb, 26 set" ou "Qua, 31 dez 2025" (outro ano).
String historyDayLabel(DateTime date, DateTime now) {
  final day = _dateOnly(date);
  final today = _dateOnly(now);
  // Datas em UTC só para contar dias: assim o horário de verão não interfere.
  final daysAgo = DateTime.utc(today.year, today.month, today.day)
      .difference(DateTime.utc(day.year, day.month, day.day))
      .inDays;

  if (daysAgo == 0) return 'Hoje';
  if (daysAgo == 1) return 'Ontem';

  const weekdays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  const months = [
    'jan',
    'fev',
    'mar',
    'abr',
    'mai',
    'jun',
    'jul',
    'ago',
    'set',
    'out',
    'nov',
    'dez',
  ];

  final label =
      '${weekdays[day.weekday - 1]}, ${day.day} ${months[day.month - 1]}';
  return day.year == today.year ? label : '$label ${day.year}';
}

/// "Camil · 09:41" (ou só a hora quando não há marca).
String historySubtitle(HistoryEntry entry) {
  final time = entry.scannedAt.toLocal();
  final hh = time.hour.toString().padLeft(2, '0');
  final mm = time.minute.toString().padLeft(2, '0');
  final brand = entry.brand.trim();
  return brand.isEmpty ? '$hh:$mm' : '$brand · $hh:$mm';
}

DateTime _dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);
