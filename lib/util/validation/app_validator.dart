class AppValidator {
  AppValidator._();

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone number is required";
    }
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(phone)) {
      return "Invalid phone number";
    }
    return null;
  }



  static String? validateCardNumber(String? input) {
    if (input == null || input.isEmpty) {
      return "Card number is required";
    }

    // Remove spaces
    String cleanInput = input.replaceAll(RegExp(r'\s+'), "");


    if (cleanInput.length < 12) {
      return "Card number is too short";
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(cleanInput)) {
      return "Numbers only please";
    }


    return null;
  }

  static String? validateCVV(String? input) {
    if (input == null || input.isEmpty) {
      return "CVV required";
    }

    // LOOSENED: Accept 3 or 4 digits
    if (input.length < 3 || input.length > 4) {
      return "Invalid CVV";
    }
    return null;
  }

  static String? validateExpiry(String? input) {
    if (input == null || input.isEmpty) {
      return "Expiry required";
    }

    // Format check: MM/YY
    if (!RegExp(r'^((0[1-9])|(1[0-2]))\/(\d{2})$').hasMatch(input)) {
      return "Use MM/YY";
    }

    return null;
  }
}