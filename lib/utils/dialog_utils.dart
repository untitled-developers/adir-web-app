import 'dart:async';

import 'package:flutter/material.dart';

class DialogUtils {
  //TODO Fix the icon of this
  static Future<void> showProgressDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      barrierColor: Colors.white70,
      builder: (BuildContext context) {
        return SizedBox(
          width: 20,
          height: 20,
          child: Transform.scale(
              scale: 0.1, child: const CircularProgressIndicator()),
        );
      },
    );
  }

  static Future<void> showNotifyDialog(BuildContext context,
          {Widget? title, required Widget body, Widget? actions}) async =>
      showDialog<void>(
        context: context, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            child: AlertDialog(
              title: title ?? const Text("Alert"),
              content: actions != null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SingleChildScrollView(
                            child: body,
                          ),
                          const SizedBox(height: 24),
                          actions
                        ],
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SingleChildScrollView(child: body)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
          );
        },
      );

  static Future<void> showErrorDialog(BuildContext context,
          {Widget? title,
          required Widget body,
          Widget? actions,
          Function? onOk}) async =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title ??
                const Text("Error", style: TextStyle(color: Colors.red)),
            content: actions != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SingleChildScrollView(child: body),
                      const SizedBox(height: 24),
                      actions
                    ],
                  )
                : SingleChildScrollView(child: body),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            actions: actions == null
                ? <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, right: 12),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 37),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            onPressed: () {
                              Navigator.pop(context);
                              if (onOk != null) {
                                onOk();
                              }
                            },
                            child: const Text('Ok',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600))),
                      ),
                    ),
                  ]
                : null,
          );
        },
      );
}
