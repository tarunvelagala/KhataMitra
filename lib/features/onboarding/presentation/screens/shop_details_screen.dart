import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/onboarding_providers.dart';
import '../widgets/step_indicator.dart';

// ── File-private layout constants ──────────────────────────────────────────
abstract final class _Dims {
  // Scroll area padding
  static const double scrollPadH   = 24;
  static const double scrollPadTop = 8;
  static const double scrollPadBot = 16;

  // Bottom CTA bar padding
  static const double ctaPadTop = 12;
  static const double ctaPadBot = 24;

  // Header icon container
  static const double iconContainerPad    = 16;
  static const double iconContainerRadius = AppDimensions.radiusMedium;
  static const double iconContainerAlpha  = 0.08;
  static const double iconSize            = 40;

  // Spacing
  static const double spaceAfterIcon       = 20;
  static const double spaceAfterSubtitle   = 8;
  static const double spaceBeforeForm      = 32;
  static const double spaceAfterTextField  = 24;
  static const double spaceAfterGridLabel  = 12;

  // Business type grid
  static const int    gridColumns     = 2;
  static const double gridSpacing     = 12;
  static const double gridAspectRatio = 2.6;

  // Business type card
  static const double cardPad    = 12;
  static const double cardRadius = AppDimensions.radiusSmall;

  // Card border widths
  static const double cardBorderSelected   = AppDimensions.borderFocused;
  static const double cardBorderUnselected = AppDimensions.borderDefault;

  // Card shadow
  static const double shadowAlpha   = 0.04;
  static const double shadowBlur    = 8;
  static const double shadowOffsetY = 2;

  // Selection animation
  static const int animationMs = 200;
}

class ShopDetailsScreen extends ConsumerStatefulWidget {
  const ShopDetailsScreen({super.key});

  @override
  ConsumerState<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends ConsumerState<ShopDetailsScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: ref.read(shopDetailsProvider).name,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shopDetails = ref.watch(shopDetailsProvider);
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Back navigation ──────────────────────────────────────
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),

            // ── Scrollable content ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  _Dims.scrollPadH,
                  _Dims.scrollPadTop,
                  _Dims.scrollPadH,
                  _Dims.scrollPadBot,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon container + step + titles centered
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(_Dims.iconContainerPad),
                            decoration: BoxDecoration(
                              color: cs.primary.withValues(alpha: _Dims.iconContainerAlpha),
                              borderRadius: BorderRadius.circular(_Dims.iconContainerRadius),
                            ),
                            child: Icon(Icons.storefront_outlined, size: _Dims.iconSize, color: cs.primary),
                          ),
                          const SizedBox(height: _Dims.spaceAfterIcon),
                          const OnboardingStepIndicator(current: 3, total: 4),
                          const SizedBox(height: _Dims.spaceAfterSubtitle),
                          Text(l10n.shopScreenTitle, style: tt.headlineMedium, textAlign: TextAlign.center),
                          const SizedBox(height: _Dims.spaceAfterSubtitle),
                          Text(
                            l10n.shopScreenSubtitle,
                            style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: _Dims.spaceBeforeForm),

                    // Shop / business name field
                    TextField(
                      key: const ValueKey('tf_shop_name'),
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      onChanged: ref.read(shopDetailsProvider.notifier).setName,
                      decoration: InputDecoration(
                        labelText: l10n.shopNameLabel,
                        hintText: l10n.shopNameHint,
                        prefixIcon: const Icon(Icons.storefront_outlined),
                      ),
                    ),
                    const SizedBox(height: _Dims.spaceAfterTextField),

                    // Business type grid
                    Text(l10n.shopBusinessTypeLabel, style: tt.titleSmall),
                    const SizedBox(height: _Dims.spaceAfterGridLabel),
                    GridView.count(
                      crossAxisCount: _Dims.gridColumns,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: _Dims.gridSpacing,
                      crossAxisSpacing: _Dims.gridSpacing,
                      childAspectRatio: _Dims.gridAspectRatio,
                      children: BusinessType.values
                          .map((type) => _BusinessTypeCard(
                                type: type,
                                label: type.localizedLabel(l10n),
                                isSelected: shopDetails.businessType == type,
                                onTap: () => ref
                                    .read(shopDetailsProvider.notifier)
                                    .setBusinessType(type),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom CTA ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(
                _Dims.scrollPadH,
                _Dims.ctaPadTop,
                _Dims.scrollPadH,
                _Dims.ctaPadBot,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    cs.surface.withValues(alpha: 0),
                    cs.surface,
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      key: const ValueKey('btn_shop_next'),
                      onPressed: shopDetails.isValid
                          ? () => context.push('/onboarding/permissions')
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(l10n.onboardingNext),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Business type card ────────────────────────────────────────────────────────

class _BusinessTypeCard extends StatelessWidget {
  const _BusinessTypeCard({
    required this.type,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final BusinessType type;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: _Dims.animationMs),
        padding: const EdgeInsets.all(_Dims.cardPad),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(_Dims.cardRadius),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
            width: isSelected ? _Dims.cardBorderSelected : _Dims.cardBorderUnselected,
          ),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: _Dims.shadowAlpha),
              blurRadius: _Dims.shadowBlur,
              offset: const Offset(0, _Dims.shadowOffsetY),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              type.icon,
              color: isSelected ? cs.primary : cs.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: tt.bodySmall?.copyWith(
                  color: isSelected ? cs.primary : cs.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: cs.primary, size: 16),
          ],
        ),
      ),
    );
  }
}
