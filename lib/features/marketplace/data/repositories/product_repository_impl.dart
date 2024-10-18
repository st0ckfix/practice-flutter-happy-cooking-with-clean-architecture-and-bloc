import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/models/product_model.dart';

import '../../domain/repositories/product_repository.dart';

final listProduct = <ProductModel>[];
final types = [
  'beef_chuck',
  'beef_ground',
  'beef_rib',
  'beef_shortplate',
  'beef_tbone',
  'beef_tenderloin',
  'chicken_breast',
  'chicken_drumstick',
  'chicken_wing',
  'crab_claw',
  'crab_leg',
  'crab_stick',
  'crab_whole',
  'egg_chicken',
  'egg_duck',
  'egg_quail',
  'fish_salmon',
  'fish_tilapia',
  'fish_tuna',
  'fruit_berry',
  'fruit_drupe',
  'fruit_hesperidium',
  'fruit_pepo',
  'fruit_pome',
  'nam_enoki_mushroom',
  'nam_mushroom',
  'nam_oyster_mushroom',
  'pork_belly',
  'pork_ground',
  'pork_ham',
  'pork_lean',
  'powder_baking_soda',
  'powder_flour',
  'powder_rice',
  'sea_clam',
  'sea_lobster',
  'sea_octopus',
  'sea_shrimp',
  'sea_squid',
  'ssn_acid',
  'ssn_hot',
  'ssn_oil',
  'ssn_saccharine',
  'ssn_saline',
  'vegetable_beans_peas_and_lentils',
  'vegetable_dark_green',
  'vegetable_other',
  'vegetable_red_orange',
  'vegetable_starchy',
];

class ProductRepositoryImpl extends ProductRepository {
  final ReadListFireStore readListFireStore;
  ProductRepositoryImpl(this.readListFireStore);

  @override
  Future<Either<String, List<ProductModel>>> getProduct(String tag) async {
    return Right(await fetchGroceries(tag));
  }
}

Future<List<ProductModel>> fetchGroceries(String tag) async {
  await Future.delayed(const Duration(seconds: 3));
  if (listProduct.isEmpty) {
    for (final item in types) {
      listProduct.addAll(
        List.filled(
          5,
          ProductModel(
            id: item + Random().nextInt(1000).toString(),
            label: item + Random().nextInt(1000).toString(),
            image: '',
            tags: [item],
          ),
        ),
      );
    }
  }
  return listProduct.where((element) => element.tags.contains(tag)).toList();
}
