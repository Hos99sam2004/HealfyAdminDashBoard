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

  /// `Doctor Booking App`
  String get appTitle {
    return Intl.message(
      'Doctor Booking App',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Booking System`
  String get headerTitle {
    return Intl.message(
      'Doctor Booking System',
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

  /// `Find the Right Doctor`
  String get onboardingTitle1 {
    return Intl.message(
      'Find the Right Doctor',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Search for trusted doctors by specialty.`
  String get onboardingDescription1 {
    return Intl.message(
      'Search for trusted doctors by specialty.',
      name: 'onboardingDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointments Easily`
  String get onboardingTitle2 {
    return Intl.message(
      'Book Appointments Easily',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Choose a suitable time and confirm your appointment.`
  String get onboardingDescription2 {
    return Intl.message(
      'Choose a suitable time and confirm your appointment.',
      name: 'onboardingDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Manage Your Health`
  String get onboardingTitle3 {
    return Intl.message(
      'Manage Your Health',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Get reminders and manage all your appointments in one place.`
  String get onboardingDescription3 {
    return Intl.message(
      'Get reminders and manage all your appointments in one place.',
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

  /// `Sign Up Successfully`
  String get signUpSuccessful {
    return Intl.message(
      'Sign Up Successfully',
      name: 'signUpSuccessful',
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

  /// `Patient`
  String get rolePatient {
    return Intl.message('Patient', name: 'rolePatient', desc: '', args: []);
  }

  /// `Doctor`
  String get roleDoctor {
    return Intl.message('Doctor', name: 'roleDoctor', desc: '', args: []);
  }

  /// `Admin`
  String get roleAdmin {
    return Intl.message('Admin', name: 'roleAdmin', desc: '', args: []);
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

  /// `Doctor Dashboard`
  String get doctorDashboardTitle {
    return Intl.message(
      'Doctor Dashboard',
      name: 'doctorDashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Doctors Management`
  String get doctorsPageTitle {
    return Intl.message(
      'Doctors Management',
      name: 'doctorsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Doctors List`
  String get doctorsListTitle {
    return Intl.message(
      'Doctors List',
      name: 'doctorsListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap a doctor to view full details.`
  String get doctorsListSubtitle {
    return Intl.message(
      'Tap a doctor to view full details.',
      name: 'doctorsListSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Details`
  String get doctorDetailsTitle {
    return Intl.message(
      'Doctor Details',
      name: 'doctorDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `About the doctor`
  String get aboutDoctor {
    return Intl.message(
      'About the doctor',
      name: 'aboutDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message('Documents', name: 'documents', desc: '', args: []);
  }

  /// `No documents available.`
  String get noDocumentsAvailable {
    return Intl.message(
      'No documents available.',
      name: 'noDocumentsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `License Number`
  String get licenseNumber {
    return Intl.message(
      'License Number',
      name: 'licenseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Years Experience`
  String get yearsExperienceLabel {
    return Intl.message(
      'Years Experience',
      name: 'yearsExperienceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Overview of medical staff and clinic details`
  String get doctorsPageSubtitle {
    return Intl.message(
      'Overview of medical staff and clinic details',
      name: 'doctorsPageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back 👋`
  String get welcomeBack {
    return Intl.message(
      'Welcome back 👋',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get ratingLabel {
    return Intl.message('Rating', name: 'ratingLabel', desc: '', args: []);
  }

  /// `{count} reviews`
  String reviewsCount(Object count) {
    return Intl.message(
      '$count reviews',
      name: 'reviewsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{years} years exp.`
  String yearsExperience(Object years) {
    return Intl.message(
      '$years years exp.',
      name: 'yearsExperience',
      desc: '',
      args: [years],
    );
  }

  /// `Quick Actions`
  String get quickActions {
    return Intl.message(
      'Quick Actions',
      name: 'quickActions',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get manageSchedule {
    return Intl.message('Schedule', name: 'manageSchedule', desc: '', args: []);
  }

  /// `Patients`
  String get patients {
    return Intl.message('Patients', name: 'patients', desc: '', args: []);
  }

  /// `Records`
  String get medicalRecords {
    return Intl.message('Records', name: 'medicalRecords', desc: '', args: []);
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `Clinic`
  String get clinic {
    return Intl.message('Clinic', name: 'clinic', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Today's Appointments`
  String get todayAppointments {
    return Intl.message(
      'Today\'s Appointments',
      name: 'todayAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message('Upcoming', name: 'upcoming', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `{count} appointments`
  String appointmentsCount(Object count) {
    return Intl.message(
      '$count appointments',
      name: 'appointmentsCount',
      desc: '',
      args: [count],
    );
  }

  /// `No appointments for today`
  String get noAppointmentsToday {
    return Intl.message(
      'No appointments for today',
      name: 'noAppointmentsToday',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get statusCompleted {
    return Intl.message(
      'Completed',
      name: 'statusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get statusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'statusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get statusConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'statusConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading dashboard`
  String get errorLoadingDashboard {
    return Intl.message(
      'An error occurred while loading dashboard',
      name: 'errorLoadingDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Complete Your Profile`
  String get completeYourProfile {
    return Intl.message(
      'Complete Your Profile',
      name: 'completeYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your profile to start receiving appointments`
  String get completeProfileSubtitle {
    return Intl.message(
      'Please complete your profile to start receiving appointments',
      name: 'completeProfileSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Let's Get Started`
  String get letsGetStarted {
    return Intl.message(
      'Let\'s Get Started',
      name: 'letsGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Start`
  String get stepStart {
    return Intl.message('Start', name: 'stepStart', desc: '', args: []);
  }

  /// `Personal`
  String get stepPersonal {
    return Intl.message('Personal', name: 'stepPersonal', desc: '', args: []);
  }

  /// `Professional`
  String get stepProfessional {
    return Intl.message(
      'Professional',
      name: 'stepProfessional',
      desc: '',
      args: [],
    );
  }

  /// `Clinic`
  String get stepClinic {
    return Intl.message('Clinic', name: 'stepClinic', desc: '', args: []);
  }

  /// `Documents`
  String get stepDocuments {
    return Intl.message('Documents', name: 'stepDocuments', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Name`
  String get doctorName {
    return Intl.message('Doctor Name', name: 'doctorName', desc: '', args: []);
  }

  /// `Doctor Phone`
  String get doctorPhone {
    return Intl.message(
      'Doctor Phone',
      name: 'doctorPhone',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Email`
  String get doctorEmail {
    return Intl.message(
      'Doctor Email',
      name: 'doctorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Avatar uploaded successfully`
  String get avatarUploadedSuccess {
    return Intl.message(
      'Avatar uploaded successfully',
      name: 'avatarUploadedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 3 characters`
  String get mustBeAtLeast3Char {
    return Intl.message(
      'Must be at least 3 characters',
      name: 'mustBeAtLeast3Char',
      desc: '',
      args: [],
    );
  }

  /// `Professional Information`
  String get professionalInformation {
    return Intl.message(
      'Professional Information',
      name: 'professionalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Specialty`
  String get specialty {
    return Intl.message('Specialty', name: 'specialty', desc: '', args: []);
  }

  /// `Please select a specialty`
  String get selectSpecialty {
    return Intl.message(
      'Please select a specialty',
      name: 'selectSpecialty',
      desc: '',
      args: [],
    );
  }

  /// `Years of Experience`
  String get yearsOfExperience {
    return Intl.message(
      'Years of Experience',
      name: 'yearsOfExperience',
      desc: '',
      args: [],
    );
  }

  /// `Years of experience is required`
  String get yearsRequired {
    return Intl.message(
      'Years of experience is required',
      name: 'yearsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number of years`
  String get enterValidYears {
    return Intl.message(
      'Enter a valid number of years',
      name: 'enterValidYears',
      desc: '',
      args: [],
    );
  }

  /// `License number is required`
  String get licenseRequired {
    return Intl.message(
      'License number is required',
      name: 'licenseRequired',
      desc: '',
      args: [],
    );
  }

  /// `Consultation Price (EGP)`
  String get consultationPrice {
    return Intl.message(
      'Consultation Price (EGP)',
      name: 'consultationPrice',
      desc: '',
      args: [],
    );
  }

  /// `Consultation price is required`
  String get priceRequired {
    return Intl.message(
      'Consultation price is required',
      name: 'priceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid price`
  String get enterValidPrice {
    return Intl.message(
      'Enter a valid price',
      name: 'enterValidPrice',
      desc: '',
      args: [],
    );
  }

  /// `About You`
  String get aboutYou {
    return Intl.message('About You', name: 'aboutYou', desc: '', args: []);
  }

  /// `About section is required`
  String get aboutRequired {
    return Intl.message(
      'About section is required',
      name: 'aboutRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter at least 10 characters`
  String get aboutMinLength {
    return Intl.message(
      'Please enter at least 10 characters',
      name: 'aboutMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Share a short professional bio`
  String get shareShortBio {
    return Intl.message(
      'Share a short professional bio',
      name: 'shareShortBio',
      desc: '',
      args: [],
    );
  }

  /// `Clinic Information`
  String get clinicInformation {
    return Intl.message(
      'Clinic Information',
      name: 'clinicInformation',
      desc: '',
      args: [],
    );
  }

  /// `Clinic Name`
  String get clinicName {
    return Intl.message('Clinic Name', name: 'clinicName', desc: '', args: []);
  }

  /// `Clinic name is required`
  String get clinicNameRequired {
    return Intl.message(
      'Clinic name is required',
      name: 'clinicNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Clinic Phone`
  String get clinicPhone {
    return Intl.message(
      'Clinic Phone',
      name: 'clinicPhone',
      desc: '',
      args: [],
    );
  }

  /// `Clinic phone is required`
  String get clinicPhoneRequired {
    return Intl.message(
      'Clinic phone is required',
      name: 'clinicPhoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Address is required`
  String get addressRequired {
    return Intl.message(
      'Address is required',
      name: 'addressRequired',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `City is required`
  String get cityRequired {
    return Intl.message(
      'City is required',
      name: 'cityRequired',
      desc: '',
      args: [],
    );
  }

  /// `Verification Documents`
  String get verificationDocuments {
    return Intl.message(
      'Verification Documents',
      name: 'verificationDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Medical License`
  String get medicalLicense {
    return Intl.message(
      'Medical License',
      name: 'medicalLicense',
      desc: '',
      args: [],
    );
  }

  /// `National ID`
  String get nationalId {
    return Intl.message('National ID', name: 'nationalId', desc: '', args: []);
  }

  /// `Graduation Certificate`
  String get graduationCertificate {
    return Intl.message(
      'Graduation Certificate',
      name: 'graduationCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Upload File`
  String get uploadFile {
    return Intl.message('Upload File', name: 'uploadFile', desc: '', args: []);
  }

  /// `I confirm that all information provided is correct and accurate.`
  String get confirmInfoCorrect {
    return Intl.message(
      'I confirm that all information provided is correct and accurate.',
      name: 'confirmInfoCorrect',
      desc: '',
      args: [],
    );
  }

  /// `Profile completed successfully`
  String get profileCompletedSuccessfully {
    return Intl.message(
      'Profile completed successfully',
      name: 'profileCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Profile Submitted Successfully!`
  String get profileSubmittedSuccessfully {
    return Intl.message(
      'Profile Submitted Successfully!',
      name: 'profileSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Go To Home`
  String get goToHome {
    return Intl.message('Go To Home', name: 'goToHome', desc: '', args: []);
  }

  /// `Profile Under Review`
  String get profileUnderReview {
    return Intl.message(
      'Profile Under Review',
      name: 'profileUnderReview',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for completing your profile. We are currently reviewing your information.`
  String get underReviewDescription {
    return Intl.message(
      'Thank you for completing your profile. We are currently reviewing your information.',
      name: 'underReviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `Contact Support`
  String get contactSupport {
    return Intl.message(
      'Contact Support',
      name: 'contactSupport',
      desc: '',
      args: [],
    );
  }

  /// `Application Rejected`
  String get applicationRejected {
    return Intl.message(
      'Application Rejected',
      name: 'applicationRejected',
      desc: '',
      args: [],
    );
  }

  /// `Unfortunately, your application was not approved at this time.`
  String get rejectedDescription {
    return Intl.message(
      'Unfortunately, your application was not approved at this time.',
      name: 'rejectedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Contact With Admin`
  String get contactWithAdmin {
    return Intl.message(
      'Contact With Admin',
      name: 'contactWithAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Hi, {name} 👋`
  String hiUser(Object name) {
    return Intl.message('Hi, $name 👋', name: 'hiUser', desc: '', args: [name]);
  }

  /// `Keep taking\ncare of your health`
  String get keepTakingCare {
    return Intl.message(
      'Keep taking\ncare of your health',
      name: 'keepTakingCare',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Service Category`
  String get serviceCategory {
    return Intl.message(
      'Service Category',
      name: 'serviceCategory',
      desc: '',
      args: [],
    );
  }

  /// `Popular Doctors`
  String get popularDoctors {
    return Intl.message(
      'Popular Doctors',
      name: 'popularDoctors',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `Doctor`
  String get doctorCategory {
    return Intl.message('Doctor', name: 'doctorCategory', desc: '', args: []);
  }

  /// `Nurse`
  String get nurseCategory {
    return Intl.message('Nurse', name: 'nurseCategory', desc: '', args: []);
  }

  /// `Drug`
  String get drugCategory {
    return Intl.message('Drug', name: 'drugCategory', desc: '', args: []);
  }

  /// `Caregiver`
  String get caregiverCategory {
    return Intl.message(
      'Caregiver',
      name: 'caregiverCategory',
      desc: '',
      args: [],
    );
  }

  /// `Descriptions`
  String get descriptions {
    return Intl.message(
      'Descriptions',
      name: 'descriptions',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message('Select Time', name: 'selectTime', desc: '', args: []);
  }

  /// `Book Appointment`
  String get bookAppointment {
    return Intl.message(
      'Book Appointment',
      name: 'bookAppointment',
      desc: '',
      args: [],
    );
  }

  /// `{distance} away`
  String kmAway(Object distance) {
    return Intl.message(
      '$distance away',
      name: 'kmAway',
      desc: '',
      args: [distance],
    );
  }

  /// `Language`
  String get changeLanguage {
    return Intl.message('Language', name: 'changeLanguage', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Go Back`
  String get goBack {
    return Intl.message('Go Back', name: 'goBack', desc: '', args: []);
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Clinic Info`
  String get editClinicInfo {
    return Intl.message(
      'Edit Clinic Info',
      name: 'editClinicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `Are you sure you want to sign out?`
  String get signOutConfirm {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Min 8 characters`
  String get min8Characters {
    return Intl.message(
      'Min 8 characters',
      name: 'min8Characters',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully!`
  String get passwordChangedSuccess {
    return Intl.message(
      'Password changed successfully!',
      name: 'passwordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Save Clinic`
  String get saveClinic {
    return Intl.message('Save Clinic', name: 'saveClinic', desc: '', args: []);
  }

  /// `Electronic Prescription`
  String get electronicPrescription {
    return Intl.message(
      'Electronic Prescription',
      name: 'electronicPrescription',
      desc: '',
      args: [],
    );
  }

  /// `Prescriptions`
  String get prescriptions {
    return Intl.message(
      'Prescriptions',
      name: 'prescriptions',
      desc: '',
      args: [],
    );
  }

  /// `Add Prescription`
  String get addPrescription {
    return Intl.message(
      'Add Prescription',
      name: 'addPrescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Medicine`
  String get addMedicine {
    return Intl.message(
      'Add Medicine',
      name: 'addMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name`
  String get medicineName {
    return Intl.message(
      'Medicine Name',
      name: 'medicineName',
      desc: '',
      args: [],
    );
  }

  /// `Dosage`
  String get dosage {
    return Intl.message('Dosage', name: 'dosage', desc: '', args: []);
  }

  /// `Frequency`
  String get frequency {
    return Intl.message('Frequency', name: 'frequency', desc: '', args: []);
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `Add Record`
  String get addRecord {
    return Intl.message('Add Record', name: 'addRecord', desc: '', args: []);
  }

  /// `Diagnosis`
  String get diagnosis {
    return Intl.message('Diagnosis', name: 'diagnosis', desc: '', args: []);
  }

  /// `Symptoms`
  String get symptoms {
    return Intl.message('Symptoms', name: 'symptoms', desc: '', args: []);
  }

  /// `Treatment Plan`
  String get treatmentPlan {
    return Intl.message(
      'Treatment Plan',
      name: 'treatmentPlan',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Schedule`
  String get schedule {
    return Intl.message('Schedule', name: 'schedule', desc: '', args: []);
  }

  /// `Select Day`
  String get selectDay {
    return Intl.message('Select Day', name: 'selectDay', desc: '', args: []);
  }

  /// `Add Time Slot`
  String get addTimeSlot {
    return Intl.message(
      'Add Time Slot',
      name: 'addTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  /// `Payment Summary`
  String get payment_summary {
    return Intl.message(
      'Payment Summary',
      name: 'payment_summary',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card`
  String get credit_card {
    return Intl.message('Credit Card', name: 'credit_card', desc: '', args: []);
  }

  /// `Cash`
  String get cash {
    return Intl.message('Cash', name: 'cash', desc: '', args: []);
  }

  /// `Processing Payment...`
  String get processing_payment {
    return Intl.message(
      'Processing Payment...',
      name: 'processing_payment',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful`
  String get payment_success {
    return Intl.message(
      'Payment Successful',
      name: 'payment_success',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get payment_failed {
    return Intl.message(
      'Payment Failed',
      name: 'payment_failed',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Pay Now`
  String get pay_now {
    return Intl.message('Pay Now', name: 'pay_now', desc: '', args: []);
  }

  /// `Booking Summary`
  String get booking_summary {
    return Intl.message(
      'Booking Summary',
      name: 'booking_summary',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Confirmed`
  String get appointment_confirmed {
    return Intl.message(
      'Appointment Confirmed',
      name: 'appointment_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Platform Fee`
  String get platform_fee {
    return Intl.message(
      'Platform Fee',
      name: 'platform_fee',
      desc: '',
      args: [],
    );
  }

  /// `Patient Fee`
  String get patient_fee {
    return Intl.message('Patient Fee', name: 'patient_fee', desc: '', args: []);
  }

  /// `Doctor Fee`
  String get doctor_fee {
    return Intl.message('Doctor Fee', name: 'doctor_fee', desc: '', args: []);
  }

  /// `Consultation Price`
  String get consultation_price {
    return Intl.message(
      'Consultation Price',
      name: 'consultation_price',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get total_amount {
    return Intl.message(
      'Total Amount',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Net Amount`
  String get net_amount {
    return Intl.message('Net Amount', name: 'net_amount', desc: '', args: []);
  }

  /// `You Receive`
  String get you_receive {
    return Intl.message('You Receive', name: 'you_receive', desc: '', args: []);
  }

  /// `EGP`
  String get currency {
    return Intl.message('EGP', name: 'currency', desc: '', args: []);
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
