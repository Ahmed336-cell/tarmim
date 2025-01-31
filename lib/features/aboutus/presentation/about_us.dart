import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  final String instagramUrl = 'https://www.instagram.com/your_business_account/';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController problemController = TextEditingController();

  void _launchInstagram() async {
    final Uri url = Uri.parse(instagramUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $instagramUrl';
    }
  }

  void _sendEmail() async {
    final String email = Uri.encodeComponent(emailController.text);
    final String subject = Uri.encodeComponent("Contact from About Us Page");
    final String body = Uri.encodeComponent(
        "Name: ${nameController.text}\nEmail: ${emailController.text}\nPhone: ${phoneController.text}\nProblem: ${problemController.text}");

    final Uri mailUrl = Uri.parse("mailto:ahmaher04@gmail.com?subject=$subject&body=$body");

    if (!await launchUrl(mailUrl)) {
      throw 'Could not launch email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: double.infinity), // Centers the form for web
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
                          LineIcon.instagram(size: 100, color: Colors.purple),
                          Text('Follow us on Instagram', style: TextStyle(fontSize: 18)),
                        ],
                      )
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Contact Us',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildTextField(nameController, 'Name'),
                    _buildTextField(emailController, 'Email', keyboardType: TextInputType.emailAddress),
                    _buildTextField(phoneController, 'Phone Number', keyboardType: TextInputType.phone),
                    _buildTextField(problemController, 'Problem Description', maxLines: 3),
                    SizedBox(height: 20),
                    CustomButton(text: "Send", onPressed: _sendEmail),

                  ],
                ),
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
