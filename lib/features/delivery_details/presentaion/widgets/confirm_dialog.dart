import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ConfirmDialog extends StatelessWidget {
  final double finalPrice;
  final VoidCallback onConfirm;

  const ConfirmDialog({required this.finalPrice, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(AppLocalizations.of(context)!.confirmOrder),
      content: Text("${AppLocalizations.of(context)!.totalamount} ${finalPrice.toStringAsFixed(2)} ${AppLocalizations.of(context)!.egp}"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child:  Text(AppLocalizations.of(context)!.cancel)),
        TextButton(onPressed: onConfirm, child:  Text(AppLocalizations.of(context)!.confirm))
      ],
    );
  }
}