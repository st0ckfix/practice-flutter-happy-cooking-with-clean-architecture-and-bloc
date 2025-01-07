import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTrackWidget extends StatelessWidget {
  const OrderTrackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int activeStep = 0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.clear,
          ),
        ),
        title: const Text('Order'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StatefulBuilder(builder: (context, state) {
            return EasyStepper(
              activeStep: activeStep,
              lineStyle: const LineStyle(
                activeLineColor: Colors.blue,
                defaultLineColor: Colors.grey,
                lineThickness: 5,
              ),
              stepShape: StepShape.rRectangle,
              stepBorderRadius: 15,
              borderThickness: 2,
              padding: const EdgeInsets.all(5),
              stepRadius: 28,
              showLoadingAnimation: false,
              steps: [
                EasyStep(
                  customStep: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: activeStep >= 0 ? 1 : 0.3,
                      child: Image.asset('assets/images/recived.png'),
                    ),
                  ),
                  customTitle: const Text(
                    'Order Recevied',
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  customStep: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: activeStep >= 1 ? 1 : 0.3,
                      child: Image.asset('assets/images/package.png'),
                    ),
                  ),
                  customTitle: const Text(
                    'Preparing',
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  customStep: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: activeStep >= 2 ? 1 : 0.3,
                      child: Image.asset('assets/images/shipping.png'),
                    ),
                  ),
                  customTitle: const Text(
                    'Delivery',
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  customStep: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: activeStep >= 3 ? 1 : 0.3,
                      child: Image.asset('assets/images/home.png'),
                    ),
                  ),
                  customTitle: const Text(
                    'Finished',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              onStepReached: (index) => state(() => activeStep = index),
            );
          }),
        ],
      ),
    );
  }
}
