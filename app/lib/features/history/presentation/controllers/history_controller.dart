import 'package:flutter/foundation.dart';

import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';
import '../state/history_state.dart';

/// Regras da tela de Histórico (F07): listar, apagar e desfazer.
class HistoryController extends ChangeNotifier {
  HistoryController(this._repository, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final HistoryRepository _repository;
  final DateTime Function() _clock;

  HistoryState _state = const HistoryState();
  HistoryState get state => _state;

  List<HistoryGroup> get groups => groupHistoryByDay(_state.entries, _clock());

  bool _disposed = false;

  Future<void> load() async {
    _emit(_state.copyWith(status: HistoryStatus.loading));
    try {
      final entries = await _repository.getEntries();
      _emit(HistoryState(status: HistoryStatus.ready, entries: entries));
    } catch (_) {
      _emit(_state.copyWith(status: HistoryStatus.failure));
    }
  }

  /// Tira o item da lista na hora (o Dismissible exige isso) e apaga no banco.
  /// Se o banco falhar, o item volta e o retorno é `false`.
  Future<bool> remove(HistoryEntry entry) async {
    final previous = _state.entries;
    _emit(
      _state.copyWith(
        entries: previous.where((item) => item.id != entry.id).toList(),
      ),
    );

    try {
      await _repository.deleteEntry(entry.id!);
      return true;
    } catch (_) {
      _emit(_state.copyWith(entries: previous));
      return false;
    }
  }

  /// "Desfazer": grava de novo com o mesmo id e devolve à posição certa.
  Future<void> undoRemove(HistoryEntry entry) async {
    try {
      await _repository.restoreEntry(entry);
    } catch (_) {
      return;
    }

    final entries = [
      ..._state.entries.where((item) => item.id != entry.id),
      entry,
    ]..sort(_newestFirst);
    _emit(_state.copyWith(entries: entries));
  }

  static int _newestFirst(HistoryEntry a, HistoryEntry b) {
    final byDate = b.scannedAt.compareTo(a.scannedAt);
    return byDate != 0 ? byDate : (b.id ?? 0).compareTo(a.id ?? 0);
  }

  void _emit(HistoryState state) {
    if (_disposed) return;
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
