# Flutter template with Provider, GoRouter, Isar DB and Dio packages.

# Naming

Clone this project

To change name of the project use [rename package](https://pub.dev/packages/rename)

1) Write in terminal:

```
dart pub global activate rename
rename setAppName --targets ios,android --value "YourAppName"
rename setBundleId --targets ios,android --value "com.newbundle.your"
```

2) Change "name" in pubspec.yaml

```
name: new_name
description: "Your description here"
```

3) Refactor "package:template/" to "package:new_name/" all over the project

4) Run command:

```
flutter pub get
```

# Icons

1) Put your image to "assets/images/your_logo_image.png"
2) In pubspec.yaml
   Replace "assets/images/logo.png" to "assets/images/your_logo_image.png"

```
flutter_icons:
  image_path: "assets/images/logo.png"
  android: "launcher_icon"
```

3) Run command:

```
flutter pub get
flutter pub run flutter_launcher_icons
```

# Splash screen

1) Put your image to "assets/images/your_splash.png"
2) In flutter_native_splash.yaml replace "assets/images/logo.png" by "assets/images/your_splash.png"

```
  # The image parameter allows you to specify an image used in the splash screen.  It must be a
  # png file and should be sized for 4x pixel density.
  image: assets/images/your_splash.png
```

3) Run command:

```
flutter pub run flutter_native_splash:create
```
