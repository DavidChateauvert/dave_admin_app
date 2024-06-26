// ignore_for_file: prefer_const_constructors

import 'package:admin_app/pages/home.dart';
import 'package:admin_app/widget/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});
  static const String route = '/contact-us';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  FocusNode contactfocusNode = FocusNode();
  late String text;
  late String contact;

  submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      focusNode.unfocus();
      sendEmailReportPost();
      showThankYouDialog(context);
      text = "";
      contact = "";
    }
  }

  showThankYouDialog(BuildContext parentContext) {
    return showCupertinoDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            AppLocalizations.of(context)!.thanks_input,
            textAlign: TextAlign.center,
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.please_continue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  AppLocalizations.of(context)!.ok,
                ),
              ]),
            ),
          ],
        );
      },
    );
  }

  sendEmailReportPost() {
    reportsRef.add(
      {
        "to": ["david.chateauvert25@gmail.com"],
        "message": {
          "subject": "Contacted by admin app by $contact",
          "html": text,
        },
      },
    );
  }

  buildFormReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: focusNode,
          validator: (val) {
            if (val!.isEmpty) {
              return AppLocalizations.of(context)!.report_text_error;
            } else {
              return null;
            }
          },
          onSaved: (val) => text = val!,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 15.0),
            hintText: AppLocalizations.of(context)!.write_us,
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        Text(
          AppLocalizations.of(context)!.contact,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextFormField(
          focusNode: contactfocusNode,
          validator: (val) {
            if (val!.isEmpty) {
              return AppLocalizations.of(context)!.report_text_error;
            } else {
              return null;
            }
          },
          onSaved: (val) => contact = val!,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 15.0),
            hintText: AppLocalizations.of(context)!.write_us,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: header(
          context,
          removeBackButton: true,
        ),
        body: Center(
          child: SizedBox(
            width: 440,
            child: ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          AppLocalizations.of(context)!.contact_us_text,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 16.0,
                          left: 16.0,
                          bottom: 32.0,
                        ),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              children: [
                                buildFormReport(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: submit,
                        child: Container(
                          height: 50.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.submit,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
