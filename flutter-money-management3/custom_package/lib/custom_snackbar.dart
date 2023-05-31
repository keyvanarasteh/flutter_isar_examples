library custom_alert_box;

import 'package:flutter/material.dart';

class CustomSnackbar {

  static Future showSnackbarCustom({
    required BuildContext context,
    required String string,
  }) async {
    assert(context != null, "context is null!!");
    assert(string != null, "willDisplayWidget is null!!");
    await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(string),
      duration: Duration(milliseconds: 300),
    ));
    return;
  }
}
