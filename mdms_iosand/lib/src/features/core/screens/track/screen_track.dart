// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/custom_appbar.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/screens/track/controller_track.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';

import '../../network/exceptions/general_exception_widget.dart';
import '../../network/exceptions/internet_exception_widget.dart';
import '../../network/status.dart';

const kTileHeight = 50.0;

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TrackController tController = Get.put(TrackController());

    double wd = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;

    Color getColor(String stat) {
      if (stat.contains('Pending')) return Colors.orange;
      if (stat == 'Approved') return Colors.green;
      if (stat == 'Rejected') return Colors.red;
      return Get.isDarkMode ? tWhiteColor : tPrimaryColor;
    }

    Widget showTrack() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          trackHeaderWidget(
            trackController: tController,
            trkhdr: tController.getTrkHdr(),
          ),
          SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height - 275,
                  child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: tController.listOfEvents.length,
                      itemBuilder: (context, i) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(40),
                              child: Row(
                                children: [
                                  SizedBox(width: wd * 0.1),
                                  /*SizedBox(
                                    child: Text(tController.listOfEvents[i].adate),
                                    width: wd * 0.2,
                                  ),*/
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${tController.listOfEvents[i].eventName} ( ${tController.listOfEvents[i].tblid} )',
                                          style: Theme.of(context).textTheme.headlineSmall,
                                        ),
                                        Text(tController.listOfEvents[i].astatus,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    color: getColor(
                                                        tController.listOfEvents[i].astatus))),
                                        Text(tController.listOfEvents[i].adate.toString()),
                                        tController.listOfEvents[i].eventName == 'ORDER'
                                            ? Text(
                                                tController.listOfEvents[i].orddesc,
                                                style: const TextStyle(fontSize: 18),
                                              )
                                            : Text(
                                                tController.listOfEvents[i].bildesc,
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                        tController.listOfEvents[i].eventName == 'ORDER'
                                            ? Text(
                                                tController.listOfEvents[i].orddt.toString(),
                                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                                              )
                                            : Text(
                                                tController.listOfEvents[i].bildt.toString(),
                                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                                              ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              left: 50,
                              child: Container(
                                height: ht * 0.7,
                                width: 1.0,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Container(
                                  height: 20.0,
                                  width: 20.0,
                                  decoration: BoxDecoration(
                                    color: getColor(tController.listOfEvents[i].astatus),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })))),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: ('Order Tracking Log'),
        isRefresh: true,
        onpressed: tController.trackApi,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 5,
        width: double.infinity,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Obx(() {
              switch (tController.RxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (tController.error.value == 'No Internet') {
                    return InternetExceptionWidget(onPress: () => tController.trackApi());
                  } else {
                    return GeneralExceptionWidget(onPress: () => tController.trackApi());
                  }
                case Status.COMPLETED:
                  return showTrack();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class trackHeaderWidget extends StatelessWidget {
  const trackHeaderWidget({
    super.key,
    required this.trackController,
    required this.trkhdr,
  });
  final TrackController trackController;
  final TrackHeader trkhdr;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: tWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${trkhdr.trantype}-${trkhdr.ordno}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    trkhdr.orddt,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const Divider(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(trkhdr.prtnm, style: Theme.of(context).textTheme.headlineSmall),
                        Text('Chain of Stores : ${trkhdr.chainnm}',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    Text('Rs. ${trkhdr.netamt.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall)
                  ]),
            ]),
      ),
    );
  }
}