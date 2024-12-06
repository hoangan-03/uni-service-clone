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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Flutter`
  String get message {
    return Intl.message(
      'Welcome to Flutter',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message(
      'Continue',
      name: 'continue_text',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Back to home`
  String get back_to_home {
    return Intl.message(
      'Back to home',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet {
    return Intl.message(
      'No internet connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with email`
  String get sign_up_by_email {
    return Intl.message(
      'Sign up with email',
      name: 'sign_up_by_email',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter email address`
  String get enter_email_address {
    return Intl.message(
      'Enter email address',
      name: 'enter_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get send_otp {
    return Intl.message(
      'Send OTP',
      name: 'send_otp',
      desc: '',
      args: [],
    );
  }

  /// `Register information`
  String get register_info {
    return Intl.message(
      'Register information',
      name: 'register_info',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enter_password {
    return Intl.message(
      'Enter password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters`
  String get at_least_8_characters {
    return Intl.message(
      'At least 8 characters',
      name: 'at_least_8_characters',
      desc: '',
      args: [],
    );
  }

  /// `No spaces allowed`
  String get not_included_space {
    return Intl.message(
      'No spaces allowed',
      name: 'not_included_space',
      desc: '',
      args: [],
    );
  }

  /// `Include uppercase, lowercase, number, special character`
  String get included_uppercase_lowercase_number_special_character {
    return Intl.message(
      'Include uppercase, lowercase, number, special character',
      name: 'included_uppercase_lowercase_number_special_character',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter password`
  String get enter_confirm_password {
    return Intl.message(
      'Re-enter password',
      name: 'enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_mismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'password_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get display_name {
    return Intl.message(
      'Display name',
      name: 'display_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter display name`
  String get enter_display_name {
    return Intl.message(
      'Enter display name',
      name: 'enter_display_name',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Enter birthday`
  String get enter_birthday {
    return Intl.message(
      'Enter birthday',
      name: 'enter_birthday',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter email`
  String get enter_email {
    return Intl.message(
      'Enter email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enter_phone_number {
    return Intl.message(
      'Enter phone number',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful`
  String get success_register {
    return Intl.message(
      'Registration successful',
      name: 'success_register',
      desc: '',
      args: [],
    );
  }

  /// `Log in to use the app`
  String get login_to_use_app {
    return Intl.message(
      'Log in to use the app',
      name: 'login_to_use_app',
      desc: '',
      args: [],
    );
  }

  /// `OTP has been sent to your email`
  String get otp_has_been_sent {
    return Intl.message(
      'OTP has been sent to your email',
      name: 'otp_has_been_sent',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email?`
  String get wrong_email {
    return Intl.message(
      'Wrong email?',
      name: 'wrong_email',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change_email {
    return Intl.message(
      'Change',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resend_otp {
    return Intl.message(
      'Resend OTP',
      name: 'resend_otp',
      desc: '',
      args: [],
    );
  }

  /// `Email or phone number`
  String get email_or_phone {
    return Intl.message(
      'Email or phone number',
      name: 'email_or_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter email or phone number`
  String get enter_email_or_phone {
    return Intl.message(
      'Enter email or phone number',
      name: 'enter_email_or_phone',
      desc: '',
      args: [],
    );
  }

  /// `Login information`
  String get login_info {
    return Intl.message(
      'Login information',
      name: 'login_info',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect login details`
  String get wrong_info {
    return Intl.message(
      'Incorrect login details',
      name: 'wrong_info',
      desc: '',
      args: [],
    );
  }

  /// `Please enter again or contact the office`
  String get request_enter_again {
    return Intl.message(
      'Please enter again or contact the office',
      name: 'request_enter_again',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Contact office`
  String get contact_office {
    return Intl.message(
      'Contact office',
      name: 'contact_office',
      desc: '',
      args: [],
    );
  }

  /// `Account information`
  String get account_info {
    return Intl.message(
      'Account information',
      name: 'account_info',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Contribute feedback`
  String get contribute_opinion {
    return Intl.message(
      'Contribute feedback',
      name: 'contribute_opinion',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of service`
  String get terms_of_use {
    return Intl.message(
      'Terms of service',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Current balance`
  String get current_money {
    return Intl.message(
      'Current balance',
      name: 'current_money',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message(
      'Deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `Change image from`
  String get change_image_from {
    return Intl.message(
      'Change image from',
      name: 'change_image_from',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Confirm logout`
  String get confirm_logout {
    return Intl.message(
      'Confirm logout',
      name: 'confirm_logout',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullname {
    return Intl.message(
      'Full name',
      name: 'fullname',
      desc: '',
      args: [],
    );
  }

  /// `Enter full name`
  String get enter_fullname {
    return Intl.message(
      'Enter full name',
      name: 'enter_fullname',
      desc: '',
      args: [],
    );
  }

  /// `ID card number`
  String get identity_card {
    return Intl.message(
      'ID card number',
      name: 'identity_card',
      desc: '',
      args: [],
    );
  }

  /// `Enter ID card number`
  String get enter_identity_card {
    return Intl.message(
      'Enter ID card number',
      name: 'enter_identity_card',
      desc: '',
      args: [],
    );
  }

  /// `School`
  String get school {
    return Intl.message(
      'School',
      name: 'school',
      desc: '',
      args: [],
    );
  }

  /// `Enter school`
  String get enter_school {
    return Intl.message(
      'Enter school',
      name: 'enter_school',
      desc: '',
      args: [],
    );
  }

  /// `Faculty`
  String get faculty {
    return Intl.message(
      'Faculty',
      name: 'faculty',
      desc: '',
      args: [],
    );
  }

  /// `Enter faculty`
  String get enter_faculty {
    return Intl.message(
      'Enter faculty',
      name: 'enter_faculty',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get position {
    return Intl.message(
      'Position',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `Enter position`
  String get enter_position {
    return Intl.message(
      'Enter position',
      name: 'enter_position',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Enter role`
  String get enter_role {
    return Intl.message(
      'Enter role',
      name: 'enter_role',
      desc: '',
      args: [],
    );
  }

  /// `Update information`
  String get update_info {
    return Intl.message(
      'Update information',
      name: 'update_info',
      desc: '',
      args: [],
    );
  }

  /// `Information updated successfully`
  String get update_success {
    return Intl.message(
      'Information updated successfully',
      name: 'update_success',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Face ID`
  String get face_id {
    return Intl.message(
      'Face ID',
      name: 'face_id',
      desc: '',
      args: [],
    );
  }

  /// `PIN number`
  String get pin_number {
    return Intl.message(
      'PIN number',
      name: 'pin_number',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Display selected language`
  String get show_lang {
    return Intl.message(
      'Display selected language',
      name: 'show_lang',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_pass {
    return Intl.message(
      'Change password',
      name: 'change_pass',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get change_pin {
    return Intl.message(
      'Change PIN',
      name: 'change_pin',
      desc: '',
      args: [],
    );
  }

  /// `Display selected language`
  String get show_selected_lang {
    return Intl.message(
      'Display selected language',
      name: 'show_selected_lang',
      desc: '',
      args: [],
    );
  }

  /// `Use Face ID to log in`
  String get use_face_id {
    return Intl.message(
      'Use Face ID to log in',
      name: 'use_face_id',
      desc: '',
      args: [],
    );
  }

  /// `The change will take effect when you restart the app`
  String get change_dark_mode {
    return Intl.message(
      'The change will take effect when you restart the app',
      name: 'change_dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Add information`
  String get add_info {
    return Intl.message(
      'Add information',
      name: 'add_info',
      desc: '',
      args: [],
    );
  }

  /// `Deposit successful`
  String get deposit_success {
    return Intl.message(
      'Deposit successful',
      name: 'deposit_success',
      desc: '',
      args: [],
    );
  }

  /// `Transfer successful`
  String get transfer_success {
    return Intl.message(
      'Transfer successful',
      name: 'transfer_success',
      desc: '',
      args: [],
    );
  }

  /// `0`
  String get zero {
    return Intl.message(
      '0',
      name: 'zero',
      desc: '',
      args: [],
    );
  }

  /// `********`
  String get hidden_star {
    return Intl.message(
      '********',
      name: 'hidden_star',
      desc: '',
      args: [],
    );
  }

  /// `50,000`
  String get fifty_thousand {
    return Intl.message(
      '50,000',
      name: 'fifty_thousand',
      desc: '',
      args: [],
    );
  }

  /// `100,000`
  String get one_hundred_thousand {
    return Intl.message(
      '100,000',
      name: 'one_hundred_thousand',
      desc: '',
      args: [],
    );
  }

  /// `200,000`
  String get two_hundred_thousand {
    return Intl.message(
      '200,000',
      name: 'two_hundred_thousand',
      desc: '',
      args: [],
    );
  }

  /// `500,000`
  String get five_hundred_thousand {
    return Intl.message(
      '500,000',
      name: 'five_hundred_thousand',
      desc: '',
      args: [],
    );
  }

  /// `1,000,000`
  String get one_million {
    return Intl.message(
      '1,000,000',
      name: 'one_million',
      desc: '',
      args: [],
    );
  }

  /// `2,000,000`
  String get two_million {
    return Intl.message(
      '2,000,000',
      name: 'two_million',
      desc: '',
      args: [],
    );
  }

  /// `Today's menu`
  String get current_menu {
    return Intl.message(
      'Today\'s menu',
      name: 'current_menu',
      desc: '',
      args: [],
    );
  }

  /// `Choose tomorrow's menu`
  String get choose_menu_tomorrow {
    return Intl.message(
      'Choose tomorrow\'s menu',
      name: 'choose_menu_tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Drink`
  String get drink {
    return Intl.message(
      'Drink',
      name: 'drink',
      desc: '',
      args: [],
    );
  }

  /// `Food Court`
  String get foodcourt {
    return Intl.message(
      'Food Court',
      name: 'foodcourt',
      desc: '',
      args: [],
    );
  }

  /// `Local delicacies`
  String get local_food {
    return Intl.message(
      'Local delicacies',
      name: 'local_food',
      desc: '',
      args: [],
    );
  }

  /// `Essentials`
  String get neccessities {
    return Intl.message(
      'Essentials',
      name: 'neccessities',
      desc: '',
      args: [],
    );
  }

  /// `View menu`
  String get view_menu {
    return Intl.message(
      'View menu',
      name: 'view_menu',
      desc: '',
      args: [],
    );
  }

  /// `Main menu`
  String get main_menu {
    return Intl.message(
      'Main menu',
      name: 'main_menu',
      desc: '',
      args: [],
    );
  }

  /// `Option`
  String get option {
    return Intl.message(
      'Option',
      name: 'option',
      desc: '',
      args: [],
    );
  }

  /// `Choose food`
  String get choose_food {
    return Intl.message(
      'Choose food',
      name: 'choose_food',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Edit order`
  String get edit_order {
    return Intl.message(
      'Edit order',
      name: 'edit_order',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Total price`
  String get total_price {
    return Intl.message(
      'Total price',
      name: 'total_price',
      desc: '',
      args: [],
    );
  }

  /// `Make payment`
  String get make_payment {
    return Intl.message(
      'Make payment',
      name: 'make_payment',
      desc: '',
      args: [],
    );
  }

  /// `Order placed successfully`
  String get order_success {
    return Intl.message(
      'Order placed successfully',
      name: 'order_success',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message(
      'Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `Expired date: `
  String get expired_date {
    return Intl.message(
      'Expired date: ',
      name: 'expired_date',
      desc: '',
      args: [],
    );
  }

  /// `Not delivered`
  String get not_delivered {
    return Intl.message(
      'Not delivered',
      name: 'not_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Bill ID: `
  String get bill_id {
    return Intl.message(
      'Bill ID: ',
      name: 'bill_id',
      desc: '',
      args: [],
    );
  }

  /// `Order details`
  String get order_detail {
    return Intl.message(
      'Order details',
      name: 'order_detail',
      desc: '',
      args: [],
    );
  }

  /// `Order not received`
  String get not_received_order {
    return Intl.message(
      'Order not received',
      name: 'not_received_order',
      desc: '',
      args: [],
    );
  }

  /// `Empty cart`
  String get empty_cart {
    return Intl.message(
      'Empty cart',
      name: 'empty_cart',
      desc: '',
      args: [],
    );
  }

  /// `Choose branch`
  String get choose_branch {
    return Intl.message(
      'Choose branch',
      name: 'choose_branch',
      desc: '',
      args: [],
    );
  }

  /// `6134edff-d5cc-4dbc-be51-4c914bfded16`
  String get default_branch {
    return Intl.message(
      '6134edff-d5cc-4dbc-be51-4c914bfded16',
      name: 'default_branch',
      desc: '',
      args: [],
    );
  }

  /// `Cheap bus tickets`
  String get vexere {
    return Intl.message(
      'Cheap bus tickets',
      name: 'vexere',
      desc: '',
      args: [],
    );
  }

  /// `Btaskee`
  String get btaskee {
    return Intl.message(
      'Btaskee',
      name: 'btaskee',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code`
  String get scan_qr {
    return Intl.message(
      'Scan QR code',
      name: 'scan_qr',
      desc: '',
      args: [],
    );
  }

  /// `Transaction history`
  String get transaction_history {
    return Intl.message(
      'Transaction history',
      name: 'transaction_history',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Deposit money`
  String get deposit_money {
    return Intl.message(
      'Deposit money',
      name: 'deposit_money',
      desc: '',
      args: [],
    );
  }

  /// `Send/receive money`
  String get transfer_or_get_money {
    return Intl.message(
      'Send/receive money',
      name: 'transfer_or_get_money',
      desc: '',
      args: [],
    );
  }

  /// `Transfer money`
  String get transfer_money {
    return Intl.message(
      'Transfer money',
      name: 'transfer_money',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `No transactions found`
  String get no_transactions_found {
    return Intl.message(
      'No transactions found',
      name: 'no_transactions_found',
      desc: '',
      args: [],
    );
  }

  /// `Transfer details`
  String get transfer_detail {
    return Intl.message(
      'Transfer details',
      name: 'transfer_detail',
      desc: '',
      args: [],
    );
  }

  /// `Recipient`
  String get recipient {
    return Intl.message(
      'Recipient',
      name: 'recipient',
      desc: '',
      args: [],
    );
  }

  /// `Enter recipient`
  String get enter_recipient {
    return Intl.message(
      'Enter recipient',
      name: 'enter_recipient',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Enter amount`
  String get enter_amount {
    return Intl.message(
      'Enter amount',
      name: 'enter_amount',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone {
    return Intl.message(
      'Phone number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enter_phone {
    return Intl.message(
      'Enter phone number',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Status: `
  String get status {
    return Intl.message(
      'Status: ',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Book ticket`
  String get book_ticket {
    return Intl.message(
      'Book ticket',
      name: 'book_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Create PIN`
  String get create_pin {
    return Intl.message(
      'Create PIN',
      name: 'create_pin',
      desc: '',
      args: [],
    );
  }

  /// `Enter PIN`
  String get enter_pin {
    return Intl.message(
      'Enter PIN',
      name: 'enter_pin',
      desc: '',
      args: [],
    );
  }

  /// `Enter old PIN`
  String get enter_old_pin {
    return Intl.message(
      'Enter old PIN',
      name: 'enter_old_pin',
      desc: '',
      args: [],
    );
  }

  /// `Enter new PIN`
  String get enter_new_pin {
    return Intl.message(
      'Enter new PIN',
      name: 'enter_new_pin',
      desc: '',
      args: [],
    );
  }

  /// `Confirm PIN`
  String get confirm_pin {
    return Intl.message(
      'Confirm PIN',
      name: 'confirm_pin',
      desc: '',
      args: [],
    );
  }

  /// `PIN mismatch`
  String get pin_mismatch {
    return Intl.message(
      'PIN mismatch',
      name: 'pin_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `Enter current PIN`
  String get enter_current_pin {
    return Intl.message(
      'Enter current PIN',
      name: 'enter_current_pin',
      desc: '',
      args: [],
    );
  }

  /// `PIN created successfully`
  String get success_create_pin {
    return Intl.message(
      'PIN created successfully',
      name: 'success_create_pin',
      desc: '',
      args: [],
    );
  }

  /// `PIN updated successfully`
  String get success_change_pin {
    return Intl.message(
      'PIN updated successfully',
      name: 'success_change_pin',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get empty {
    return Intl.message(
      '',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `john12052003@gmail.com`
  String get myEmail {
    return Intl.message(
      'john12052003@gmail.com',
      name: 'myEmail',
      desc: '',
      args: [],
    );
  }

  /// `Uni Service BK`
  String get defaultBranchName {
    return Intl.message(
      'Uni Service BK',
      name: 'defaultBranchName',
      desc: '',
      args: [],
    );
  }

  /// `https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360`
  String get defaultAvatar {
    return Intl.message(
      'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
      name: 'defaultAvatar',
      desc: '',
      args: [],
    );
  }

  /// `assets/images/scan.png`
  String get scan {
    return Intl.message(
      'assets/images/scan.png',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `https://storage.googleapis.com/blogvxr-uploads/2022/08/PO-6.png`
  String get vexereurl {
    return Intl.message(
      'https://storage.googleapis.com/blogvxr-uploads/2022/08/PO-6.png',
      name: 'vexereurl',
      desc: '',
      args: [],
    );
  }

  /// `https://employer.jobsgo.vn/uploads/media/img/201911/pictures_library_19108_20191118143305_8696.png`
  String get btaskeeurl {
    return Intl.message(
      'https://employer.jobsgo.vn/uploads/media/img/201911/pictures_library_19108_20191118143305_8696.png',
      name: 'btaskeeurl',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect current password`
  String get incorrect_current_password {
    return Intl.message(
      'Incorrect current password',
      name: 'incorrect_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Retype current password`
  String get retype_current_password {
    return Intl.message(
      'Retype current password',
      name: 'retype_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enter_new_password {
    return Intl.message(
      'Enter new password',
      name: 'enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm new password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get success_change_password {
    return Intl.message(
      'Password changed successfully',
      name: 'success_change_password',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
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
