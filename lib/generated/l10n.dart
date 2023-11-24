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

  /// `Enter your`
  String get enter_your {
    return Intl.message(
      'Enter your',
      name: 'enter_your',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account yet\t？`
  String get hn_account {
    return Intl.message(
      'Don\'t have an account yet\t？',
      name: 'hn_account',
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

  /// `Step `
  String get step {
    return Intl.message(
      'Step ',
      name: 'step',
      desc: '',
      args: [],
    );
  }

  /// `Functions`
  String get fun {
    return Intl.message(
      'Functions',
      name: 'fun',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcome {
    return Intl.message(
      'Welcome back',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Enter account name`
  String get en_account_name {
    return Intl.message(
      'Enter account name',
      name: 'en_account_name',
      desc: '',
      args: [],
    );
  }

  /// `Next step`
  String get next_step {
    return Intl.message(
      'Next step',
      name: 'next_step',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your account name\nto continue to the next step`
  String get in_a {
    return Intl.message(
      'Please enter your account name\nto continue to the next step',
      name: 'in_a',
      desc: '',
      args: [],
    );
  }

  /// `Set your password`
  String get set_pass {
    return Intl.message(
      'Set your password',
      name: 'set_pass',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get en_pass {
    return Intl.message(
      'Enter password',
      name: 'en_pass',
      desc: '',
      args: [],
    );
  }

  /// `Enter a strong password that is\nsufficient to protect your account`
  String get st_pass {
    return Intl.message(
      'Enter a strong password that is\nsufficient to protect your account',
      name: 'st_pass',
      desc: '',
      args: [],
    );
  }

  /// `What is your gender?`
  String get you_gender {
    return Intl.message(
      'What is your gender?',
      name: 'you_gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `What is your weight?`
  String get your_weight {
    return Intl.message(
      'What is your weight?',
      name: 'your_weight',
      desc: '',
      args: [],
    );
  }

  /// `What is your height?`
  String get your_height {
    return Intl.message(
      'What is your height?',
      name: 'your_height',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get reg {
    return Intl.message(
      'Register',
      name: 'reg',
      desc: '',
      args: [],
    );
  }

  /// `Hi, `
  String get hi {
    return Intl.message(
      'Hi, ',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Daily recommendations`
  String get ever_ad {
    return Intl.message(
      'Daily recommendations',
      name: 'ever_ad',
      desc: '',
      args: [],
    );
  }

  /// `Your recent bad posture is mostly leaning to the right. We recommend that you refer to the following rehabilitation exercises`
  String get ad {
    return Intl.message(
      'Your recent bad posture is mostly leaning to the right. We recommend that you refer to the following rehabilitation exercises',
      name: 'ad',
      desc: '',
      args: [],
    );
  }

  /// `Real-time`
  String get realtime {
    return Intl.message(
      'Real-time',
      name: 'realtime',
      desc: '',
      args: [],
    );
  }

  /// `Detailed data`
  String get detail {
    return Intl.message(
      'Detailed data',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Average min`
  String get min_av {
    return Intl.message(
      'Average min',
      name: 'min_av',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `You have been like this \nfor {a} minutes today`
  String Today_min(Object a) {
    return Intl.message(
      'You have been like this \nfor $a minutes today',
      name: 'Today_min',
      desc: '',
      args: [a],
    );
  }

  /// `Data`
  String get total_time {
    return Intl.message(
      'Data',
      name: 'total_time',
      desc: '',
      args: [],
    );
  }

  /// `Daily bad sitting time`
  String get av_sit {
    return Intl.message(
      'Daily bad sitting time',
      name: 'av_sit',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect_sit {
    return Intl.message(
      'Connect',
      name: 'connect_sit',
      desc: '',
      args: [],
    );
  }

  /// `Connecting`
  String get connect {
    return Intl.message(
      'Connecting',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Low latency`
  String get low {
    return Intl.message(
      'Low latency',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `View statistical data`
  String get see_static {
    return Intl.message(
      'View statistical data',
      name: 'see_static',
      desc: '',
      args: [],
    );
  }

  /// `Currently, you\n`
  String get now {
    return Intl.message(
      'Currently, you\n',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `Total statistics`
  String get total_static {
    return Intl.message(
      'Total statistics',
      name: 'total_static',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Total average`
  String get total_av {
    return Intl.message(
      'Total average',
      name: 'total_av',
      desc: '',
      args: [],
    );
  }

  /// `Less than `
  String get low_than {
    return Intl.message(
      'Less than ',
      name: 'low_than',
      desc: '',
      args: [],
    );
  }

  /// `Modify information`
  String get re_d {
    return Intl.message(
      'Modify information',
      name: 're_d',
      desc: '',
      args: [],
    );
  }

  /// `Every {date} bad posture`
  String every_awful(Object date) {
    return Intl.message(
      'Every $date bad posture',
      name: 'every_awful',
      desc: '',
      args: [date],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Detailed record`
  String get detail_record {
    return Intl.message(
      'Detailed record',
      name: 'detail_record',
      desc: '',
      args: [],
    );
  }

  /// `Seat cushion Wi-Fi settings`
  String get WIFI {
    return Intl.message(
      'Seat cushion Wi-Fi settings',
      name: 'WIFI',
      desc: '',
      args: [],
    );
  }

  /// `Hotspot Wi-Fi name`
  String get wifi_name {
    return Intl.message(
      'Hotspot Wi-Fi name',
      name: 'wifi_name',
      desc: '',
      args: [],
    );
  }

  /// `Hotspot Wi-Fi password`
  String get wifi_password {
    return Intl.message(
      'Hotspot Wi-Fi password',
      name: 'wifi_password',
      desc: '',
      args: [],
    );
  }

  /// `Seat number: dwxsfexdzy`
  String get sit_ID_code {
    return Intl.message(
      'Seat number: dwxsfexdzy',
      name: 'sit_ID_code',
      desc: '',
      args: [],
    );
  }

  /// `Seat cushion is connected`
  String get already_connect {
    return Intl.message(
      'Seat cushion is connected',
      name: 'already_connect',
      desc: '',
      args: [],
    );
  }

  /// `Seat cushion serial number`
  String get sit_ID {
    return Intl.message(
      'Seat cushion serial number',
      name: 'sit_ID',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get con {
    return Intl.message(
      'Continue',
      name: 'con',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Account name`
  String get name {
    return Intl.message(
      'Account name',
      name: 'name',
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

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Left Leg Crossed`
  String get Left_foot {
    return Intl.message(
      'Left Leg Crossed',
      name: 'Left_foot',
      desc: '',
      args: [],
    );
  }

  /// `Right Leg Crossed`
  String get right_foot {
    return Intl.message(
      'Right Leg Crossed',
      name: 'right_foot',
      desc: '',
      args: [],
    );
  }

  /// `Sphinx`
  String get Sphinx {
    return Intl.message(
      'Sphinx',
      name: 'Sphinx',
      desc: '',
      args: [],
    );
  }

  /// `One-Third Sitting`
  String get One_third {
    return Intl.message(
      'One-Third Sitting',
      name: 'One_third',
      desc: '',
      args: [],
    );
  }

  /// `Upper Body Right Tilt`
  String get Upper_right {
    return Intl.message(
      'Upper Body Right Tilt',
      name: 'Upper_right',
      desc: '',
      args: [],
    );
  }

  /// `Upper Body Left Tilt`
  String get Upper_left {
    return Intl.message(
      'Upper Body Left Tilt',
      name: 'Upper_left',
      desc: '',
      args: [],
    );
  }

  /// `Hunched`
  String get Hunchback {
    return Intl.message(
      'Hunched',
      name: 'Hunchback',
      desc: '',
      args: [],
    );
  }

  /// `Half-Lying Half-Sitting`
  String get half_lying {
    return Intl.message(
      'Half-Lying Half-Sitting',
      name: 'half_lying',
      desc: '',
      args: [],
    );
  }

  /// `Normal Sitting`
  String get Sit {
    return Intl.message(
      'Normal Sitting',
      name: 'Sit',
      desc: '',
      args: [],
    );
  }

  /// `Cross-Legged`
  String get Cross_Legged {
    return Intl.message(
      'Cross-Legged',
      name: 'Cross_Legged',
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
      Locale.fromSubtags(languageCode: 'zh'),
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
