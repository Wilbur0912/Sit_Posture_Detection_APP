import 'dart:async';

import 'package:appp3/pages/starting_pages/login_page/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../userProfileProvider.dart';
import '/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.svg',
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : LoginPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, params) {
            // 從Provider中獲取UserProfileProvider
            final userProfileProvider = Provider.of<UserProfileProvider>(context);

            // 檢查UserProfileProvider是否已加載UserProfile
            if (userProfileProvider.userProfile != null) {
              final token = userProfileProvider.userProfile!.token;

              // 檢查token是否存在
              if (token != null && token.isNotEmpty) {
                // Token存在，導航到需要登入的頁面（例如HomePage）
                return HomePageWidget();
              } else {
                // Token不存在，導航到登入頁面（例如LoginPage）
                return LoginPageWidget();
              }
            } else {
              // 如果UserProfileProvider尚未加載UserProfile，可以顯示載入中的頁面
              return LoginPageWidget(); // 或其他載入中UI
            }
          },
          // builder: (context, _) => appStateNotifier.showSplashImage
          //     ? Builder(
          //         builder: (context) => Container(
          //           color: Colors.white,
          //           child: Center(
          //             child: Image.asset(
          //               'assets/images/logo.svg',
          //               width: MediaQuery.sizeOf(context).width * 0.2,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       )
          //     : LoginPageWidget(),
          routes: [
            FFRoute(
              name: 'WelcomePage',
              path: 'welcomePage',
              builder: (context, params) => WelcomePageWidget(),
            ),
            FFRoute(
              name: 'LoginPage',
              path: 'LoginPage',
              builder: (context, params) => LoginPageWidget(),
            ),
            FFRoute(
              name: 'HomePage',
              path: 'homePage',
              builder: (context, params) => HomePageWidget(),
            ),
            FFRoute(
              name: 'MobileSignIn',
              path: 'mobileSignIn',
              builder: (context, params) => MobileSignInWidget(),
            ),
            FFRoute(
              name: 'VerifyMobile',
              path: 'verifyMobile',
              builder: (context, params) => VerifyMobileWidget(),
            ),
            FFRoute(
              name: 'EnterPassword',
              path: 'enterPassword',
              builder: (context, params) => EnterPasswordWidget(),
            ),
            FFRoute(
              name: 'GenderSelection',
              path: 'genderSelection',
              builder: (context, params) => GenderSelectionWidget(),
            ),
            FFRoute(
              name: 'ProfilePicture',
              path: 'profilePicture',
              builder: (context, params) => ProfilePictureWidget(),
            ),
            FFRoute(
              name: 'WeightEntry',
              path: 'weightEntry',
              builder: (context, params) => WeightEntryWidget(),
            ),
            FFRoute(
              name: 'GetStarted',
              path: 'getStarted',
              builder: (context, params) => GetStartedWidget(),
            ),
            FFRoute(
              name: 'analyzation',
              path: 'analyzation',
              builder: (context, params) => AnalyzationWidget(),
            ),
            FFRoute(
              name: 'StepsTracker',
              path: 'stepsTracker',
              builder: (context, params) => StepsTrackerWidget(),
            ),
            FFRoute(
              name: 'FoodJournal',
              path: 'foodJournal',
              builder: (context, params) => FoodJournalWidget(),
            ),
            FFRoute(
              name: 'EventsPage',
              path: 'eventsPage',
              builder: (context, params) => EventsPageWidget(),
            ),
            FFRoute(
              name: 'EventDetails',
              path: 'eventDetails',
              builder: (context, params) => EventDetailsWidget(),
            ),
            FFRoute(
              name: 'ProfilePage',
              path: 'profilePage',
              builder: (context, params) => ProfilePageWidget(),
            ),
            FFRoute(
              name: 'WaterTracker',
              path: 'waterTracker',
              builder: (context, params) => WaterTrackerWidget(),
            ),
            FFRoute(
              name: 'detection',
              path: 'detection',
              builder: (context, params) => DetectionWidget(),
            ),
            FFRoute(
              name: 'FoodNutrients',
              path: 'foodNutrients',
              builder: (context, params) => FoodNutrientsWidget(),
            ),
            FFRoute(
              name: 'HeightEntry',
              path: 'HeightEntry',
              builder: (context, params) => HeightEntryWidget(),
            ),
            FFRoute(
              name: 'settings',
              path: 'settings',
              builder: (context, params) => SettingsWidget(),
            ),
            FFRoute(
              name: 'Connect',
              path: 'connect',
              builder: (context, params) => ConnectWidget(wifiName: '', wifiPassword: '',),
            ),
            FFRoute(
              name: 'cushionWifiSetting',
              path: 'cushionWifiSetting',
              builder: (context, params) => CushionWifiSettingWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
