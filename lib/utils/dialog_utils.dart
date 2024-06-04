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
        return const Center(child: Icon(Icons.download_for_offline));
      },
    );
  }

  static Future<void> showNotifyDialog(BuildContext context,
          {Widget? title, required Widget body, Widget? actions}) async =>
      showDialog<void>(
        context: context, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          );
        },
      );
}
