import 'package:flutter/material.dart';
import 'package:rightflair/core/components/appbar.dart';
import 'package:rightflair/core/components/back_button.dart';
import 'package:rightflair/core/components/icon_button.dart';
import 'package:rightflair/core/constants/dark_color.dart';
import 'package:rightflair/core/constants/icons.dart';
import 'package:rightflair/core/extensions/context.dart';
import '../widgets/system_notifications_list.dart';

class SystemNotificationsPage extends StatelessWidget {
  const SystemNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDarkColors.SECONDARY,
      appBar: AppBarComponent(
        leading: BackButtonComponent(),
        title: "System Notifications",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.width * .04),
            child: IconButtonComponent(
              size: context.height * .045,
              onTap: () {},
              icon: AppIcons.SETTINGS,
            ),
          ),
        ],
      ),
      body: const SystemNotificationsListWidget(),
    );
  }
}
