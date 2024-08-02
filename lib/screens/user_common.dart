import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../common/services/utils.dart';
import '../common/widgets/common.dart';
import 'premium.dart';

import '../support/app_theme.dart' as app_theme;

class ProfileImageView extends StatelessWidget {
  const ProfileImageView(
      {super.key, required this.imageUrl, this.actions, this.title});
  final String imageUrl;
  final Text? title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            size: 24,
          ),
        ),
      ),
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained * 3,
        imageProvider: appCachedNetworkImageProvider(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}

class InfoItemWidget extends StatelessWidget {
  const InfoItemWidget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return value == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Theme.of(context).dividerColor),
              color: app_theme.primary2,
              boxShadow: [    BoxShadow(
        color: Colors.white.withOpacity(0.1),
        spreadRadius: 5,
        blurRadius: 10,
        offset: const Offset(0, 3),
      )],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: 16,
                      
                    ),
                  ),
                const SizedBox(height: 4),
                // if (label != null) const Divider(height: 1),
                const SizedBox(height: 8),
                Text(
                  value ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
  }
}
class BePremiumAlertInfo extends StatelessWidget {
  const BePremiumAlertInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PremiumBadgeWidget(
              size: 164,
            ),
            const Divider(
              height: 20,
            ),
            const Text(
              'This is a premium feature, to view this you need to buy premium plan first.',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  navigatePage(context, const PremiumPage());
                },
                child: const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 12,
                      bottom: 12,
                    ),
                    child: Text("Be Premium Now",
                        style: TextStyle(
                          // color: app_theme.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
