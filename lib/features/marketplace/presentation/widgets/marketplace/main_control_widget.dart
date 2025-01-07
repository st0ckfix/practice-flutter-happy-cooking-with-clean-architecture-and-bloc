import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/order_history_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/best_sellers_fragment.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/top_deals_fragment.dart';

class MainControlWidget extends StatelessWidget {
  const MainControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cateControlList = [
      CateControl.membership(),
      CateControl.topDeal(),
      CateControl.seller(),
      CateControl.history(),
    ];
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 20, left: 10, right: 5),
      width: double.maxFinite,
      child: GridView.builder(
        itemCount: cateControlList.length,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: (MediaQuery.of(context).size.width - 30) / 4,
        ),
        itemBuilder: (_, index) {
          final cateControl = cateControlList[index];
          return InkWell(
            onTap: () {
              switch (cateControl.id) {
                case 'membership':
                  Get.to(() => const MembershipFragment(), duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                case 'sellers':
                  Get.to(() => const BestSellersFragment(), duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                case 'deals':
                  Get.to(() => const TopDealsFragment(), duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                case 'history':
                  Get.to(() => const OrderHistoryPage(), duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                default:
              }
            },
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cateControl.color,
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    cateControl.thumbnail,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    cateControl.label,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MembershipFragment extends StatelessWidget {
  const MembershipFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CateControl {
  final String id;
  final String thumbnail;
  final String label;
  final Color color;

  CateControl({
    required this.id,
    required this.label,
    required this.thumbnail,
    required this.color,
  });

  factory CateControl.membership() {
    return CateControl(
      id: 'membership',
      label: 'Membership',
      thumbnail: 'assets/images/icon/membership.png',
      color: const Color.fromARGB(255, 39, 215, 255),
    );
  }

  factory CateControl.seller() {
    return CateControl(
      id: 'sellers',
      label: 'Best Seller',
      thumbnail: 'assets/images/icon/seller.png',
      color: const Color.fromARGB(255, 238, 77, 3),
    );
  }

  factory CateControl.topDeal() {
    return CateControl(
      id: 'deals',
      label: 'Top Deals',
      thumbnail: 'assets/images/icon/top_deal.png',
      color: const Color.fromARGB(255, 255, 0, 0),
    );
  }

  factory CateControl.history() {
    return CateControl(
      id: 'history',
      label: 'Order & History',
      thumbnail: 'assets/images/icon/calander.png',
      color: const Color.fromARGB(255, 255, 230, 0),
    );
  }
}
