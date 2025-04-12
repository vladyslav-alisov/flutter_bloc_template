import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/router/app_routes.dart';
import 'package:flutter_bloc_template/features/navigation_screen/presentation/navigation_cubit/navigation_cubit.dart';
import 'package:flutter_bloc_template/init_dependencies.dart' show serviceLocator;
import 'package:go_router/go_router.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
    _navBarScreens = [];
  }

  late final List<Widget> _navBarScreens;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            context.go(AppRoutes.signUp.path);
          }
        },
        child: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return Scaffold(
              body: IndexedStack(
                index: state.index,
                children: _navBarScreens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) => context.read<NavigationCubit>().navigate(
                      NavigationScreenRoute.values[value],
                    ),
                currentIndex: state.index,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Programs"),
                  BottomNavigationBarItem(icon: Icon(Icons.school), label: "My Applications"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
