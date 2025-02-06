import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarmim/features/details/presentation/details_respo.dart';
import 'package:tarmim/features/home/data/model/product.dart';
import 'package:tarmim/features/home/presentation/manager/home_cubit.dart';
import 'package:tarmim/features/home/presentation/manager/home_state.dart';
import 'package:tarmim/features/home/presentation/widgets/mobile/product_card_web.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navbar

            // Content
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Product Grid
                  BlocBuilder<HomeCubit,HomeState>(
                      builder:(context,state){
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
    return GridView.builder(
      shrinkWrap: true, // Ensures the grid height adjusts to content
      physics: const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling independently
      itemCount: products.length, // Adjust the number of items
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final prod=products[index];
        return ProductCardWeb(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsRespo(product: prod,)));
          },
          title: prod.product_name,
          price: '${prod.product_price } EGP',
          imageUrl: prod.product_images!.first, // Placeholder images
        );
      },
    );
  }
}
