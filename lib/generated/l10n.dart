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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Student Attendance App`
  String get appTitle {
    return Intl.message(
      'Student Attendance App',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Intelligence Attendance System`
  String get headerTitle {
    return Intl.message(
      'Intelligence Attendance System',
      name: 'headerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get headerSubtitle {
    return Intl.message(
      'Get Started',
      name: 'headerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Attendance App`
  String get onboardingTitle1 {
    return Intl.message(
      'Attendance App',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Easily track your attendance and stay organized with My Attendance app.`
  String get onboardingDescription1 {
    return Intl.message(
      'Easily track your attendance and stay organized with My Attendance app.',
      name: 'onboardingDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Student Attendance Management`
  String get onboardingTitle2 {
    return Intl.message(
      'Student Attendance Management',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `• Enter your personal data. \n• Scan the QR code. \n• Automatically record attendance. \n• Fast and easy.`
  String get onboardingDescription2 {
    return Intl.message(
      '• Enter your personal data. \n• Scan the QR code. \n• Automatically record attendance. \n• Fast and easy.',
      name: 'onboardingDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Teacher Attendance`
  String get onboardingTitle3 {
    return Intl.message(
      'Teacher Attendance',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `• Create attendance sessions. \n• Display QR code for students. \n• Monitor attendance in real-time. \n• Save records. \n• Ease of access for students.`
  String get onboardingDescription3 {
    return Intl.message(
      '• Create attendance sessions. \n• Display QR code for students. \n• Monitor attendance in real-time. \n• Save records. \n• Ease of access for students.',
      name: 'onboardingDescription3',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get onboardingNext {
    return Intl.message('Next', name: 'onboardingNext', desc: '', args: []);
  }

  /// `Get Started`
  String get onboardingGetStarted {
    return Intl.message(
      'Get Started',
      name: 'onboardingGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Enter your email address`
  String get emailHint {
    return Intl.message(
      'Enter your email address',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get emailRequired {
    return Intl.message(
      'Please enter your email address',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get emailInvalid {
    return Intl.message(
      'Please enter a valid email address',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Enter your password`
  String get passwordHint {
    return Intl.message(
      'Enter your password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get passwordRequired {
    return Intl.message(
      'Please enter your password',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordTooShort {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Login Successfully`
  String get loginSuccessful {
    return Intl.message(
      'Login Successfully',
      name: 'loginSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `If you don't have an account,`
  String get noAccount {
    return Intl.message(
      'If you don\'t have an account,',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullNameLabel {
    return Intl.message('Full Name', name: 'fullNameLabel', desc: '', args: []);
  }

  /// `Please enter your full name`
  String get fullNameRequired {
    return Intl.message(
      'Please enter your full name',
      name: 'fullNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Student Name`
  String get studentNameTitle {
    return Intl.message(
      'Student Name',
      name: 'studentNameTitle',
      desc: '',
      args: [],
    );
  }

  /// `Student ID`
  String get studentIdTitle {
    return Intl.message(
      'Student ID',
      name: 'studentIdTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddressLabel {
    return Intl.message(
      'Email Address',
      name: 'emailAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordTooShortSignUp {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordTooShortSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passwordUppercaseRequired {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passwordUppercaseRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get passwordSpecialCharRequired {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'passwordSpecialCharRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumberLabel {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get phoneRequired {
    return Intl.message(
      'Please enter your phone number',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get phoneInvalid {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'phoneInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 11 digits`
  String get phoneLengthInvalid {
    return Intl.message(
      'Phone number must be 11 digits',
      name: 'phoneLengthInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Select Role`
  String get selectRoleHint {
    return Intl.message(
      'Select Role',
      name: 'selectRoleHint',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get roleStudent {
    return Intl.message('Student', name: 'roleStudent', desc: '', args: []);
  }

  /// `Teacher`
  String get roleTeacher {
    return Intl.message('Teacher', name: 'roleTeacher', desc: '', args: []);
  }

  /// `Name :: `
  String get namePrefix {
    return Intl.message('Name :: ', name: 'namePrefix', desc: '', args: []);
  }

  /// `Email :: `
  String get emailPrefix {
    return Intl.message('Email :: ', name: 'emailPrefix', desc: '', args: []);
  }

  /// `ID :: `
  String get idPrefix {
    return Intl.message('ID :: ', name: 'idPrefix', desc: '', args: []);
  }

  /// `Phone :: `
  String get phonePrefix {
    return Intl.message('Phone :: ', name: 'phonePrefix', desc: '', args: []);
  }

  /// `Role :: `
  String get rolePrefix {
    return Intl.message('Role :: ', name: 'rolePrefix', desc: '', args: []);
  }

  /// `Failed to get profile`
  String get profileFailedGet {
    return Intl.message(
      'Failed to get profile',
      name: 'profileFailedGet',
      desc: '',
      args: [],
    );
  }

  /// `Profile loaded successfully`
  String get profileGetSuccess {
    return Intl.message(
      'Profile loaded successfully',
      name: 'profileGetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Profile image updated successfully`
  String get profileImageUpdatedSuccess {
    return Intl.message(
      'Profile image updated successfully',
      name: 'profileImageUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile`
  String get profileUpdateFailed {
    return Intl.message(
      'Failed to update profile',
      name: 'profileUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Failed to load profile`
  String get failedToLoadProfile {
    return Intl.message(
      'Failed to load profile',
      name: 'failedToLoadProfile',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Contact Teacher`
  String get contactTeacher {
    return Intl.message(
      'Contact Teacher',
      name: 'contactTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Your Message`
  String get yourMessageLabel {
    return Intl.message(
      'Your Message',
      name: 'yourMessageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get sendMessage {
    return Intl.message(
      'Send Message',
      name: 'sendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Message sent successfully`
  String get messageSentSuccessfully {
    return Intl.message(
      'Message sent successfully',
      name: 'messageSentSuccessfully',
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
