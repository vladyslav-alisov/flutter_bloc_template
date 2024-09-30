import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/const/assets.gen.dart';
import 'package:lottie/lottie.dart';

class AppError extends StatelessWidget {
  const AppError({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
                onPressed: () => exit(1),
                child: Text("Close app"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
