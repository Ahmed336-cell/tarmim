import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/cart/presentation/widgets/web/cart_item_web.dart';
import 'package:tarmim/features/cart/presentation/widgets/web/order_info_web.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_respo.dart';
import 'manager/cart_cubit.dart';
import 'manager/cart_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartWeb extends StatelessWidget {
  const CartWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              return state.items.isEmpty
                  ? const _EmptyCartView()
                  : _CartContent(state: state);
            } else {
              return const _EmptyCartView();
            }
          },
        ),
      ),
    );
  }
}

class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/shopping.png",
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 16),
           Text(
             AppLocalizations.of(context)!.emptyCart ,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  final CartLoaded state;

  const _CartContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth > 800;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return CartItemWeb(
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
            if (isWideScreen) const SizedBox(width: 24),
            Expanded(
              flex: isWideScreen ? 2 : 3,
              child: _OrderSummary(state: state),
            ),
          ],
        );
      },
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final CartLoaded state;

  const _OrderSummary({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderInfoRowWeb(
            label: AppLocalizations.of(context)!.totalPrice,
            value: "${state.totalPrice} ${AppLocalizations.of(context)!.egp}",
          ),
          const SizedBox(height: 8),
           Text(
            "+ ${AppLocalizations.of(context)!.shippingFees}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: AppLocalizations.of(context)!.placeOrder,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeliveryRespo(totalPrice: state.totalPrice),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
