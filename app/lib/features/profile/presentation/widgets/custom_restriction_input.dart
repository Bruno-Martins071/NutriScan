import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/restriction_suggestion.dart';

class CustomRestrictionInput extends StatefulWidget {
  const CustomRestrictionInput({
    super.key,
    required this.onAdd,
    this.suggestionsFor,
  });

  final String? Function(String name) onAdd;
  final List<RestrictionSuggestion> Function(String query)? suggestionsFor;

  @override
  State<CustomRestrictionInput> createState() => _CustomRestrictionInputState();
}

class _CustomRestrictionInputState extends State<CustomRestrictionInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _error;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() => _add(_controller.text);

  void _add(String name) {
    final error = widget.onAdd(name);
    setState(() => _error = error);
    if (error == null) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _error != null;
    final isFocused = _focusNode.hasFocus;
    final query = _controller.text;
    final suggestions = widget.suggestionsFor?.call(query) ?? const [];

    final borderColor = hasError
        ? AppColors.dangerStrong
        : isFocused
        ? AppColors.brandStrong
        : AppColors.lightBorder;
    final fillColor = hasError
        ? AppColors.dangerSoft
        : isFocused
        ? AppColors.lightCard
        : AppColors.lightField;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.fromLTRB(16, 6, 6, 6),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: borderColor,
              width: isFocused || hasError ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: 2,
                  style: AppTextStyles.lightBody,
                  onChanged: (_) => setState(() => _error = null),
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Outra restrição, ex.: tartrazina',
                    hintMaxLines: 2,
                    hintStyle: AppTextStyles.lightBody.copyWith(
                      color: AppColors.lightTextMuted,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.lightText,
                  foregroundColor: AppColors.lightCard,
                  minimumSize: const Size(0, 44),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  textStyle: AppTextStyles.actionTitle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 10),
          Semantics(
            liveRegion: true,
            child: Row(
              children: [
                const Icon(
                  Icons.error_rounded,
                  size: 20,
                  color: AppColors.dangerStrong,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _error!,
                    style: AppTextStyles.sectionSubtitle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.dangerStrong,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (suggestions.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final suggestion in suggestions)
                _SuggestionChip(
                  name: suggestion.name,
                  matchedTerm: suggestion.matchedTermFor(query),
                  onTap: () => _add(suggestion.name),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip({
    required this.name,
    required this.matchedTerm,
    required this.onTap,
  });

  final String name;
  final String? matchedTerm;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showMatchedTerm = matchedTerm != null && matchedTerm != name;

    return Semantics(
      button: true,
      label: 'Adicionar $name',
      excludeSemantics: true,
      child: Material(
        color: AppColors.lightCard,
        shape: const StadiumBorder(
          side: BorderSide(color: AppColors.lightBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.brandSoft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: AppColors.brandStrong,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        text: name,
                        children: [
                          if (showMatchedTerm)
                            TextSpan(
                              text: ' · $matchedTerm',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextSecondary,
                              ),
                            ),
                        ],
                      ),
                      style: AppTextStyles.sectionSubtitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
