import 'package:flutter/material.dart';

import '../utils/theme.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    width = width > 400 ? 400 : width;
    return SizedBox(
        width: width,
        child: Row(
          children: [
            const CircularProgressIndicator(color: MyTheme.primary),
            Container(
                padding: const EdgeInsets.only(left: 25),
                child: Text("Please wait...",
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.color))),
          ],
        ));
  }
}