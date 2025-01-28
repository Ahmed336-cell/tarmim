import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:tarmim/core/commons/custom_text_field.dart';

import '../../../core/commons/custom_button.dart';

class DeliveryMobile extends StatelessWidget {
  DeliveryMobile({Key? key}) : super(key: key);

  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Makes the entire column scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomTextField(maxLines: 1,label: "Name"),
              const SizedBox(height: 16),
              spinnerAddress(),
              const SizedBox(height: 16),
              const Text(
                "Phone Number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8,),
              CustomTextField(maxLines: 1,label: "01xxxxxxxxxx"),
              const SizedBox(height: 16),
              SizedBox(height: 8,),
              const Text(
                "Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CustomTextField(label: "Address", maxLines: 1),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomButton(
                  text: "Save Address",
                  onPressed: () {},
                ),
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
}
