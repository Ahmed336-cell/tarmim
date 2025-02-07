import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/orderInfo.dart';
import '../../../core/commons/custom_button.dart';
import '../../../core/commons/custom_text_field.dart';
import '../../cart/presentation/manager/cart_cubit.dart';
import '../../cart/presentation/manager/cart_state.dart';

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
              _AddressSection(
                nameController: nameController,
                phoneController: phoneController,
                emailController: emailController,
                addressController: addressController,
                countryController: countryController,
                stateController: stateController,
                cityController: cityController,
              ),
              const SizedBox(height: 16),
              _PromoCodeSection(promoCodeController: promoCodeController),
              const SizedBox(height: 16),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  double total = (state is CartLoaded) ? state.totalPrice : initialTotalPrice;
                  double shippingCost = context.read<CartCubit>().getShippingCost(stateController.text);
                  double finalPrice = total + shippingCost;
                  double priceWithoutShipping = finalPrice - shippingCost;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderInfoRowMobile(
                        label: "Final Price",
                        value: stateController.text.isEmpty
                            ? "${priceWithoutShipping.toStringAsFixed(2)} EGP"
                            : "${finalPrice.toStringAsFixed(2)} EGP",
                      ),
                      const SizedBox(height: 16),
                      _ConfirmButton(
                        finalPrice: finalPrice,
                        validateFields: () => _validateFields(context),
                        placeOrder: () => _placeOrder(context, finalPrice),
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

  void _placeOrder(BuildContext context, double finalPrice) {
    if (_validateFields(context)) {
      showDialog(
        context: context,
        builder: (context) => _ConfirmDialog(
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
            context.read<CartCubit>().placeOrder();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CartRespo()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Order placed successfully!")),
            );
          },
        ),
      );
    }
  }
}

/// **Reusable Address Section**
class _AddressSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;

  const _AddressSection({
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.addressController,
    required this.countryController,
    required this.stateController,
    required this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextField(label: "Name", controller: nameController, maxLines: 1,),
        const SizedBox(height: 16),
        CountryStateCityPicker(
          country: countryController,
          state: stateController,
          city: cityController,
        ),
        const SizedBox(height: 16),
        const Text("Phone Number", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        CustomTextField(label: "01xxxxxxxxxx", controller: phoneController, maxLines: 1,),
        const SizedBox(height: 16),
        const Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        CustomTextField(label: "Email", controller: emailController, maxLines: 1,),
        const SizedBox(height: 16),
        const Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        CustomTextField(label: "Address", controller: addressController, maxLines: 2,),
      ],
    );
  }
}

/// **Reusable Promo Code Section**
class _PromoCodeSection extends StatelessWidget {
  final TextEditingController promoCodeController;

  const _PromoCodeSection({required this.promoCodeController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Promo Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextField(label: "Enter Promo Code", controller: promoCodeController, maxLines: 1,),
        const SizedBox(height: 8),
        CustomButton(
          onPressed: () {
            if (promoCodeController.text.isNotEmpty) {
              context.read<CartCubit>().applyPromoCode(promoCodeController.text);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter a promo code")),
              );
            }
          },
          text: "Apply Promo Code",
        ),
      ],
    );
  }
}

/// **Reusable Confirm Order Button**
class _ConfirmButton extends StatelessWidget {
  final double finalPrice;
  final VoidCallback placeOrder;
  final bool Function() validateFields;

  const _ConfirmButton({required this.finalPrice, required this.placeOrder, required this.validateFields});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Confirm Order",
      onPressed: () => validateFields() ? placeOrder() : null,
    );
  }
}

/// **Reusable Confirm Dialog**
class _ConfirmDialog extends StatelessWidget {
  final double finalPrice;
  final VoidCallback onConfirm;

  const _ConfirmDialog({required this.finalPrice, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Order"),
      content: Text("Total amount: ${finalPrice.toStringAsFixed(2)} EGP"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(onPressed: onConfirm, child: const Text("Confirm")),
      ],
    );
  }
}
