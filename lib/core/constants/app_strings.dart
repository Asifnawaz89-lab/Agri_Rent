class AppStrings {
  AppStrings._();

  // Current Language Code State ('en' or 'ur')
  static String currentLanguage = 'en';

  static bool get isUrdu => currentLanguage == 'ur';

  static void toggleLanguage() {
    currentLanguage = isUrdu ? 'en' : 'ur';
  }

  // =====================================================
  // ENGLISH
  // =====================================================
  static const Map<String, String> en = {
    // App
    'appName': 'AgriRent',
    'tagline': 'Rent. Farm. Grow.',

    // Welcome & Auth
    'welcome': 'Welcome to AgriRent!',
    'welcomeSubtitle': 'Connect with local agricultural equipment owners and farmers.',
    'welcomeBack': 'Welcome Back',
    'loginAccount': 'Login to your account',
    'usernameEmail': 'Username / Email',
    'email': 'Email',
    'password': 'Password',
    'enterEmail': 'Enter your email',
    'enterPassword': 'Enter your password',
    'login': 'Login',
    'forgotPassword': 'Forgot Password?',
    'dontHaveAccount': "Don't have an account?",
    'signUp': 'Sign Up',
    'loginWithGoogle': 'Login with Google',
    'orSignInWith': 'or sign in with',

    // Signup
    'createAccount': 'Create Account',
    'createYourAccount': 'Create your new account',
    'fullName': 'Full Name',
    'enterFullName': 'Enter your full name',
    'confirmPassword': 'Confirm Password',
    'confirmYourPassword': 'Confirm your password',
    'alreadyHaveAccount': 'Already have an account?',
    'orSignUpWith': 'or signup with',

    // Role
    'selectRole': 'Select Your Role',
    'chooseRole': 'Choose how you want to use AgriRent',
    'farmer': 'Farmer',
    'equipmentOwner': 'Equipment Owner',
    'farmerDescription': 'Find and rent agricultural machinery for your farm.',
    'ownerDescription': 'List your agricultural equipment and earn by renting it.',

    // Equipment Module
    'addEquipment': 'Add Equipment',
    'equipmentTitle': 'Equipment Title',
    'category': 'Category',
    'hourlyRate': 'Hourly Rate (PKR)',
    'dailyRate': 'Daily Rate (PKR)',
    'description': 'Description',
    'publishEquipment': 'Publish Equipment',
    'uploadPhotos': 'Upload Equipment Photos',
    'imagesSelected': 'Images Selected',
    'selectAtleastOneImage': 'Please select at least one image',
    'equipmentAddedSuccess': 'Equipment added successfully!',

    // Messages & Home
    'agreeTerms': 'I agree to the Terms & Conditions',
    'passwordResetSent': 'Password reset email has been sent.',
    'requiredName': 'Please enter your name.',
    'requiredEmail': 'Please enter your email.',
    'requiredPassword': 'Please enter your password.',
    'passwordMismatch': 'Passwords do not match.',
    'accountCreated': 'Account created successfully.',
    'loginSuccess': 'Login successful.',
    'somethingWrong': 'Something went wrong. Please try again.',
    'farmerHome': 'Farmer Home',
    'ownerHome': 'Owner Home',
    'logout': 'Logout',
    'urdu': 'اردو',
    'english': 'English',
  };

  // =====================================================
  // URDU
  // =====================================================
  static const Map<String, String> ur = {
    // App
    'appName': 'ایگری رینٹ',
    'tagline': 'کرایہ لیں۔ کاشت کریں۔ ترقی کریں۔',

    // Welcome & Auth
    'welcome': 'ایگری رینٹ میں خوش آمدید!',
    'welcomeSubtitle': 'مقامی زرعی آلات کے مالکان اور کسانوں سے رابطہ کریں۔',
    'welcomeBack': 'خوش آمدید',
    'loginAccount': 'اپنے اکاؤنٹ میں لاگ اِن کریں',
    'usernameEmail': 'یوزرنیم / ای میل',
    'email': 'ای میل',
    'password': 'پاس ورڈ',
    'enterEmail': 'اپنی ای میل درج کریں',
    'enterPassword': 'اپنا پاس ورڈ درج کریں',
    'login': 'لاگ اِن',
    'forgotPassword': 'پاس ورڈ بھول گئے؟',
    'dontHaveAccount': 'اکاؤنٹ نہیں ہے؟',
    'signUp': 'سائن اَپ',
    'loginWithGoogle': 'گوگل سے لاگ اِن کریں',
    'orSignInWith': 'یا اس کے ذریعے لاگ اِن کریں',

    // Signup
    'createAccount': 'اکاؤنٹ بنائیں',
    'createYourAccount': 'اپنا نیا اکاؤنٹ بنائیں',
    'fullName': 'پورا نام',
    'enterFullName': 'اپنا پورا نام درج کریں',
    'confirmPassword': 'پاس ورڈ کی تصدیق',
    'confirmYourPassword': 'اپنا پاس ورڈ دوبارہ درج کریں',
    'alreadyHaveAccount': 'پہلے سے اکاؤنٹ ہے؟',
    'orSignUpWith': 'یا اس کے ذریعے سائن اَپ کریں',

    // Role
    'selectRole': 'اپنا کردار منتخب کریں',
    'chooseRole': 'منتخب کریں کہ آپ AgriRent کیسے استعمال کرنا چاہتے ہیں',
    'farmer': 'کسان',
    'equipmentOwner': 'زرعی آلات کے مالک',
    'farmerDescription': 'اپنے فارم کے لیے زرعی مشینری تلاش کریں اور کرائے پر حاصل کریں۔',
    'ownerDescription': 'اپنی زرعی مشینری لسٹ کریں اور کرائے پر دے کر آمدنی حاصل کریں۔',

    // Equipment Module
    'addEquipment': 'نئی مشینری شامل کریں',
    'equipmentTitle': 'مشینری کا نام',
    'category': 'کیٹیگری',
    'hourlyRate': 'فی گھنٹہ کرایہ (روپے)',
    'dailyRate': 'فی دن کرایہ (روپے)',
    'description': 'تفصیل',
    'publishEquipment': 'شامل کریں',
    'uploadPhotos': 'تصاویر منتخب کریں',
    'imagesSelected': 'تصاویر منتخب ہو گئیں',
    'selectAtleastOneImage': 'کم از کم ایک تصویر منتخب کریں',
    'equipmentAddedSuccess': 'مشینری کامیابی سے شامل ہو گئی!',

    // Messages & Home
    'agreeTerms': 'میں شرائط و ضوابط سے اتفاق کرتا ہوں',
    'passwordResetSent': 'پاس ورڈ ری سیٹ کرنے کی ای میل بھیج دی گئی ہے۔',
    'requiredName': 'براہ کرم اپنا نام درج کریں۔',
    'requiredEmail': 'براہ کرم اپنی ای میل درج کریں۔',
    'requiredPassword': 'براہ کرم اپنا پاس ورڈ درج کریں۔',
    'passwordMismatch': 'پاس ورڈ ایک جیسے نہیں ہیں۔',
    'accountCreated': 'اکاؤنٹ کامیابی سے بن گیا۔',
    'loginSuccess': 'لاگ اِن کامیاب ہوگیا۔',
    'somethingWrong': 'کچھ غلط ہوگیا۔ دوبارہ کوشش کریں۔',
    'farmerHome': 'کسان ہوم',
    'ownerHome': 'مالک ہوم',
    'logout': 'لاگ آؤٹ',
    'urdu': 'اردو',
    'english': 'English',
  };

  // Helper method with fallback to currentLanguage
  static String get(String key, [String? language]) {
    String lang = language ?? currentLanguage;
    if (lang == 'ur') {
      return ur[key] ?? key;
    }
    return en[key] ?? key;
  }
}