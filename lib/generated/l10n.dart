// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Contact`
  String get contact {
    return Intl.message('Contact', name: 'contact', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Search for products`
  String get search {
    return Intl.message(
      'Search for products',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get emptyCart {
    return Intl.message(
      'Your cart is empty',
      name: 'emptyCart',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `EGP`
  String get egp {
    return Intl.message('EGP', name: 'egp', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addCart {
    return Intl.message('Add to Cart', name: 'addCart', desc: '', args: []);
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message('Total Price', name: 'totalPrice', desc: '', args: []);
  }

  /// `Shipping Fees`
  String get shippingFees {
    return Intl.message(
      'Shipping Fees',
      name: 'shippingFees',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message('Place Order', name: 'placeOrder', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone {
    return Intl.message('Phone Number', name: 'phone', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Promo Code`
  String get promoCode {
    return Intl.message('Promo Code', name: 'promoCode', desc: '', args: []);
  }

  /// `Apply Promo Code`
  String get applyPromoCode {
    return Intl.message(
      'Apply Promo Code',
      name: 'applyPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `Final Price`
  String get finalPrice {
    return Intl.message('Final Price', name: 'finalPrice', desc: '', args: []);
  }

  /// `Confirm Order`
  String get confirmOrder {
    return Intl.message(
      'Confirm Order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get pleasFill {
    return Intl.message(
      'Please fill all fields',
      name: 'pleasFill',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Phone Number`
  String get invalidPhone {
    return Intl.message(
      'Invalid Phone Number',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Promo Code`
  String get invalidPromoCode {
    return Intl.message(
      'Invalid Promo Code',
      name: 'invalidPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `Order Confirmed`
  String get orderConfirmed {
    return Intl.message(
      'Order Confirmed',
      name: 'orderConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Promo Code`
  String get pleaseEnterPromoCode {
    return Intl.message(
      'Please Enter Promo Code',
      name: 'pleaseEnterPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `Added to Cart`
  String get addedToCart {
    return Intl.message(
      'Added to Cart',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Removed from Cart`
  String get removedFromCart {
    return Intl.message(
      'Removed from Cart',
      name: 'removedFromCart',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalamount {
    return Intl.message(
      'Total Amount',
      name: 'totalamount',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Enter Promo Code`
  String get enterPromoCode {
    return Intl.message(
      'Enter Promo Code',
      name: 'enterPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `Order Placed Successfully`
  String get orderPlacedSuccessfully {
    return Intl.message(
      'Order Placed Successfully',
      name: 'orderPlacedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Failed To Load Data`
  String get faildToLoadData {
    return Intl.message(
      'Failed To Load Data',
      name: 'faildToLoadData',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Add To Cart`
  String get faildToAddToCart {
    return Intl.message(
      'Failed To Add To Cart',
      name: 'faildToAddToCart',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Load Cart`
  String get faildToLoadcart {
    return Intl.message(
      'Failed To Load Cart',
      name: 'faildToLoadcart',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Place Order`
  String get faildToPlaceOrder {
    return Intl.message(
      'Failed To Place Order',
      name: 'faildToPlaceOrder',
      desc: '',
      args: [],
    );
  }

  /// `Promo code is expired or not yet active.`
  String get promoCodeExpi {
    return Intl.message(
      'Promo code is expired or not yet active.',
      name: 'promoCodeExpi',
      desc: '',
      args: [],
    );
  }

  /// `Promo code has reached its maximum usage limit.`
  String get promoReached {
    return Intl.message(
      'Promo code has reached its maximum usage limit.',
      name: 'promoReached',
      desc: '',
      args: [],
    );
  }

  /// `Failed to validate promo code`
  String get promoCodeValidate {
    return Intl.message(
      'Failed to validate promo code',
      name: 'promoCodeValidate',
      desc: '',
      args: [],
    );
  }

  /// `Follow us on Instagram`
  String get followUs {
    return Intl.message(
      'Follow us on Instagram',
      name: 'followUs',
      desc: '',
      args: [],
    );
  }

  /// `Problem Description`
  String get problemDes {
    return Intl.message(
      'Problem Description',
      name: 'problemDes',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
