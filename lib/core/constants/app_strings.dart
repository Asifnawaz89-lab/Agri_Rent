class AppStrings {
  // Static variable jo language track karega (Default: English)
  static bool isUrdu = false;

  // App Main Texts
  static String get appTitle => isUrdu ? "ایگری رینٹ" : "AgriRent";
  static String get login => isUrdu ? "لاگ ان کریں" : "Login";
  static String get signup => isUrdu ? "رجسٹریشن کریں" : "Sign Up";
  
  // Fields
  static String get email => isUrdu ? "ای میل" : "Email";
  static String get password => isUrdu ? "پاس ورڈ" : "Password";
  static String get fullName => isUrdu ? "پورا نام" : "Full Name";
  static String get phone => isUrdu ? "فون نمبر" : "Phone Number";
  
  // Roles
  static String get selectRole => isUrdu ? "اپنا رول منتخب کریں" : "Select Your Role";
  static String get farmer => isUrdu ? "کسان (Farmer)" : "Farmer";
  static String get owner => isUrdu ? "مشینری مالک (Owner)" : "Equipment Owner";
  
  // Buttons & Labels
  static String get dontHaveAccount => isUrdu ? "اکاؤنٹ نہیں ہے؟" : "Don't have an account?";
  static String get alreadyHaveAccount => isUrdu ? "پہلے سے اکاؤنٹ موجود ہے؟" : "Already have an account?";
  static String get switchLanguage => isUrdu ? "English" : "اردو";
}