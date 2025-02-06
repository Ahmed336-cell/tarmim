import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarmim/features/details/presentation/details_respo.dart';
import 'package:tarmim/features/home/data/model/product.dart';
import 'package:tarmim/features/home/presentation/manager/home_cubit.dart';
import 'package:tarmim/features/home/presentation/manager/home_state.dart';
import 'package:tarmim/features/home/presentation/widgets/mobile/product_card_mobile.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key, });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap everything in SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/log.png",
                    width: 100,
                    height: 100,
                  ),

                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Product Grid
               BlocBuilder<HomeCubit, HomeState>(
                   builder: (context,state){
                     if(state is ProductListSuccess){
                       return _buildProductGrid(state.products);
                   }else if(state is ProductListLoading){
                     return Center(child: CircularProgressIndicator());
                     }else if(state is ProductListFailure){
                        return Center(child: Text(state.message));
                     }else{
                        return Container();
                     }
                   }

               )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: GridView.builder(
        shrinkWrap: true, // Allow the GridView to size itself
        physics: const NeverScrollableScrollPhysics(), // Prevent independent scrolling
        itemCount: products.length, // Number of items in the grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: products.length > 1 ? 2 : 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final product= products[index];
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductCardMobile(
                onTap: () {
                  // Handle tap
                   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsRespo(product: product,)));
                },
                title: product.product_name,
                price: '${product.product_price} EGP',
                imageUrl: product.product_images!.first, // Placeholder image
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          );
        },
      ),
    );
  }
}
