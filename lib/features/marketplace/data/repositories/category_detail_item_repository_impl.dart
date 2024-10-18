import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/models/category_detail_item_model.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_item_repository.dart';

class CategoryDetailItemRepositoryImpl extends CategoryDetailItemRepository {
  final ReadListFireStore readListFireStore;
  CategoryDetailItemRepositoryImpl(this.readListFireStore);
  @override
  Future<Either<String, List<CategoryDetailItemModel>>> getCategoryDetailItem(String? categoryId) async {
    // final data = await readListFireStore.readDocument(params: categoryId);
    // if (data.isEmpty) {
    //   return const Left('Empty List');
    // }
    // return Right(data.map((e) => CategoryDetailItemModel.fromJson(e.data()!)).toList());
    return Right(await fetchListCate(categoryId!));
  }
}

Future<List<CategoryDetailItemModel>> fetchListCate(String id) async {
  await Future.delayed(const Duration(seconds: 2));
  return <String, List<CategoryDetailItemModel>>{
    'cate_beef': cateBeef,
    'cate_pork': catePork,
    'cate_chicken': cateChicken,
    'cate_fish': cateFish,
    'cate_crab': cateCrab,
    'cate_seafood': cateSeafood,
    'cate_egg': cateEgg,
    'cate_fruit': cateFruit,
    'cate_vegetable': cateVegetable,
    'cate_mushroom': cateMushroom,
    'cate_powder': catePowder,
    'cate_seasoning': cateSeasoning,
  }[id]!;
}

const cateBeef = [
  CategoryDetailItemModel(id: 'beef_chuck', label: 'Chuck', image: 'assets/images/cate_detail/cate_beef/beef_chuck.png'),
  CategoryDetailItemModel(id: 'beef_ground', label: 'Ground', image: 'assets/images/cate_detail/cate_beef/beef_ground.png'),
  CategoryDetailItemModel(id: 'beef_rib', label: 'Ribs', image: 'assets/images/cate_detail/cate_beef/beef_rib.png'),
  CategoryDetailItemModel(id: 'beef_shortplate', label: 'Plate', image: 'assets/images/cate_detail/cate_beef/beef_shortplate.png'),
  CategoryDetailItemModel(id: 'beef_tenderloin', label: 'Tenderloin', image: 'assets/images/cate_detail/cate_beef/beef_tenderloin.png'),
];

const cateChicken = [
  CategoryDetailItemModel(id: 'chicken_breast', label: 'Breast', image: 'assets/images/cate_detail/cate_chicken/chicken_breast.png'),
  CategoryDetailItemModel(id: 'chicken_drumstick', label: 'Drumstick', image: 'assets/images/cate_detail/cate_chicken/chicken_drumstick.png'),
  CategoryDetailItemModel(id: 'chicken_wing', label: 'Wing', image: 'assets/images/cate_detail/cate_chicken/chicken_wing.png'),
];

const cateCrab = [
  CategoryDetailItemModel(id: 'crab_whole', label: 'Whole Crab', image: 'assets/images/cate_detail/cate_crab/crab_whole.png'),
  CategoryDetailItemModel(id: 'crab_claw', label: 'Claw', image: 'assets/images/cate_detail/cate_crab/crab_claw.png'),
  CategoryDetailItemModel(id: 'crab_leg', label: 'Leg', image: 'assets/images/cate_detail/cate_crab/crab_leg.png'),
  CategoryDetailItemModel(id: 'crab_stick', label: 'Stick', image: 'assets/images/cate_detail/cate_crab/crab_stick.png'),
];

const cateEgg = [
  CategoryDetailItemModel(id: 'egg_chicken', label: 'Chicken', image: 'assets/images/cate_detail/cate_egg/egg_chicken.png'),
  CategoryDetailItemModel(id: 'egg_duck', label: 'Duck', image: 'assets/images/cate_detail/cate_egg/egg_duck.png'),
  CategoryDetailItemModel(id: 'egg_quail', label: 'Quail', image: 'assets/images/cate_detail/cate_egg/egg_quail.png'),
];

const cateFish = [
  CategoryDetailItemModel(id: 'fish_salmon', label: 'Salmon', image: 'assets/images/cate_detail/cate_fish/fish_salmon.png'),
  CategoryDetailItemModel(id: 'fish_tuna', label: 'Tuna', image: 'assets/images/cate_detail/cate_fish/fish_tuna.png'),
  CategoryDetailItemModel(id: 'fish_tilapia', label: 'Tilapia', image: 'assets/images/cate_detail/cate_fish/fish_tilapia.png'),
];

const cateFruit = [
  CategoryDetailItemModel(id: 'fruit_pome', label: 'Pome', image: 'assets/images/cate_detail/cate_fruit/fruit_pome.png'),
  CategoryDetailItemModel(id: 'fruit_hesperidium', label: 'Hesperidium', image: 'assets/images/cate_detail/cate_fruit/fruit_hesperidium.png'),
  CategoryDetailItemModel(id: 'fruit_berry', label: 'Berry', image: 'assets/images/cate_detail/cate_fruit/fruit_berry.png'),
  CategoryDetailItemModel(id: 'fruit_drupe', label: 'Drupe', image: 'assets/images/cate_detail/cate_fruit/fruit_drupe.png'),
  CategoryDetailItemModel(id: 'fruit_pepo', label: 'Pepo', image: 'assets/images/cate_detail/cate_fruit/fruit_pepo.png'),
  CategoryDetailItemModel(id: 'fruit_tropical', label: 'Tropical', image: 'assets/images/cate_detail/cate_fruit/fruit_tropical.png'),
];

const cateMushroom = [
  CategoryDetailItemModel(id: 'nam_enoki_mushroom', label: 'Enoki Mushroom', image: 'assets/images/cate_detail/cate_mushroom/nam_enoki_mushroom.png'),
  CategoryDetailItemModel(id: 'nam_mushroom', label: 'Mushroom', image: 'assets/images/cate_detail/cate_mushroom/nam_mushroom.png'),
  CategoryDetailItemModel(id: 'nam_oyster_mushroom', label: 'Oyster Mushroom', image: 'assets/images/cate_detail/cate_mushroom/nam_oyster_mushroom.png'),
];

const catePork = [
  CategoryDetailItemModel(id: 'pork_belly', label: 'Belly', image: 'assets/images/cate_detail/cate_pork/pork_belly.png'),
  CategoryDetailItemModel(id: 'pork_ground', label: 'Ground', image: 'assets/images/cate_detail/cate_pork/pork_ground.png'),
  CategoryDetailItemModel(id: 'pork_ham', label: 'Ham', image: 'assets/images/cate_detail/cate_pork/pork_ham.png'),
  CategoryDetailItemModel(id: 'pork_lean', label: 'Lean', image: 'assets/images/cate_detail/cate_pork/pork_lean.png'),
];

const catePowder = [
  CategoryDetailItemModel(id: 'powder_baking_soda', label: 'Baking Soda', image: 'assets/images/cate_detail/cate_powder/powder_baking_soda.png'),
  CategoryDetailItemModel(id: 'powder_flour', label: 'Flour', image: 'assets/images/cate_detail/cate_powder/powder_flour.png'),
  CategoryDetailItemModel(id: 'powder_rice', label: 'Rice', image: 'assets/images/cate_detail/cate_powder/powder_rice.png'),
];

const cateSeafood = [
  CategoryDetailItemModel(id: 'sea_clam', label: 'Clam', image: 'assets/images/cate_detail/cate_seafood/sea_clam.png'),
  CategoryDetailItemModel(id: 'sea_lobster', label: 'Lobster', image: 'assets/images/cate_detail/cate_seafood/sea_lobster.png'),
  CategoryDetailItemModel(id: 'sea_octopus', label: 'Octopus', image: 'assets/images/cate_detail/cate_seafood/sea_octopus.png'),
  CategoryDetailItemModel(id: 'sea_shrimp', label: 'Shrimp', image: 'assets/images/cate_detail/cate_seafood/sea_shrimp.png'),
  CategoryDetailItemModel(id: 'sea_squid', label: 'Squid', image: 'assets/images/cate_detail/cate_seafood/sea_squid.png'),
];

const cateSeasoning = [
  CategoryDetailItemModel(id: 'ssn_saline', label: 'Saline', image: 'assets/images/cate_detail/cate_seasoning/ssn_saline.png'),
  CategoryDetailItemModel(id: 'ssn_saccharine', label: 'Saccharine', image: 'assets/images/cate_detail/cate_seasoning/ssn_saccharine.png'),
  CategoryDetailItemModel(id: 'ssn_hot', label: 'Hot', image: 'assets/images/cate_detail/cate_seasoning/ssn_hot.png'),
  CategoryDetailItemModel(id: 'ssn_acid', label: 'Acid', image: 'assets/images/cate_detail/cate_seasoning/ssn_acid.png'),
  CategoryDetailItemModel(id: 'ssn_oil', label: 'Oil', image: 'assets/images/cate_detail/cate_seasoning/ssn_oil.png'),
];

const cateVegetable = [
  CategoryDetailItemModel(id: 'vegetable_dark_green', label: 'Dark/Green', image: 'assets/images/cate_detail/cate_vegetable/vegetable_dark_green.png'),
  CategoryDetailItemModel(id: 'vegetable_red_orange', label: 'Red/Orage', image: 'assets/images/cate_detail/cate_vegetable/vegetable_red_orange.png'),
  CategoryDetailItemModel(id: 'vegetable_starchy', label: 'Starchy', image: 'assets/images/cate_detail/cate_vegetable/vegetable_starchy.png'),
  CategoryDetailItemModel(id: 'vegetable_beans_peas_and_lentils', label: 'Bean/Pea/Lentil', image: 'assets/images/cate_detail/cate_vegetable/vegetable_beans_peas_and_lentils.png'),
  CategoryDetailItemModel(id: 'vegetable_other', label: 'Others', image: 'assets/images/cate_detail/cate_vegetable/vegetable_other.png'),
];
