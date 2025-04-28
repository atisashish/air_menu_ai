import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeChange.getThem()
              ? AppThemeData.surfaceDark
              : AppThemeData.surface,
      appBar: AppBar(
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("1. Introduction"),
            _buildParagraph(
              "Welcome to Air Menu AI. Your privacy is critically important to us. This Privacy Policy outlines the types of information we collect, how we use and protect it, and the rights you have regarding your personal data.",
            ),

            _buildSectionTitle("2. Information We Collect"),
            _buildParagraph(
              "We collect different types of information, including:",
            ),
            _buildParagraph(
              "- Personal Information: Name, email address, contact details.",
            ),
            _buildParagraph(
              "- Device Information: Device type, operating system, and unique identifiers.",
            ),
            _buildParagraph(
              "- Usage Data: Pages visited, features used, and other analytics.",
            ),

            _buildSectionTitle("3. How We Use Your Information"),
            _buildParagraph("We use the collected information to:"),
            _buildParagraph("- Provide, operate, and improve our services."),
            _buildParagraph(
              "- Customize user experience and respond to inquiries.",
            ),
            _buildParagraph(
              "- Analyze user trends and measure the effectiveness of our services.",
            ),

            _buildSectionTitle("4. Sharing Your Information"),
            _buildParagraph(
              "We do not sell or rent your personal information. However, we may share it with third parties in the following circumstances:",
            ),
            _buildParagraph(
              "- With service providers who assist in delivering our services.",
            ),
            _buildParagraph(
              "- When required by law or to protect rights and safety.",
            ),
            _buildParagraph(
              "- In case of business transfer, such as a merger or acquisition.",
            ),

            _buildSectionTitle("5. Data Security"),
            _buildParagraph(
              "We take appropriate security measures to protect your personal information from unauthorized access and disclosure.",
            ),

            _buildSectionTitle("6. Your Rights"),
            _buildParagraph(
              "Depending on your location, you may have rights such as:",
            ),
            _buildParagraph("- Accessing your personal data."),
            _buildParagraph(
              "- Requesting correction or deletion of your data.",
            ),
            _buildParagraph(
              "- Opting out of data processing where applicable.",
            ),

            _buildSectionTitle("7. Changes to This Policy"),
            _buildParagraph(
              "We may update this Privacy Policy from time to time. We will notify users of significant changes.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }
}

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeChange.getThem()
              ? AppThemeData.surfaceDark
              : AppThemeData.surface,
      appBar: AppBar(
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("1. Introduction"),
            _buildParagraph(
              "Welcome to Air Menu AI. By accessing or using our services, you agree to comply with and be bound by the following Terms and Conditions.",
            ),

            _buildSectionTitle("2. User Responsibilities"),
            _buildParagraph("As a user of our services, you agree to:"),
            _buildParagraph("- Provide accurate and up-to-date information."),
            _buildParagraph("- Use our services only for lawful purposes."),
            _buildParagraph(
              "- Not engage in any fraudulent or abusive activities.",
            ),

            _buildSectionTitle("3. Intellectual Property"),
            _buildParagraph(
              "All content, including text, graphics, and logos, is the property of Air Menu AI and is protected by copyright laws.",
            ),

            _buildSectionTitle("4. Termination of Service"),
            _buildParagraph(
              "We reserve the right to suspend or terminate your access to our services if you violate these Terms and Conditions.",
            ),

            _buildSectionTitle("5. Limitation of Liability"),
            _buildParagraph(
              "We are not responsible for any indirect or consequential damages arising from your use of our services.",
            ),

            _buildSectionTitle("6. Changes to Terms"),
            _buildParagraph(
              "We may update these Terms and Conditions from time to time. Continued use of our services constitutes acceptance of the changes.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }
}
