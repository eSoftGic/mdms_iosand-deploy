import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class StepprtScreen extends StatefulWidget {
  const StepprtScreen({super.key});

  @override
  State<StepprtScreen> createState() => _StepprtScreenState();
}

class _StepprtScreenState extends State<StepprtScreen> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 1; // Initial step set to 5.
  int upperBound = 6; // upperBound MUST BE total number of icons minus 1.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Order Add/Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconStepper(
              icons: const [
                Icon(Icons.supervised_user_circle),
                Icon(Icons.flag),
                Icon(Icons.access_alarm),
                Icon(Icons.supervised_user_circle),
                Icon(Icons.flag),
                Icon(Icons.access_alarm),
                Icon(Icons.supervised_user_circle),
              ],

              // activeStep property set to activeStep variable defined above.
              activeStep: activeStep,

              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            header(),
            Expanded(
              child: FittedBox(
                child: Center(
                  child: Text('Order $activeStep'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: const Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Order';

      case 2:
        return 'Items';

      case 3:
        return 'Total';

      case 4:
        return 'Summary';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}