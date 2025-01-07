import 'package:chips_choice/chips_choice.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/detail_rating_full_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CommentFragment extends StatelessWidget {
  const CommentFragment({super.key});

  @override
  Widget build(BuildContext context) {
    int valueItem = -1;
    List<String> listValue = [];
    final listWidgets = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    '4.5',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    isHalfAllowed: true,
                    halfFilledIcon: Icons.star_half,
                    initialRating: 4.5,
                    maxRating: 5,
                    size: 22,
                  ),
                  const Text('45 rated'),
                ],
              ),
            ),
            const Expanded(child: DetailRatingFullWidget(listReviews: []))
          ],
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minLeadingWidth: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text('General customer ratings'),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                minLeadingWidth: 0,
                title: CircularPercentIndicator(
                  radius: 30,
                  lineWidth: 5.0,
                  percent: 1.0,
                  center: const Text("100%"),
                  progressColor: Colors.green,
                ),
                subtitle: const Text(
                  'Fresh',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                minLeadingWidth: 0,
                title: CircularPercentIndicator(
                  radius: 30,
                  lineWidth: 5.0,
                  percent: 0.85,
                  center: const Text("85%"),
                  progressColor: Colors.green,
                ),
                subtitle: const Text(
                  'Good Quality',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                minLeadingWidth: 0,
                title: CircularPercentIndicator(
                  radius: 30,
                  lineWidth: 5.0,
                  percent: 0.8,
                  center: const Text("80%"),
                  progressColor: Colors.green,
                ),
                subtitle: const Text(
                  'Affordable Price',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                minLeadingWidth: 0,
                title: CircularPercentIndicator(
                  radius: 30,
                  lineWidth: 5.0,
                  percent: 0.97,
                  center: const Text("97%"),
                  progressColor: Colors.green,
                ),
                subtitle: const Text(
                  'Good Service',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ListTile(
            horizontalTitleGap: 0,
            title: const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('All Images'),
            ),
            subtitle: SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == 4) {
                    return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pinkAccent,
                      ),
                      child: const Center(
                        child: Text('+650'),
                      ),
                    );
                  }
                  return Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.pinkAccent,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemCount: 5,
              ),
            ),
          ),
        ),
      ),
      IntrinsicHeight(
        child: Column(
          children: [
            StatefulBuilder(
              builder: (context, stateful) {
                return ChipsChoice<int>.single(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  wrapped: true,
                  direction: Axis.horizontal,
                  value: valueItem,
                  onChanged: (value) {},
                  choiceBuilder: (item, i) {
                    return IntrinsicWidth(
                      child: InkWell(
                        onTap: () {
                          stateful(() {
                            item.value == valueItem ? valueItem = -1 : valueItem = item.value;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: valueItem == i ? Colors.blue : Colors.black),
                            color: valueItem == i ? Colors.lightBlue : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Text(
                                (i + 1).toString(),
                                style: TextStyle(
                                  fontWeight: valueItem == i ? FontWeight.bold : FontWeight.normal,
                                  color: valueItem == i ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(width: 5),
                              valueItem == i ? const Icon(Icons.star, color: Colors.yellow) : const Icon(Icons.star_border),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  choiceItems: C2Choice.listFrom<int, int>(
                    source: [1, 2, 3, 4, 5],
                    value: (index, item) => index,
                    label: (index, item) => '',
                  ),
                );
              },
            ),
            const Divider(thickness: 2, height: 5),
            SizedBox(
              width: double.maxFinite,
              child: StatefulBuilder(
                builder: (context, stateful) {
                  return ChipsChoice<String>.multiple(
                    wrapped: true,
                    direction: Axis.horizontal,
                    value: listValue,
                    onChanged: (value) {},
                    choiceBuilder: (item, i) {
                      return IntrinsicWidth(
                        child: InkWell(
                          onTap: () {
                            stateful(() {
                              listValue.contains(item.value) ? listValue.remove(item.value) : listValue.add(item.value);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: listValue.contains(item.value) ? Colors.blue : Colors.black),
                              color: listValue.contains(item.value) ? Colors.lightBlue : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  item.value,
                                  style: TextStyle(
                                    fontWeight: listValue.contains(item.value) ? FontWeight.bold : FontWeight.normal,
                                    color: listValue.contains(item.value) ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    choiceItems: C2Choice.listFrom<String, String>(
                      source: ['Latest', 'Have Image', 'Fesh', 'Quality', 'Price', 'Service'],
                      value: (index, item) => item,
                      label: (index, item) => item,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      const Column(
        children: [
          ListTile(
            leading: CircleAvatar(minRadius: 15, maxRadius: 15),
            title: Text('Johnny Wood'),
            subtitle: Row(
              children: [
                Icon(Icons.playlist_add_check),
                Text('3 Rated'),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.thumb_up),
                Text('125 Liked'),
              ],
            ),
          ),
          // CommentWidget(
          //   imageLength: 7,
          //   imageSize: 250,
          //   imageLimit: 5,
          //   crossAxisCount: 3,
          //   axis: Axis.vertical,
          // )
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
        title: const Text('Product Rating'),
      ),
      body: ListView.separated(
        itemCount: listWidgets.length,
        itemBuilder: (context, index) {
          return listWidgets[index];
        },
        separatorBuilder: (context, index) {
          return const Divider(thickness: 5, height: 10);
        },
      ),
    );
  }
}
