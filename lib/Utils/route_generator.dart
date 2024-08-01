 import 'package:clothapp/Views/order/order_page.dart';
import 'package:clothapp/Views/settings/setting_page.dart';
import 'package:get/get.dart';
import '../Views/Cart/cartitempage.dart';
import '../Views/Home/home_screen.dart';
import '../Views/Item/item_details_page.dart';
import '../Views/Cart/cart_page.dart';
import '../Views/Auth/login_screen.dart';
import '../Views/Auth/signup_screen.dart';
import '../Views/SplashScreen/splash_screen.dart';
import '../Views/address/address_page.dart';
import '../Views/favpage/fav_page.dart';
import '../Views/checkout/checkout_page.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: '/', page: () => SplashScreen()),
      GetPage(name: '/login', page: () => LoginScreen()),
      GetPage(name: '/logout', page: () => LoginScreen()),
      GetPage(name: '/signup', page: () => SignupScreen()),
      GetPage(name: '/home', page: () => HomeScreen()),
      GetPage(name: '/itemDetails', page: () => ItemDetailPage()),  
      GetPage(name: '/cart', page: () => CartPage()),
      GetPage(name: '/fav', page: () => FavPage()),
      GetPage(name: '/checkout', page: () => CheckoutPage()),
      GetPage(name: '/cartitem', page: () => Cartitempage()),
      GetPage(name: '/upi_payment', page: () => Cartitempage()),
      GetPage(name: '/net_banking_payment', page: () => Cartitempage()),
      GetPage(name: '/address', page: () =>AddressScreen()),
      GetPage(name: '/orders', page: () =>OrderPage()),
      GetPage(name: '/settings', page: () =>SettingPage()),

    ];
  }
}
