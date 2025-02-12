import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/commons/custom_text_field.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/orderInfo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../cart/presentation/manager/cart_state.dart';
/// **Reusable Address Section**
class AddressSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;

  const AddressSection({
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.addressController,
    required this.countryController,
    required this.stateController,
    required this.cityController,
  });

  @override
  AddressSectionState createState() => AddressSectionState();
}

class AddressSectionState extends State<AddressSection> {
  String selectedGovernorate = "";
  final List<String> shippingCosts = [
    "القاهره",
    "الجيزه",
    "الدقهلية",
    "الغربية",
    "الشرقية",
    "المنوفية",
    "كفر الشيخ",
    "البحيرة",
    "بورسعيد",
    "الإسماعيلية",
    "السويس",
    "الإسكندرية",
    "الغردقة",
    "الوادي",
    "مطروح",
    "شرم الشيخ",
    "العين السخنه",
    "بني سويف",
    "المنيا",
    "أسيوط",
    "سوهاج",
    "قنا",
    "الأقصر",
    "أسوان",
    "البحر الأحمر",
  ];


  @override
  void initState() {
    super.initState();
    widget.countryController.text = "Egypt"; // Ensure Egypt is always selected
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextField(label: AppLocalizations.of(context)!.name, controller: widget.nameController, maxLines: 1, enabled: true),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.email, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextField(label: AppLocalizations.of(context)!.email, controller: widget.emailController, maxLines: 1, enabled: true),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.phone, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextField(label: AppLocalizations.of(context)!.phone, controller: widget.phoneController, maxLines: 1, enabled: true),
        const SizedBox(height: 16),
        Text("الدولة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        CustomTextField(label: "Egypt", controller: widget.countryController, maxLines: 1, enabled: false),

        const SizedBox(height: 16),

        Text("المحافظة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedGovernorate.isNotEmpty ? selectedGovernorate : null,
          items: shippingCosts.map((String gov) {
            return DropdownMenuItem<String>(
              value: gov,
              child: Text(gov),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedGovernorate = newValue;
                widget.stateController.text = newValue;
              });

              context.read<CartCubit>().updateLocation(
                widget.nameController.text,
                widget.countryController.text,
                widget.emailController.text,
                newValue,
                widget.cityController.text,
                widget.addressController.text,
                widget.phoneController.text,
              );
            }
          },

          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "اختر المحافظة",
          ),
        ),

        const SizedBox(height: 16),
        Text("المدينة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        CustomTextField(label: "المدينة", controller: widget.cityController, maxLines: 1, enabled: true),

        const SizedBox(height: 16),

        Text("العنوان", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        CustomTextField(label: "العنوان", controller: widget.addressController, maxLines: 2, enabled: true),
      ],
    );
  }
}