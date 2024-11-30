import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/l10n/translate_extension.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/widgets/settings_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportFeedbackWidget extends StatefulWidget {
  const ReportFeedbackWidget({
    super.key,
    required this.feedbackEmail,
    required this.appName,
    required this.appVersion,
  });

  final String feedbackEmail;
  final String appName;
  final String appVersion;

  @override
  State<ReportFeedbackWidget> createState() => _ReportFeedbackWidgetState();
}

class _ReportFeedbackWidgetState extends State<ReportFeedbackWidget> {
  @override
  void initState() {
    _isFeedbackLoading = false;
    super.initState();
  }

  late bool _isFeedbackLoading;

  void _onFeedbackPress() async {
    if (_isFeedbackLoading) return;
    setState(() => _isFeedbackLoading = true);
    try {
      String subject = "Feedback ${widget.appName} v${widget.appVersion}";
      Uri mailTo = Uri.parse("mailto:${widget.feedbackEmail}?subject=$subject");
      await launchUrl(mailTo);
    } catch (e) {
      if (!mounted) return;
      AlertDialog(
        title: Text("Error sending feedback"),
        content: Text(e.toString()),
      );
    } finally {
      setState(() => _isFeedbackLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      leadingIcon: Icons.feedback_outlined,
      title: context.l10n.feedback,
      onTap: _onFeedbackPress,
      trailing: _isFeedbackLoading ? const CupertinoActivityIndicator() : null,
    );
  }
}
