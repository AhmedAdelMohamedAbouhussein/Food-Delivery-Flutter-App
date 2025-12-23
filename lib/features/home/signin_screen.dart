import 'package:final_proj/core/resources/app_icons.dart';
import 'package:final_proj/core/storage/sharedPrefsHelper.dart';
import 'package:final_proj/features/home/home_screen.dart';
import 'package:final_proj/util/validation/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  SharedPrefsHelper? _prefsHelper;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefsHelper = await SharedPrefsHelper.init();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AppIcons.signupWelcome),
                  Image.asset(AppIcons.splashLogo),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Food delivered to you',
              style: GoogleFonts.robotoCondensed(
                color: const Color.fromARGB(255, 0, 200, 116),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),

            Text(
              'Please enter your phone number to continue.',
              style: GoogleFonts.robotoCondensed(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: phoneController,
                maxLength: 11,
                keyboardType: TextInputType.phone,
                validator: AppValidator.validatePhone,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixText: '+20 | ',
                  counterText: '',
                ),
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final phone = phoneController.text.trim();

                  await _prefsHelper?.setPhoneNumber(phone);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 200, 116),
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.robotoCondensed(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
