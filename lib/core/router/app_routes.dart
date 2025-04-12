enum AppRoutes {
  init("/", "/"),
  initError("/init_error", "/init_error"),
  home("/login", "/login"),
  signUp("/sign_up", "/sign_up"),
  settings("/settings", "/settings");

  const AppRoutes(this.name, this.path);

  final String name;
  final String path;
}
