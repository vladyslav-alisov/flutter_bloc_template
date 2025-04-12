import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/auth/domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Get reference to Supabase auth client for convenience
  final GoTrueClient _supabaseAuth = Supabase.instance.client.auth;

  AuthBloc() : super(AuthInitial()) {
    // Handle each event with a function
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChanged>(_onAuthStatusChanged);

    // Listen to Supabase auth changes (signed in, signed out, token refresh, etc.)
    _authSubscription = _supabaseAuth.onAuthStateChange.listen((data) {
      // data has fields: data.event (AuthChangeEvent) and data.session (Session?)
      add(AuthStatusChanged(data.session));
    });
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    // Check if we have an existing session (user is already logged in)
    final Session? session = _supabaseAuth.currentSession;
    if (session != null && session.user != null) {
      // A valid session exists, user is considered authenticated
      emit(AuthAuthenticated(session.user!));
    } else {
      // No session, user needs to log in
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // emit a loading state if you want to show a spinner
    try {
      final AuthResponse res = await _supabaseAuth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      if (res.session != null) {
        // Login succeeded, we have a session. We can emit AuthAuthenticated.
        // (Supabase will also trigger onAuthStateChange, which we are listening to.)
        emit(AuthAuthenticated(res.session!.user));
      } else if (res.error != null) {
        // Authentication failed (wrong creds, etc.)
        emit(AuthUnauthenticated());
        // Optionally emit an AuthFailure state with res.error.message
      }
    } catch (e) {
      emit(AuthUnauthenticated());
      // Optionally emit AuthFailure(e.toString());
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await _supabaseAuth.signOut();
    // After signOut, Supabase will emit a signedOut event that our listener catches.
    // We can also immediately emit an unauthenticated state to update UI:
    emit(AuthUnauthenticated());
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    final session = event.session;
    if (session != null && session.user != null) {
      emit(AuthAuthenticated(session.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
