import 'dart:io';

import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  root("/"),

  /// General page
  splashScreen('/splashscreen'),
  onboard('/onboard'),
  dashboard('/dashboard'),
  specialOffers('/dashboard/special-offers'),
  allService('/dashboard/all-service'),
  notification('/notification'),

  // profile
  profile('/profile'),
  editProfile('/profile/edit'),
  settings('/settings'),

  // Auth Page
  login('/login'),
  register('/register'),
  registerData('/register/data'),
  registerDataSummary('/register/data/summary'),
  waitingVerification('/waiting-verification'),

  // technician
  technicianList('/technician/list'),
  technicianDetail('/technician/detail'),
  review('/review'),
  makeOrder('/technician/make-order'),
  orderSummary('/technician/make-order/summary'),

  // order page
  order('/order'),
  orderDetail('/order/detail'),

  // income page
  income('/income'),
  incomeStatement('/income/statement'),

  // chat
  chat('/chat'),
  roomChat('/chat/room'),
  ;

  const Routes(this.path);

  final String path;
}

final GlobalKey<NavigatorState> _rootNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRoute {
  static late BuildContext context;

  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splashScreen.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
    redirect: (_, GoRouterState state) {
      final bool isAuthPage = state.matchedLocation == Routes.login.path ||
          state.matchedLocation == Routes.register.path ||
          state.matchedLocation == Routes.registerData.path;

      final bool isSplashScreen =
          state.matchedLocation == Routes.splashScreen.path;

      final bool isOnboardPage = state.matchedLocation == Routes.onboard.path;

      if (isSplashScreen) {
        return null;
      }

      if (isOnboardPage) {
        if ((MainBoxMixin.mainBox?.get(MainBoxKeys.isOnboardPassed.name)
                as bool?) ??
            false) {
          return isAuthPage ? null : Routes.login.path;
        } else {
          return null;
        }
      }

      if (!((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
          false)) {
        return isAuthPage ? null : Routes.login.path;
      }

      if (isAuthPage &&
          ((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
              false)) {
        if (MainBoxMixin.mainBox?.get(MainBoxKeys.isRegistered.name) as bool? ??
            false) {
          if (MainBoxMixin.mainBox?.get(MainBoxKeys.isVerified.name) as bool? ??
              false) {
            context.read<ElectronicCubit>().streamElectronics();
            context.read<ClientCubit>().getClients();
            context.read<OrderCubit>().streamOrders(
                MainBoxMixin.mainBox?.get(MainBoxKeys.authUserId.name));
            context.read<ChatCubit>().streamChatList(
                MainBoxMixin.mainBox?.get(MainBoxKeys.authUserId.name));
            context.read<LocationCubit>().streamLocation();

            return Routes.root.path;
          } else {
            return Routes.waitingVerification.path;
          }
        }
        context.read<ElectronicCubit>().streamElectronics();
        return Routes.registerData.path;
      }

      return null;
    },
    navigatorKey: _rootNavigator,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (_, __) => const SplashScreenPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.onboard.path,
        name: Routes.onboard.name,
        builder: (_, __) => const OnboardPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.root.path,
        name: Routes.root.name,
        redirect: (_, __) => Routes.dashboard.path,
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<LoginCubit>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.register.path,
        name: Routes.register.name,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<RegisterCubit>(),
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.registerData.path,
        name: Routes.registerData.name,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<RegisterDataCubit>(),
          child: const RegisterDataPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.registerDataSummary.path,
        name: Routes.registerDataSummary.name,
        builder: (_, state) {
          final data = state.extra as List<dynamic>;
          final userData = data[0];
          final File? profilePicture = data[1];
          final images = data[2];
          final files = data[3];
          return RegisterDataSummaryPage(
            userData: userData,
            profilePicture: profilePicture,
            images: images,
            files: files,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.waitingVerification.path,
        name: Routes.waitingVerification.name,
        builder: (_, __) => const WaitingVerificationPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.notification.path,
        name: Routes.notification.name,
        builder: (_, __) => const NotificationPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.specialOffers.path,
        name: Routes.specialOffers.name,
        builder: (_, __) => const SpecialOffersPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.allService.path,
        name: Routes.allService.name,
        builder: (_, __) => const AllServicePage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.settings.path,
        name: Routes.settings.name,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.editProfile.path,
        name: Routes.editProfile.name,
        builder: (_, state) {
          return BlocProvider(
            create: (_) => sl<EditProfileCubit>(),
            child: const EditProfilePage(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.roomChat.path,
        name: Routes.roomChat.name,
        builder: (_, state) {
          final map = state.extra as Map<String, dynamic>;
          final chatListId = map['chatListId'] as String;
          final clientName = map['clientName'] as String;
          final clientPicture = map['clientPicture'] as String;
          return RoomChatPage(
            chatListId: chatListId,
            clientName: clientName,
            clientPicture: clientPicture,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.orderDetail.path,
        name: Routes.orderDetail.name,
        builder: (_, state) {
          final orderId = state.extra as String;
          return BlocProvider<OrderDetailCubit>(
            create: (context) => sl<OrderDetailCubit>(),
            child: OrderDetailPage(orderId: orderId),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: Routes.incomeStatement.path,
        name: Routes.incomeStatement.name,
        builder: (_, __) => const IncomeStatementPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (_, __, child) => BlocProvider(
          create: (context) => sl<MainCubit>(),
          child: MainPage(child: child),
        ),
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigator,
            path: Routes.dashboard.path,
            name: Routes.dashboard.name,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: DashboardPage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigator,
            path: Routes.order.path,
            name: Routes.order.name,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: OrderPage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigator,
            path: Routes.income.path,
            name: Routes.income.name,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: IncomePage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigator,
            path: Routes.chat.path,
            name: Routes.chat.name,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ChatPage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigator,
            path: Routes.profile.path,
            name: Routes.profile.name,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ProfilePage(),
            ),
          ),
        ],
      ),
    ],
  );
}
