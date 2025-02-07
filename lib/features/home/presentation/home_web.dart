import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tarmim/features/details/presentation/details_respo.dart';
import 'package:tarmim/features/home/data/model/product.dart';
import 'package:tarmim/features/home/presentation/manager/home_cubit.dart';
import 'package:tarmim/features/home/presentation/manager/home_state.dart';
import 'package:tarmim/features/home/presentation/widgets/mobile/product_card_web.dart';

class WebHomePage extends StatelessWidget {
  WebHomePage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                controller: _searchController,
                onChanged: (query) => context.read<HomeCubit>().searchProducts(query),
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
            ),
            const SizedBox(height: 32),
            // Product Grid
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is ProductListLoading) {
                    return _buildSkeletonGrid(); // Show skeleton while loading
                  } else if (state is ProductListSuccess) {
                    return _buildProductGrid(state.products);
                  } else if (state is ProductListFailure) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // **Product Grid With Real Data**
  Widget _buildProductGrid(List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
        crossAxisCount: 5,
      ),
      itemBuilder: (context, index) {
        final prod = products[index];
        return ProductCardWeb(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsRespo(product: prod)),
            );
          },
          title: prod.product_name,
          price: '${prod.product_price} EGP',
          imageUrl: prod.product_images!.first,
        );
      },
    );
  }

  // **Skeleton Loading Grid**
  Widget _buildSkeletonGrid() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10, // Show 10 skeleton items
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
          crossAxisCount: 5,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 4),
                Container(
                  height: 12,
                  width: 50,
                  color: Colors.grey[300],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
