import 'package:flutter/material.dart';
import 'package:task_management/shared/buttons/app_outline_button.dart';
import 'package:task_management/shared/buttons/app_primary_button.dart';

enum AppAlertType { info, success, warning, error }

class AppAlert {
  const AppAlert._();

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? message,
    String confirmText = 'OK',
    String? cancelText,
    AppAlertType type = AppAlertType.info,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final alertTheme = _alertTheme(type);

    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          actionsPadding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          icon: Icon(alertTheme.$1, color: alertTheme.$2, size: 32),
          title: Text(title),
          content: message == null
              ? null
              : Text(message, style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            if (cancelText != null)
              AppOutlineButton(
                label: cancelText,
                onPressed: () {
                  onCancel?.call();
                  Navigator.of(dialogContext).pop(false);
                },
              ),
            AppPrimaryButton(
              label: confirmText,
              onPressed: () {
                onConfirm?.call();
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static (IconData, Color) _alertTheme(AppAlertType type) {
    switch (type) {
      case AppAlertType.success:
        return (Icons.check_circle_rounded, Colors.green);
      case AppAlertType.warning:
        return (Icons.warning_rounded, Colors.orange);
      case AppAlertType.error:
        return (Icons.error_rounded, Colors.red);
      case AppAlertType.info:
      default:
        return (Icons.info_rounded, Colors.blue);
    }
  }
}
