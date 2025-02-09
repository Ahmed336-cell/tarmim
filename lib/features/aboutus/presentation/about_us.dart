import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  static const String _instagramUrl = 'https://www.instagram.com/t_.tarmim/';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();

  Future<void> _launchInstagram() async {
    final Uri url = Uri.parse(_instagramUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $_instagramUrl');
    }
  }

  Future<void> _sendEmail(BuildContext context) async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter an email address")),
      );
      return;
    }

    final Uri mailUrl = Uri(
      scheme: 'mailto',
      path: 'ahmaher04@gmail.com',
      queryParameters: {
        'subject': "Contact from About Us Page",
        'body': '''
          Name: ${_nameController.text}
          Email: ${_emailController.text}
          Phone: ${_phoneController.text}
          Problem: ${_problemController.text}
        '''
      },
    );

    try {
      if (await canLaunchUrl(mailUrl)) {
        await launchUrl(mailUrl);
      } else {
        debugPrint('Could not launch email client');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _launchInstagram,
                    child: Column(
                      children: [
                        LineIcon.instagram(size: 80, color: Colors.purple),
                        const SizedBox(height: 8),
                         Text(AppLocalizations.of(context)!.followUs, style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                   Text(
                     AppLocalizations.of(context)!.contact,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(_nameController, AppLocalizations.of(context)!.name),
                  _buildTextField(_emailController, AppLocalizations.of(context)!.email, keyboardType: TextInputType.emailAddress),
                  _buildTextField(_phoneController,AppLocalizations.of(context)!.phone, keyboardType: TextInputType.phone),
                  _buildTextField(_problemController, AppLocalizations.of(context)!.problemDes, maxLines: 3),
                  const SizedBox(height: 20),
                  CustomButton(text: AppLocalizations.of(context)!.send, onPressed: () => _sendEmail(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
