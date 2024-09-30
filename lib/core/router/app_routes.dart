enum AppRoutes {
  init("/", "/"),
  initError("/init_error", "/init_error"),
  home("/login", "/login"),
  settings("/settings", "/settings");

  const AppRoutes(this.name, this.path);

  final String name;
  final String path;
}
