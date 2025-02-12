import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/commons/custom_button.dart';
/// **Reusable Confirm Order Button**
class ConfirmButton extends StatelessWidget {
  final double finalPrice;
  final VoidCallback placeOrder;
  final bool Function() validateFields;

  const ConfirmButton({required this.finalPrice, required this.placeOrder, required this.validateFields});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppLocalizations.of(context)!.confirmOrder,
      onPressed: () => validateFields() ? placeOrder() : null,
    );
  }
}