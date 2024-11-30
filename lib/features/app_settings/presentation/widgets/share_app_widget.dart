import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/l10n/translate_extension.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/widgets/settings_list_tile.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppWidget extends StatefulWidget {
  const ShareAppWidget({super.key, required this.appStoreUrl, required this.playMarketUrl});

  final String appStoreUrl;
  final String playMarketUrl;

  @override
  State<ShareAppWidget> createState() => _ShareAppWidgetState();
}

class _ShareAppWidgetState extends State<ShareAppWidget> {
  late bool _isShareLoading;

  @override
  void initState() {
    super.initState();
    _isShareLoading = false;
  }

  void _onShareAppPress() async {
    if (_isShareLoading) return;
    setState(() => _isShareLoading = true);
    try {
      String store = Platform.isIOS ? widget.appStoreUrl : widget.playMarketUrl;
      await Share.share(store);
    } catch (e) {
      if (!mounted) return;
      AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
      );
    } finally {
      setState(() => _isShareLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      leadingIcon: Icons.share_outlined,
      title: context.l10n.shareApp,
      onTap: _onShareAppPress,
      trailing: _isShareLoading ? const CupertinoActivityIndicator() : null,
    );
  }
}
