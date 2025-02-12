import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/orderInfo.dart';
import 'package:tarmim/features/delivery_details/presentaion/widgets/address_section.dart';
import 'package:tarmim/features/delivery_details/presentaion/widgets/confirm_button.dart';
import 'package:tarmim/features/delivery_details/presentaion/widgets/confirm_dialog.dart';
import 'package:tarmim/features/delivery_details/presentaion/widgets/promo_section.dart';
import '../../../core/commons/custom_button.dart';
import '../../../core/commons/custom_text_field.dart';
import '../../../core/utlis/validation_helper.dart';
import '../../cart/presentation/manager/cart_cubit.dart';
import '../../cart/presentation/manager/cart_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryMobile extends StatelessWidget {
  final double initialTotalPrice;

  DeliveryMobile({Key? key, required this.initialTotalPrice}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              AddressSection(
                nameController: nameController,
                phoneController: phoneController,
                emailController: emailController,
                addressController: addressController,
                countryController: countryController,
                stateController: stateController,
                cityController: cityController,
              ),
              const SizedBox(height: 16),
              PromoCodeSection(promoCodeController: promoCodeController),
              const SizedBox(height: 16),
              BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {
                  print("Cart state changed! New total: ${(state as CartLoaded).totalPrice}");
                },
                builder: (context, state) {
                  double total = (state is CartLoaded) ? state.totalPrice : initialTotalPrice;


                  return Column(
                    children: [
                      OrderInfoRowMobile(
                        label: AppLocalizations.of(context)!.finalPrice,
                        value: "${total.toStringAsFixed(2)} ${AppLocalizations.of(context)!.egp}",
                      ),
                      ConfirmButton(
                        finalPrice: total,
                        validateFields: () => _validateFields(context),
                        placeOrder: () => _placeOrder(context, total),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields(BuildContext context) {
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        stateController.text.isEmpty ||
        cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return false;
    }

    if (!ValidationHelper.isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email format")),
      );
      return false;
    }

    if (!ValidationHelper.isValidPhone(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid phone number")),
      );
      return false;
    }

    return true;
  }

  void _placeOrder(BuildContext context, double finalPrice) {
    if (_validateFields(context)) {
      showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
          finalPrice: finalPrice,
          onConfirm: () {
            context.read<CartCubit>().updateLocation(
              nameController.text,
              countryController.text,
              emailController.text,
              stateController.text,
              cityController.text,
              addressController.text,
              phoneController.text,
            );
            context.read<CartCubit>().placeOrder(context);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(AppLocalizations.of(context)!.orderPlacedSuccessfully)),
            );
          },
        ),
      );
    }
  }
}






