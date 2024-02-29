// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/ecommerce/widget/custom_appbar.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/details/controller_option.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/details/screen_party_route.dart';

import '../../../../../../../singletons/AppData.dart';
import '../../../../network/exceptions/general_exception_widget.dart';
import '../../../../network/exceptions/internet_exception_widget.dart';
import '../../../../network/status.dart';

class PartyDetails extends StatelessWidget {
  final int acid;
  const PartyDetails({super.key, required this.acid});

  @override
  Widget build(BuildContext context) {
    final optionController = Get.put(PartyOptionController());
    optionController.acmstdetailApi(acid);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Party Details'),
      body: Obx(() {
        switch (optionController.RxRequestStatus.value) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            if (optionController.error.value == 'No Internet') {
              return InternetExceptionWidget(onPress: () => optionController.acmstdetailApi(acid));
            } else {
              return GeneralExceptionWidget(onPress: () => optionController.acmstdetailApi(acid));
            }
          case Status.COMPLETED:
            return _showpartydetail(context, optionController);
        }
      }),
    );
  }
}

Widget _showpartydetail(BuildContext context, PartyOptionController controller) {
  var acmst = controller.prtrecord.value[0];

  String opncaption = acmst.open_bal! < 0 ? " Debit " : " Credit ";
  String clscaption = acmst.clos_bal! < 0 ? " Debit " : " Credit ";

  return ListView(children: [
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
                elevation: 2.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        acmst.ac_nm ?? '',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(acmst.add_1 ?? ''.toString(),
                                    softWrap: true, style: Theme.of(context).textTheme.bodyMedium),
                                Text(acmst.add_2 ?? ''.toString(),
                                    softWrap: true, style: Theme.of(context).textTheme.bodyMedium),
                                Text(acmst.add_3 ?? ''.toString(),
                                    softWrap: true, style: Theme.of(context).textTheme.bodyMedium),
                                Text(acmst.add_4 ?? ''.toString(),
                                    softWrap: true, style: Theme.of(context).textTheme.bodyMedium),
                                Text(acmst.city ?? ''.toString(),
                                    softWrap: true, style: Theme.of(context).textTheme.bodyMedium),
                                Text(acmst.pin ?? ''.toString(),
                                    style: Theme.of(context).textTheme.bodyMedium),
                              ],
                            )
                          ],
                        ),
                      ),
                    ])),
            Card(
                elevation: 2.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Other Details',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Mobile ',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  acmst.mobile.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Phone '),
                                Text(
                                  acmst.phone_no.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Email'),
                                Text(
                                  acmst.email_id.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  softWrap: true,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Bank / Branch '),
                                Text(
                                  '${acmst.bank_ac_nm} / ${acmst.bank_branch}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Beat '),
                                Text(
                                  acmst.beatnm.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('GST '),
                                Text(
                                  acmst.gstin.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('PAN '),
                                Text(
                                  acmst.pan_no.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ])),
            Card(
                elevation: 2.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'A/C Status',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Opening Balance Rs.',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${acmst.open_bal!.abs().toDouble().toStringAsFixed(2)} $opncaption',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Closing Balance Rs. '),
                                Text(
                                  '${acmst.clos_bal!.abs().toDouble().toStringAsFixed(2)} $clscaption',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Outstanding Amount'),
                                Text(
                                  acmst.osamt!.toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Outstanding Bill Nos.'),
                                Text(
                                  acmst.osbill!.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Outstanding Days '),
                                Text(
                                  acmst.osdays!.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ])),
            Card(
                elevation: 2.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Location ',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          IconButton(
                              icon: const Icon(Icons.my_location, size: 20, color: tAccentColor),
                              onPressed: controller.getloc),
                          IconButton(
                              icon: const Icon(
                                Icons.alt_route,
                                size: 20,
                                color: tAccentColor,
                              ),
                              onPressed: () {
                                print('going to party route page');
                                if (appData.livlat != '0.0' && appData.livlon != '0.0') {
                                  Get.to(() => const PartyRoute());
                                }
                              })
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Latitude ',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  acmst.latitude.toString() == '0.0'
                                      ? controller.ordlat.value.toString()
                                      : acmst.latitude.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Longitude'),
                                Text(
                                  acmst.longitude.toString() == '0.0'
                                      ? controller.ordlon.value.toString()
                                      : acmst.longitude.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                            /*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: new Icon(
                                      Icons.save,
                                      color: Colors.blueAccent,
                                    ),
                                    onPressed: () {}), //_updloc)
                              ],
                            ),
                            */
                          ],
                        ),
                      ),
                    ])),
          ],
        )),
  ]);
}