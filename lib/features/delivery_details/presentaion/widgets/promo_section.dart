import 'package:flutter/material.dart';
import '../../../../core/commons/custom_text_field.dart';
import '../../../../core/commons/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cart/presentation/manager/cart_state.dart';

class PromoCodeSection extends StatelessWidget {
  final TextEditingController promoCodeController;

  const PromoCodeSection({required this.promoCodeController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        double shippingCost = 0;
        double totalPrice = 0;

        if (state is CartLoaded) {
          shippingCost = state.shippingCost;
          totalPrice = state.totalPrice;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.promoCode,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              label: AppLocalizations.of(context)!.enterPromoCode,
              controller: promoCodeController,
              maxLines: 1,
              enabled: true,
            ),
            const SizedBox(height: 8),
            CustomButton(
              onPressed: () {
                if (promoCodeController.text.isNotEmpty) {
                  context.read<CartCubit>().applyPromoCode(promoCodeController.text, context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.pleaseEnterPromoCode)),
                  );
                }
              },
              text: AppLocalizations.of(context)!.applyPromoCode,
            ),
            const SizedBox(height: 16),

            /// **💰 Display Total & Shipping Cost**

          ],
        );
      },
    );
  }
}
