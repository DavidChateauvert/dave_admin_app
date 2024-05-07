import 'package:admin_app/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteUserConfirmation extends StatelessWidget {
  const DeleteUserConfirmation({super.key});
  static const String route = '/user-management/delete-user/confirmation';

  @override
  Widget build(BuildContext context) {
    buildDeleteUserConfirmation() {
      return Column(
        children: [
          const SizedBox(height: 64.0),
          Center(
            child: Text(
              AppLocalizations.of(context)!.delete_user_confirmation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 64.0),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: header(context, removeBackButton: true),
        body: buildDeleteUserConfirmation(),
      ),
    );
  }
}
