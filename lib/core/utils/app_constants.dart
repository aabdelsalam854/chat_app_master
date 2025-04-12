import 'package:chat_master/core/extensions/size.dart';
import 'package:flutter/material.dart';


class AppConstants {
  static const String fontFamilyAr = 'DroidKufi';
  static const String fontFamilyEn = 'IBMPlexSans';
  // static String fontFamily = isArabic ? fontFamilyAr : fontFamilyEn;
  static customConstraints(double h) => BoxConstraints(
        minHeight: h,
        maxHeight: h,
        maxWidth: 100.w,
        minWidth: 100.w,
      );
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  static final navigatorKey = GlobalKey<NavigatorState>();
}

class SharedPrefKeys {
  static const String kCartKey = "CartKey";
  static const String kBannerKey = "BannerKey";
  static const String kSliderKey = "SliderKey";
  static const String kOrdersKey = "OrdersKey";
  static const String kTablesKey = "TablesKey";
  static const String kOffersKey = "OffersKey";
  static const String kPaymentKey = "PaymentKey";
  static const String kProfileKey = "ProfileKey";
  static const String kCouponsKey = "CouponsKey";
  static const String kSettingsKey = "SettingsKey";
  static const String kProductsKey = "ProductsKey";
  static const String kFavoritesKey = "FavoritesKey";
  static const String kAddressesKey = "AddressesKey";
  static const String kCategoriesKey = "CategoriesKey";
  static const String kRestaurantsKey = "RestaurantsKey";
  static const String kNotificationsKey = "NotificationsKey";
}
