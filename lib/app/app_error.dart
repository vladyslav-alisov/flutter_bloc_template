import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/app/locales.dart';
import 'package:flutter_bloc_template/core/const/assets.gen.dart';
import 'package:lottie/lottie.dart';

class AppError extends StatelessWidget {
  const AppError({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Assets.animations.error,
                height: 400,
                width: 400,
              ),
              const SizedBox(height: 20),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text("Send feedback"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
