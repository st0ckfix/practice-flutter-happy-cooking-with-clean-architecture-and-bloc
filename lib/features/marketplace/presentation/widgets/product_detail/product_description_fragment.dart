import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescriptionFragment extends StatelessWidget {
  const ProductDescriptionFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
        title: const Text('Product Description Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.redAccent,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'The potato (/pəˈteɪtoʊ/) is a starchy root vegetable native to the Americas that is consumed as a staple food in many parts of the world. Potatoes are tubers of the plant Solanum tuberosum, a perennial in the nightshade family Solanaceae.\n\n'
                'Wild potato species can be found from the southern United States to southern Chile. Genetic studies show that the cultivated potato has a single origin, in the area of present-day southern Peru and extreme northwestern Bolivia. Potatoes were domesticated there about 7,000–10,000 years ago from a species in the S. brevicaule complex. Many varieties of the potato are cultivated in the Andes region of South America, where the species is indigenous.\n\n'
                'The Spanish introduced potatoes to Europe in the second half of the 16th century from the Americas. They are a staple food in many parts of the world and an integral part of much of the world\'s food supply. Following millennia of selective breeding, there are now over 5,000 different varieties of potatoes. The potato remains an essential crop in Europe, especially Northern and Eastern Europe, where per capita production is still the highest in the world, while the most rapid expansion in production during the 21st century was in southern and eastern Asia, with China and India leading the world production as of 2021.\n\n'
                'Like the tomato and the nightshades, the potato is in the genus Solanum; the aerial parts of the potato contain the toxin solanine. Normal potato tubers that have been grown and stored properly produce glycoalkaloids in negligible amounts, but, if sprouts and potato skins are exposed to light, tubers can become toxic.',
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
