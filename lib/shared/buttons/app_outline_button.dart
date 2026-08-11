import 'package:flutter/material.dart';

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.child,
    this.width,
    this.height = 52,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.isLoading = false,
    this.expanded = false,
  }) : assert(
         label != null || child != null || isLoading,
         'Provide either a label, child, or loading state.',
       );

  final VoidCallback? onPressed;
  final String? label;
  final IconData? icon;
  final Widget? child;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final resolvedBorderColor = borderColor ?? scheme.primary;
    final resolvedForeground = foregroundColor ?? scheme.primary;

    final buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(resolvedForeground),
            ),
          )
        : child ??
              _buildTextContent(
                context: context,
                icon: icon,
                label: label,
                foregroundColor: resolvedForeground,
                textStyle: textStyle,
              );

    return SizedBox(
      width: expanded ? double.infinity : width,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: resolvedForeground,
          backgroundColor: backgroundColor,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          minimumSize: Size.zero,
          fixedSize: expanded
              ? Size(double.infinity, height)
              : width == null
              ? Size.fromHeight(height)
              : Size(width!, height),
          side: BorderSide(color: resolvedBorderColor),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          textStyle: textStyle,
        ),
        child: buttonChild,
      ),
    );
  }

  Widget _buildTextContent({
    required BuildContext context,
    required IconData? icon,
    required String? label,
    required Color foregroundColor,
    required TextStyle? textStyle,
  }) {
    final textWidget = Text(
      label ?? '',
      style:
          textStyle ??
          Theme.of(context).textTheme.labelLarge?.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w600,
          ),
    );

    if (icon == null) {
      return textWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: foregroundColor, size: 18),
        const SizedBox(width: 8),
        textWidget,
      ],
    );
  }
}
