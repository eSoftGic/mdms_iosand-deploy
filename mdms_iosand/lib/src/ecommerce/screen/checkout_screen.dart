import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/controller/cart_controller.dart';
import 'package:mdms_iosand/src/ecommerce/widget/widget.dart';
import '../../constants/constants.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController zipController = TextEditingController();
    CartController cartController = Get.put(CartController());

    return Scaffold(
        appBar: const CustomAppBar(
          title: 'CheckOut Screen',
          isCartList: false,
          isWishList: false,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
            height: 75,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        cartController.saveCarttoOrder();
                      },
                      child: Text(
                        ' SAVE ORDER ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: tWhiteColor),
                      ))
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer Info',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              _buildTextFormField(emailController, context, "Email"),
              _buildTextFormField(nameController, context, "Name"),
              Text(
                'Delivery Info',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              _buildTextFormField(addressController, context, "Address"),
              _buildTextFormField(cityController, context, "City"),
              _buildTextFormField(zipController, context, "Pin Code"),
              Text(
                'Order Summary',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const OrderSummary(),
            ],
          ),
        ));
  }

  Padding _buildTextFormField(
    TextEditingController controller,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(children: [
        SizedBox(
          width: 75,
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: tPrimaryColor),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              focusColor: tPrimaryColor,
              isDense: true,
              contentPadding: EdgeInsets.only(left: 10),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}