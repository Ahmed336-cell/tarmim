import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/cartItemMobile.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/orderInfo.dart';
import '../../delivery_details/presentaion/delivery_respo.dart';
import 'manager/cart_cubit.dart';
import 'manager/cart_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().loadCart(context);

    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cartCubit = context.read<CartCubit>();

            if (state.items.isEmpty) {
              return _buildEmptyCart(context);
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return CartItemMobile(
                        image: item.image,
                        title: item.name,
                        brand: "NoteBook",
                        price: item.basePrice,
                        quantity: item.quantity,
                        increase: () => cartCubit.updateItemQuantity(item, item.quantity + 1,context),
                        decrease: () {
                          if (item.quantity > 1) {
                            cartCubit.updateItemQuantity(item, item.quantity - 1,context);
                          }
                        },
                        remove: () => cartCubit.removeCartItem(item.id,context),
                      );
                    },
                  ),
                ),
                OrderInfoRowMobile(label:AppLocalizations.of(context)!.totalPrice, value: "${state.totalPrice} ${AppLocalizations.of(context)!.egp}"),
                SizedBox(height: 8),
                Text(
                  "+ ${AppLocalizations.of(context)!.shippingFees}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeliveryRespo(totalPrice: state.totalPrice),
                      ),
                    ),
                    text: AppLocalizations.of(context)!.placeOrder,
                  ),
                ),
              ],
            );
          }
          return _buildEmptyCart(context);
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/shopping.png", width: 200, height: 200),
          SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.emptyCart,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
