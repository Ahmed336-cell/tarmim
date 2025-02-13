import 'package:flutter/material.dart';
import 'package:tarmim/constants.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_mobile.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_web.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryRespo extends StatelessWidget {
  const DeliveryRespo({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(

            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Color(Constant.color),
              centerTitle: true,
              title:  Text(
                AppLocalizations.of(context)!.address,
                style: TextStyle(fontSize: 24,color: Colors.brown, fontWeight: FontWeight.bold),
              ),
            ),

            body:  DeliveryWeb(totalPrice: totalPrice,),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(Constant.color),
              centerTitle: true,
              title:  Text(
                AppLocalizations.of(context)!.address,
                style: TextStyle(fontSize: 24,color: Colors.brown, fontWeight: FontWeight.bold),
              ),
            ),
            body:  DeliveryMobile(initialTotalPrice: totalPrice,),
          );
        }
      },
    );
  }
}


