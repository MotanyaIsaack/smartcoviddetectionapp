import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isIos =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

class AppColor {
  static var pagingIndicatorColor = Colors.red;
  static var themeColor = HexToColor("#028090");
  // static var themeColor = HexToColor("#79CABD");
  // static var themeColor = HexToColor("#f2bd68");
  // static var themeColor = HexToColor("#9468f2");
  // static var themeColor = HexToColor("#f268b4");
  // static var themeColor = HexToColor("#f26868");

}

class HexToColor extends Color {
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }

  HexToColor(final String code) : super(_hexToColor(code));
}

class AppString {
  static var onBoard1Descript =
      "Connect with doctors around you. Book your schedules and consult all in one place";
  static var onBoard2Descript = "Get the Best advice from our doctors";
  static var onBoard3Descript = "Self test COVID-19 using an x_ray image.";
  static var onBoardTitle1 = "onBoardTitle1";
  static var onBoardTitle2 = "onBoardTitle2";
  static var onBoardTitle3 = "onBoardTitle3";
  static var onBoardSkip = "onBoardSkip";
  static var importantNote =
      "Before Going to Call between doctor and patient you must have to follow all the steps mentioned below";
  static var note1 =
      "Before Going to Call between doctor and patient you must have to follow all the steps mentioned below";
//static var importantNote = "Before Going to Call between doctor and patient you must have to follow all the steps mentioned below";
//static var importantNote = "Before Going to Call between doctor and patient you must have to follow all the steps mentioned below";
//static var importantNote = "Before Going to Call between doctor and patient you must have to follow all the steps mentioned below";
//static var importantNote = "Before Going to Call between doctor and patient you must have to follow all the steps mentioned below";
//static var importantNote = "Before Going to Call between doctor and patient you must have to follow all the steps mentioned below";
}

class AppImage {
  static var onBoardImg1 = "Assets/Onboarding/doctor.png";
  static var onBoardImg2 = "Assets/Onboarding/medication.png";
  static var onBoardImg3 = "Assets/Onboarding/appointment.png";
  static var appLogo = "Assets/Login/covlogo.png";
  static var doctorList = "Assets/DoctorList/doctor1.jpg";
  static var doctorProfileMessage = "Assets/DoctorProfile/message.png";
  static var doctorProfilePhone = "Assets/DoctorProfile/phone.png";
  static var doctorProfile = "Assets/DoctorProfile/profileDoctor.jpeg";
  static var drugImage = "Assets/DrugsList/drugImage.png";
  static var paymentCard = "Assets/Checkout/Card.png";
  static var paymentCod = "Assets/Checkout/Cod.png";
  static var paymentPaypal = "Assets/Checkout/paypal.png";
  static var paymentSuccess = "Assets/Checkout/success.png";
  static var blogFoodImage = "Assets/Blogs/food.jpeg";
  static var drProfile2 = "Assets/DoctorList/doctor2.jpg";
  static var drProfile3 = "Assets/DoctorList/doctor3.png";
  static var drProfile4 = "Assets/DoctorList/doctor4.png";
  static var drProfile5 = "Assets/DoctorList/doctor5.png";
  static var drProfile6 = "Assets/DoctorList/doctor6.png";
  static var drProfile7 = "Assets/DoctorList/doctor7.png";
  static var drProfile8 = "Assets/DoctorList/doctor8.png";
  static var hispital = "Assets/Hospital/hospital1.png";
}

class AppTitle {
  //OnBoarding
  static var onBoardTitle1 = "DOCTORS";
  static var onBoardTitle2 = "HOSPITALS";
  static var onBoardTitle3 = "SELF TESTING";
  static var onBoardSkip = "onBoardSkip";
  static var getStarted = "GET STARTED";

  //Login
  static var loginUserName = "Username";
  static var password = "password";
  static var rememberMe = "Remember me";
  static var loginSignIn = "SIGN IN";
  static var loginFbSignIn = "Sign in with facebook";
  static var loginForgetPass = "Forgot Password";
  static var loginSignUp = "SIGN UP";
  static var loginDontHaveAccount = "Don't have an account?";

//Forgot Password
  static var forgetPassStr = "Forgot Password";
  static var forgotPassEmail = "Email";
  static var forgotPassSendEmail = "SEND EMAIL";

//Sign Up
  static var signUpConfirmPass = "Confirm Password";
  static var signUpNote = "Already have an account? ";

//Create Account

  static var createAccountFullName = "createAccountFullName";
  static var createAccountDOB = "createAccountDOB";
  static var createAccountGender = "createAccountGender";
  static var createAccountWeight = "createAccountWeight";
  static var createAccountHeight = "createAccountHeight";
  static var createAccountTitle = "createAccountTitle";

//Dashboard

  static var dashbFindDoctor = "Find Doctor";
  static var dashbFindHospital = "Find Hospital";
  static var dashbAppointment = "Appointment";
  static var dashbPriceServices = "dashbPriceServices";
  static var appTitle = "Smart Covid-19 Detector";
  static var doctorAvaliability = "doctorAvaliability";
  static var hospitalAvaliability = "hospitalAvaliability";
  static var appointmentAvaliability = "appointmentAvaliability";
  static var priceServicesAvaliability = "priceServicesAvaliability";
  static var dashbHello = "Hello";
  static var dashboard_title = "How can we help you?";

//Drawer
  static var drawerHome = "Home";
  static var drawerDoctors = "Doctors";
  static var drawerBlogs = "Blogs";
  static var drawerIndicators = "Indicators";
  static var drawerProfile = "Profile";
  static var drawerLogout = "Logout";
  static var drawerShare = "Share";
  static var drawerRateUs = "Rate us";

//Blogs

  static var blogFood = "Blogs";
  static var blogFitness = "Fitness";
  static var blogLifestyle = "Lifestyle";
  static var blogDruge = "Drugs";

//Indicators
  static var indicatorDetails = "indicatorDetails";
  static var indicatorGoal = "indicatorGoal";

//Profile
  static var profileGoalSetting = "profileGoalSetting";
  static var profileDoctorFav = "profileDoctorFav";
  static var profileWeight = "profileWeight";
  static var profileOrders = "profileOrders";

//Find Doctor
  static var findDoChooseHospital = "findDoChooseHospital";
  static var findDoctor = "findDoctor";
  static var findDoctorDate = "findDoctorDate";
  static var findDoctorTime = "findDoctorTime";
  static var findDoctorBtnFind = "findDoctorBtnFind";

//Doctor's Profile

  static var doctorsProfile = "doctorsProfile";
  static var bookAppointment = "bookAppointment";
  static var personalInfo = "personalInfo";
  static var workAddress = "workAddress";
  static var reviewer = "reviewer";
  static var reviews = "reviews";

//Doctor Personal Informations
  static var informations = "informations";
  static var about = "about";
  static var addressandTiming = "addressandTiming";
  static var phone = "phone";
  static var degree = "degree";
  static var maps = "googleMap";
  static var hospital = "hospital";
  static var bookNow = "bookNow";
  static var appointmentDetails = "appointmentDetails";
  static var cancelAppointment = "cancelAppointment";
  static var orderService = "orderService";
  static var total = "total";

//Drug List and Shop
  static var drugList = "drugList";
  static var drugShop = "drugShop";

//IndicatorTest

  static var insurance = "insurance";
  static var enrollId = "enrollId";
  static var dateEffective = "dateEffective";
  static var group = "group";
  static var plan = "plan";
  static var basic = "basic";
  static var premium = "premium";
  static var indicatortest = "indicatortest";

//Indicator Details
  static var progress = "progress";
  static var min = "min";
  static var max = "max";

//Add A weight
  static var addWeight = "addWeight";

//Order List
  static var orderList = "orderList";
  static var orderNumber = "orderNumber";
  static var orderDate = "orderDate";
  static var paymentType = "paymentType";
  static var shippingAdress = "shippingAdress";
  static var pending = "pending";
  static var details = "details";

//Order Details
  static var orderDetails = "orderDetails";
  static var totlaAmountTopay = "totlaAmountTopay";
  static var deliveryAddress = "deliveryAddress";
  static var contact = "contact";
  static var deliveryArea = "deliveryArea";
  static var orderAgain = "orderAgain";

//Cart List
  static var cartList = "cartList";
  static var checkOut = "checkOut";
  static var itemNotFound = "itemNotFound";
  static var itemDeleted = "itemDeleted";

//CheckOut
  static var totalAmount = "totalAmount";
  static var discountAmount = "discountAmount";
  static var grandTotal = "grandTotal";
  static var proceedToCheckOut = "proceedToCheckOut";

//Payment Success
  static var thankYou = "thankYou";
  static var successMsg = "successMsg";
  static var haveAGreatDay = "haveAGreatDay";
  static var checkOrder = "checkOrder";
  static var notification = "notification";
  static var reply = "reply";
  static var typeHere = "typeHere";
  static var calling = "calling";

//Appointment Details

  static var overallExamition = "overallExamition";
  static var bloodTest = "bloodTest";

//DrugDetails
  static var whatIsAtomic = "whatIsAtomic";
  static var importantInfo = "importantInfo";
  static var sideEffets = "sideEffets";
  static var buyNow = "buyNow";
}

class UserDefaultKeys {
  static var isOnboarding = "isFirstTime";
}

class TextFontHeight {
  static var large = 25;
  static var extraLarge = 30;
  static var medium = 17;
  static var small = 15;
}

class PersonalInfo {
  static var name = "Jems Anderson";
  static var email = "jems_anderson007@hotmail.com";
}

class AppUrls {
  static var login =
      "https://flutter-examples.000webhostapp.com/login_user.php";
  static var sign_up =
      "https://flutter-examples.000webhostapp.com/register_user.php";
}

//AppTranslations.of(context).text(AppTitle.loginFbSignIn)

//AIzaSyD4NPvMOrW9BVCzPamcXnee7-1RQlY-OwY     IOS GOOGLE MAP API KEY
//AIzaSyAaYKc8uSif9QLBLk1v7x4SAuq4PFJJhkY      Android MAP API KEY
