import 'package:admin_app/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

AppBar header(context, {removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Image.asset(
      'assets/images/logo/logo_launch.png',
      height: 100,
    ),
    centerTitle: true,
    actions: [
      Row(
        children: [
          TextButton(
            onPressed: () => Provider.of<LocaleProvider>(context, listen: false)
                .toggleLocale(),
            child: Text(
              AppLocalizations.of(context)!.header_language,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            width: 32.0,
          ),
        ],
      ),
    ],
  );
}
