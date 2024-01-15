import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/config/routes/app_routes.dart';
import '../cubit/nottification_cubit.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context.read<NottificationCubit>().getNotification();
    super.initState();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NottificationCubit, NottificationState>(
      listener: (context, state) {
        if (state is NottificationLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        NottificationCubit cubit = context.read<NottificationCubit>();

        return Scaffold(
          body: SafeArea(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12, top: 85, bottom: 12),
                          child: ListView.builder(
                            itemCount: cubit.notificationList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  cubit.notificationList[index].serviceId ==
                                          null
                                      ? null
                                      : Navigator.pushNamed(context,
                                          Routes.notificationDetailsRoute,
                                          arguments:
                                              cubit.notificationList[index]);
                                  //  Navigator.pushNamed(context, Routes.detailsRoute,arguments:ServicesModel(
                                  //    name: cubit.notificationList[index].title,
                                  //    id: cubit.notificationList[index].id,
                                  //
                                  //  ));
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                        "${cubit.notificationList[index].title}"),
                                    subtitle: Text(
                                        "${cubit.notificationList[index].body}"),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
