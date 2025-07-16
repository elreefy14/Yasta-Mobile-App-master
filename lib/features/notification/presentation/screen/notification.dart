import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/features/notification/data/logic/notifications_cubit.dart';
import 'package:yasta/features/notification/data/model/notifaction_model.dart';
import 'package:yasta/features/notification/data/model/notification_input_model.dart';
import 'package:yasta/features/notification/presentation/widget/notification_item.dart';

import '../../../../core/theme/text_styles.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Data> notifications = [];

  @override
  void initState() {
    super.initState();
    // Fetch notifications when the screen initializes
    NotificationsCubit.get(context).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: CacheHelper.getdata(key: "lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              getLang(context, "Notification").toString(),
              style: TextStyles.blackFS15FW500TextStyle,
            ),
            centerTitle: true,
          ),
          body: BlocConsumer<NotificationsCubit, NotificationsState>(
            listener: (context, state) {
              if (state is GetNotificationsSuccessState) {
                setState(() {
                  notifications = state.data!.data!;
                });
              }
            },
            builder: (context, state) {
              if (state is GetNotificationsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (notifications.isEmpty) {
                return Center(
                  child: Text(
                     "No Notifications",
                    style: TextStyles.blackFS15FW500TextStyle,
                  ),
                );
              }
              return  ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(notifications[index].id.toString()),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      final removedNotification = notifications[index];

                      // Remove from the list safely
                      setState(() {
                        if (index < notifications.length) {
                          notifications.removeAt(index);
                        }
                      });

                      // Notify the backend
                      NotificationsCubit.get(context).deleteNotification(
                        notificationsInputModel: NotificationsInputModel(
                          id: removedNotification.id.toString(),
                        ),
                      );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: NotificationItem(
                      text: notifications[index].message.toString(),
                      image: notifications[index].image.toString(),
                    ),
                  );
                },
              );

            },
          ),
        ),
      ),
    );
  }
}
