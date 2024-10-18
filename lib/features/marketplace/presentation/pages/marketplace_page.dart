// import 'package:chips_choice/chips_choice.dart';
// import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:happy_cooking/config/theme/size.dart';
// import 'package:happy_cooking/features/marketplace/presentation/bloc/market/market_bloc.dart';
// import 'package:happy_cooking/features/marketplace/presentation/pages/market_detail_page.dart';

// class MarketplacePage extends StatefulWidget {
//   const MarketplacePage({super.key});
//   @override
//   createState() => _MarketplacePage();
// }

// class _MarketplacePage extends State<MarketplacePage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<MarketBloc>().add(const GetMarketEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.menu),
//         ),
//         title: const Text('Marketplace'),
//         actions: [
//           badges.Badge(
//             badgeContent: const Text('2'),
//             child: const Icon(Icons.shopping_bag_outlined),
//             onTap: () {},
//           )
//         ],
//       ),
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(formHeight),
//                 child: SearchBar(
//                   surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
//                   shadowColor: const MaterialStatePropertyAll(Colors.transparent),
//                   elevation: const MaterialStatePropertyAll(0),
//                   shape: const MaterialStatePropertyAll(StadiumBorder(
//                     side: BorderSide(
//                       color: Colors.black,
//                       width: 1.0,
//                     ),
//                   )),
//                   backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
//                   hintText: 'Chicken, Beef, ...',
//                   hintStyle: const MaterialStatePropertyAll(TextStyle(
//                     fontStyle: FontStyle.italic,
//                     color: Colors.grey,
//                   )),
//                   leading: const Icon(Icons.search),
//                   trailing: [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: StatefulBuilder(
//                 builder: (context, state) {
//                   return const SizedBox();
//                   // return ChipsChoice<String>.single(
//                   //   value: '',
//                   //   onChanged: (value) {
//                   //     // state(() {
//                   //     //   select = value;
//                   //     //   context.read<MarketBloc>().add(FilterMarketEvent(value));
//                   //     // });
//                   //   },
//                   //   choiceItems: C2Choice.listFrom<ShoppingTag, ShoppingTag>(
//                   //     source: ShoppingTag.values,
//                   //     value: (_, tag) => tag,
//                   //     label: (_, tag) => tag.name,
//                   //   ),
//                   // );
//                 },
//               ),
//             ),
//           ];
//         },
//         body: BlocBuilder<MarketBloc, MarketState>(
//           builder: (context, state) {
//             if (state is MarketLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (state is MarketLoaded) {
//               if (state.listMarkets!.isEmpty) {
//                 return const Center(
//                   child: Text('No result returning'),
//                 );
//               }
//               return GridView.builder(
//                 itemCount: state.listMarkets!.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1 / 1.2,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = state.listMarkets![index];
//                   return InkWell(
//                     onTap: () {
//                       Get.to(() => MarketDetailPage(marketId: item.id));
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(10),
//                       alignment: Alignment.center,
//                       clipBehavior: Clip.hardEdge,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//                             child: Image.asset(
//                               item.image,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(item.name),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }
