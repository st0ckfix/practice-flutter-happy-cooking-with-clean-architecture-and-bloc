import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happy_cooking/config/theme/size.dart';

class FontSizePage extends StatefulWidget {
  const FontSizePage({super.key});

  @override
  State<FontSizePage> createState() => _FontSizePageState();
}

class _FontSizePageState extends State<FontSizePage> {
  double size = 13.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Change Font Size',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(formHeight * 2),
            margin: const EdgeInsets.only(top: defaultSize, left: defaultSize, right: defaultSize, bottom: formHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(
                  width: formHeight,
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: Text(
                      'Hello everyone, so today i want to share my new recipe about cooking chicken, hope you guys like this.\n- Ingredients: Chicken, ...\n- Prepraing: Boil Chicken,...',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      style: TextStyle(fontSize: size),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: defaultSize),
            child: Text('Post font size'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultSize, vertical: formHeight),
            child: Row(
              children: [
                Text(
                  'A',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Expanded(
                  child: Slider(
                    value: size,
                    onChanged: (value) {
                      setState(() {
                        size = value;
                      });
                    },
                    min: 13.0,
                    max: 25.0,
                    divisions: 9,
                  ),
                ),
                Text(
                  'A',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
