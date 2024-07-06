import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unimatch/views/mobile/peopleNearby.dart';
import 'package:unimatch/userPreferences.dart';
import 'package:unimatch/views/mobile/home.dart';
import 'package:unimatch/views/mobile/landing.dart';
import 'package:unimatch/views/mobile/primary.dart';
import 'package:unimatch/views/profile/clientProfile.dart';
import 'package:unimatch/views/update/avatar.dart';
import 'package:unimatch/views/update/updatePwd.dart';
import 'package:unimatch/views/mobile/sendRecoveryEmail.dart';
import 'package:unimatch/views/mobile/accountRecovery.dart';
import 'package:unimatch/views/mobile/discoverySetting.dart';
import 'package:unimatch/views/mobile/setting.dart';
import 'package:unimatch/views/setup/setupProfile.dart';
import 'package:unimatch/views/mobile/verification.dart';
import 'package:unimatch/views/setup/welcome.dart';
import 'config.dart';
import 'const.dart';
import 'views/mobile/feedback.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  PACKAGEINFO = await PackageInfo.fromPlatform();
  if (await FlutterBluePlus.isSupported == false) {
    debugPrint("Bluetooth not supported by this device");
  } else {
    if (Platform.isAndroid) {
      requestAllPermissions();
    }
  }
  runApp(const MyApp());
}

void requestAllPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.bluetoothScan,
    Permission.location,
  ].request();
  //debugPrint(statuses[Permission.bluetoothScan]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogged.value ? const PrimaryPage() : const LandingPage(),
      // home: const PrimaryPage(),
      // home: const SetupProfilePage(),
      routes: {
        '/home':(context) => const HomeView(),
        '/discoverySetting':(context) => const DiscoverySettingPage(),
        '/landing':(context) => const LandingPage(),
        '/primary':(context) => const PrimaryPage(),
        '/verify':(context) => const VerificationPage(),
        '/profile':(context) => const ClientProfilePage(),
        '/setupProfile':(context) => const SetupProfilePage(),
        '/resetPwd':(context) => const UpdatePwdPage(),
        '/accountRecovery':(context) => const AccountRecoveryPage(),
        '/sendRecovery':(context) => const SendRecoveryPage(),
        '/setting':(context) => const SettingPage(),
        '/feedback':(context) => const FeedbackPage(),
        '/welcome':(context) => const WelcomePage(),
        '/updateAvatar':(context) => const UpdateAvatarPage(),
        '/location':(context) => const PeopleNearbyPage(),
      },
    );
  }
}
