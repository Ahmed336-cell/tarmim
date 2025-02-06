import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';

import '../../../core/commons/custom_button.dart';
import '../../../core/commons/custom_text_field.dart';
import '../../cart/presentation/manager/cart_cubit.dart';
import '../../cart/presentation/manager/cart_state.dart';

class DeliveryMobile extends StatelessWidget {
  DeliveryMobile({Key? key, required this.initialTotalPrice}) : super(key: key);
  final double initialTotalPrice;

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
              const Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextField(maxLines: 1, label: "Name", controller: nameController),

              const SizedBox(height: 16),
              spinnerAddress(),

              const SizedBox(height: 16),
              const Text("Phone Number", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextField(maxLines: 1, label: "01xxxxxxxxxx", controller: phoneController),
              const SizedBox(height: 16),
              const Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              CustomTextField(label: "Email", maxLines: 1, controller: emailController),
              const SizedBox(height: 16),
              const Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              CustomTextField(label: "Address", maxLines: 1, controller: addressController),
              const SizedBox(height: 16),
              // Promo Code Section
              const Text("Promo Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextField(label: "Enter Promo Code", maxLines: 1, controller: promoCodeController),
              const SizedBox(height: 8),

              // Order summary and confirm button
              BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {
                  if (state is CartError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  double total;
                  if (state is CartLoaded) {
                    total = state.totalPrice;
                  } else {
                    total = initialTotalPrice;
                  }
                  double shippingCost = context.read<CartCubit>().getShippingCost(stateController.text);
                  double finalPrice = total + shippingCost;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (promoCodeController.text.isNotEmpty) {
                              context.read<CartCubit>().applyPromoCode(promoCodeController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please enter a promo code")),
                              );
                            }
                          },
                          child: const Text("Apply Promo Code"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text("Total Price: \$${total.toStringAsFixed(2)}"),
                      Text("Shipping: \$${shippingCost.toStringAsFixed(2)}"),
                      Text("Final Price: \$${finalPrice.toStringAsFixed(2)}"),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: CustomButton(
                          text: "Confirm Order",
                          onPressed: () {
                            if (validateFields(context)) {
                              _showConfirmDialog(context, finalPrice);
                            }
                          },
                        ),
                      ),
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

  Widget spinnerAddress() {
    return CountryStateCityPicker(
      country: countryController,
      state: stateController,
      city: cityController,
    );
  }

  void _showConfirmDialog(BuildContext context, double finalPrice) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Order"),
          content: Text("Total amount to be paid: \$${finalPrice.toStringAsFixed(2)}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                context.read<CartCubit>().updateLocation(
                  nameController.text,
                  countryController.text,
                  emailController.text,
                  stateController.text,
                  cityController.text,
                  addressController.text,
                  phoneController.text,
                );
                context.read<CartCubit>().placeOrder();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully!")),
                );
                Navigator.pop(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  bool validateFields(BuildContext context) {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        countryController.text.isEmpty ||
        stateController.text.isEmpty ||
        cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return false;
    }
    return true;
  }
}