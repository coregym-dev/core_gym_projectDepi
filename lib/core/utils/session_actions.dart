import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/utils/app_dialogs.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';


class SessionActions {
  const SessionActions._();

  static Future<void> logout(BuildContext context) async {
    final confirmed = await AppDialogs.confirm(
      context,
      title: 'Log Out',
      message: 'Are you sure you want to log out? Your local session will be cleared.',
      confirmLabel: 'Log Out',
      isDestructive: true,
    );

    if (!confirmed || !context.mounted) return;

    // AppState.instance.logout();
    AppSnackbars.showSuccess(context, 'Logged out successfully');

    if (Navigator.canPop(context)) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}
