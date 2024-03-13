import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/allocation/controller_allocation.dart';
import '../../../../constants/constants.dart';
import '../../../../ecommerce/widget/custom_appbar.dart';
import 'package:grouped_list/grouped_list.dart';

class AllocateScreen extends StatelessWidget {
  const AllocateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AllocationController aController = Get.put(AllocationController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: ('Stock Allocation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stockOptionWidget(aController: aController),
          SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height - 250,
                child: Obx(
                  () => GroupedListView<dynamic, String>(
                    // ignore: invalid_use_of_protected_member
                    elements: aController.groupedData.value,
                    groupBy: (element) => element[aController.grp1nm.value],
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    itemComparator: (item1, item2) =>
                        item1[aController.grp2nm.value]
                            .compareTo(item2[aController.grp2nm.value]),
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: false,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    itemBuilder: (c, element) {
                      return Card(
                        elevation: 8.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: SizedBox(
                          child: ExpansionTile(
                            title: Text(element[aController.grp2nm.value]),
                            initiallyExpanded: false,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['allocated_qty']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['pend_order_qty']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['billed_qty'].toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['alloc_pend_qty']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /*ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                //leading: const Icon(Icons.account_circle),
                                title: Text(element[aController.grp2nm.value]),
                                //trailing: const Icon(Icons.arrow_forward),
                              ),*/
                        ),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class stockOptionWidget extends StatelessWidget {
  const stockOptionWidget({
    super.key,
    required this.aController,
  });

  final AllocationController aController;

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.blueGrey.shade50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Obx(() => Radio(
                          value: 'Itemwise',
                          groupValue: aController.grouptype.value,
                          //activeColor: tAccentColor,
                          onChanged: (value) {
                            aController.onChangeGroup(value);
                          })),
                      const Expanded(child: Text('Itemwise'))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Obx(
                        () => Radio(
                            value: 'Partywise',
                            groupValue: aController.grouptype.value,
                            //activeColor: tAccentColor,
                            onChanged: (value) {
                              aController.onChangeGroup(value);
                            }),
                      ),
                      const Expanded(child: Text('Partywise'))
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          //color: tAccentColor,
                          iconSize: 30.0,
                          disabledColor: Colors.grey,
                          highlightColor: tPrimaryColor,
                          onPressed: () async {
                            aController.allocApi();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          //color: tAccentColor,
                          iconSize: 30.0,
                          disabledColor: Colors.grey,
                          highlightColor: tPrimaryColor,
                          onPressed: () async {
                            aController.setprtIdstr('');
                            aController.setItmIdstr('');
                            aController.allocApi();
                          },
                        ),
                      ],
                    )),
              ],
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Allocated',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18))),
                Expanded(
                    flex: 1,
                    child: Text('Ord.Pending',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 16))),
                Expanded(
                    flex: 1,
                    child: Text('Billed',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18))),
                Expanded(
                    flex: 1,
                    child: Text('Allocated Bal.',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 16))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
