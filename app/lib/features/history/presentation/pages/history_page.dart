import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/datasources/local/history_local_datasource.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';
import '../controllers/history_controller.dart';
import '../state/history_state.dart';
import '../widgets/history_tile.dart';

/// Tela de Histórico (F07): leituras agrupadas por dia, deslizar para apagar
/// e "Desfazer" no aviso de baixo.
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, this.repository, this.clock});

  /// Permite trocar o repositório e o relógio nos testes.
  final HistoryRepository? repository;
  final DateTime Function()? clock;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryController _controller = HistoryController(
    widget.repository ?? HistoryRepositoryImpl(HistoryLocalDataSource()),
    clock: widget.clock,
  );

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDismissed(HistoryEntry entry) async {
    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    final removed = await _controller.remove(entry);
    if (!mounted) return;

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Text(
          removed
              ? '${entry.productName} apagado'
              : 'Não foi possível apagar. Tente de novo.',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        action: removed
            ? SnackBarAction(
                label: 'Desfazer',
                textColor: AppColors.brandStrong,
                onPressed: () => _controller.undoRemove(entry),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightBackground,
          surfaceTintColor: Colors.transparent,
          foregroundColor: AppColors.lightText,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleSpacing: 0,
          title: const Text(
            'Histórico',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.lightText,
            ),
          ),
        ),
        body: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final state = _controller.state;
            return switch (state.status) {
              HistoryStatus.loading => const Center(
                child: CircularProgressIndicator(color: AppColors.brandStrong),
              ),
              HistoryStatus.failure => _Message(
                icon: Icons.error_outline,
                title: 'Não foi possível carregar o histórico.',
                actionLabel: 'Tentar de novo',
                onAction: _controller.load,
              ),
              HistoryStatus.ready when state.isEmpty => const _Message(
                icon: Icons.history,
                title: 'Nenhuma leitura ainda',
                subtitle: 'Os produtos que você escanear aparecem aqui.',
              ),
              HistoryStatus.ready => _buildList(_controller.groups),
            };
          },
        ),
      ),
    );
  }

  Widget _buildList(List<HistoryGroup> groups) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        const Text(
          'Guardado só neste aparelho. Deslize para apagar.',
          style: AppTextStyles.sectionSubtitle,
        ),
        for (final group in groups) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              group.label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.lightTextSecondary,
              ),
            ),
          ),
          for (final entry in group.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Dismissible(
                key: ValueKey('history-${entry.id}'),
                direction: DismissDirection.endToStart,
                background: const DeleteSwipeBackground(),
                onDismissed: (_) => _onDismissed(entry),
                child: HistoryTile(entry: entry),
              ),
            ),
        ],
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: AppColors.lightTextSecondary),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.sectionTitle,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.sectionSubtitle,
              ),
            ],
            if (actionLabel != null) ...[
              const SizedBox(height: 12),
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
