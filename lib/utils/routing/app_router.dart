import 'package:flutter/material.dart';
import '../../ui/admin/add_counter/add_counter.dart';
import '../../ui/admin/admin_screen.dart';
import '../../ui/admin/banner_ads/banner_ads.dart';
import '../../ui/admin/deposit_operations/deposit_operations.dart';
import '../../ui/admin/view_users/view_users.dart';
import '../../ui/admin/withdrawals/withdrawals.dart';
import '../../ui/auth/forget_password/forget_password.dart';
import '../../ui/auth/login/login_screen.dart';
import '../../ui/auth/onboarding/onboarding.dart';
import '../../ui/auth/signup/signup.dart';
import '../../ui/auth/splash_screen.dart';
import '../../ui/home/audio_room/audio_room.dart';
import '../../ui/home/counter/counter_screen.dart';
import '../../ui/home/home_screen.dart';
import '../../ui/home/profile/my_counters/my_counters.dart';
import '../../ui/home/profile/profile.dart';
import '../../ui/home/profile/who_us/who_us.dart';
import '../../ui/home/wallet/deposit/mastercard_deposit.dart';
import '../../ui/home/wallet/deposit/zaincash_deposit.dart';
import '../../ui/home/wallet/wallet.dart';
import '../../ui/home/wallet/withdraw/withdraw.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // starting
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());

      // bottom nav
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.counterScreen:
        return MaterialPageRoute(builder: (_) => const CounterScreen());
      case Routes.walletScreen:
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case Routes.audioRoomScreen:
        return MaterialPageRoute(builder: (_) => const AudioRoomScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      // user
      case Routes.myCountersScreen:
        return MaterialPageRoute(builder: (_) => const MyCountersScreen());
      case Routes.whoUsScreen:
        return MaterialPageRoute(builder: (_) => const WhoUsScreen());
      case Routes.adminScreen:
        return MaterialPageRoute(builder: (_) => const AdminScreen());

      // admin options
      case Routes.addCounterScreen:
        return MaterialPageRoute(builder: (_) => const AddCounterScreen());
      case Routes.viewUserScreen:
        return MaterialPageRoute(builder: (_) => const ViewUsersScreen());
      case Routes.bannerAdsScreen:
        return MaterialPageRoute(builder: (_) => const BannerAdsScreen());
      case Routes.depositScreen:
        return MaterialPageRoute(builder: (_) => const DepositScreen());
      case Routes.withdrawalsScreen:
        return MaterialPageRoute(builder: (_) => const WithdrawalsScreen());

      // Wallet
      case Routes.usdtDepositScreen:
        return MaterialPageRoute(builder: (_) => const USDTDepositScreen());
      case Routes.zainCashDepositScreen:
        return MaterialPageRoute(builder: (_) => const ZainCashDepositScreen());
      case Routes.userWithdrawScreen:
        final args = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => UserWithdrawScreen(isUSDT: args));

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
