import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/config/routes/app_routes.dart';
import 'package:khadamat/features/details_from_deeplink/details_deeplink/details_deeplink_cubit.dart';


class DetailsFromDeepLink extends StatefulWidget {
  final int? id;

  const DetailsFromDeepLink({super.key, this.id});

  @override
  State<DetailsFromDeepLink> createState() => _DetailsFromDeepLinkState();
}

class _DetailsFromDeepLinkState extends State<DetailsFromDeepLink> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DetailsDeeplinkCubit>().getServiceDetails(widget.id!);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, Routes.homeRoute);
        return true;
      },
      child:
      BlocConsumer<DetailsDeeplinkCubit, DetailsDeeplinkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          DetailsDeeplinkCubit cubit = context.read<DetailsDeeplinkCubit>();
          return Scaffold(
            body: widget.id != 0 ?
            Center(child: Text("no details"),) :
            Column(
              children: [
                Text("${cubit.serviceDetails?.data?.id}")
              ],
            ),
          );
        },
      ),
    );
  }
}
