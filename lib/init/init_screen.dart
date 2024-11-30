import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/const/assets.gen.dart';
import 'package:flutter_bloc_template/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initData());
  }

  Future<void> _initData() async {
    try {
      await Future.delayed(Duration(seconds: 2), () => print("Init completed"));
      if (mounted) context.go(AppRoutes.settings.path);
    } catch (e) {
      if (mounted) context.go(AppRoutes.initError.path, extra: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.animations.initLoading,
              height: 400,
              width: 400,
            ),
            const SizedBox(height: 20),
            Text(
              "Loading your data...",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
