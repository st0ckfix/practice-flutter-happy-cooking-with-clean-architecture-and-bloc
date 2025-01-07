import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/models/category_detail_item_model.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_item_repository.dart';

class CategoryDetailItemRepositoryImpl extends CategoryDetailItemRepository {
  final ReadListFireStore readListFireStore;
  CategoryDetailItemRepositoryImpl({required this.readListFireStore});
  @override
  Future<Either<String, List<CategoryDetailItemModel>>> getCategoryDetailItem(String? category) async {
    // final data = await readListFireStore.readDocument(params: categoryId);
    // if (data.isEmpty) {
    //   return const Left('Empty List');
    // }
    // return Right(data.map((e) => CategoryDetailItemModel.fromJson(e.data()!)).toList());
    return Right(await fetchListCate(category));
  }
}

Future<List<CategoryDetailItemModel>> fetchListCate(String? category) async {
  await Future.delayed(const Duration(seconds: 2));
  return <String, List<CategoryDetailItemModel>>{
    'beef': cateBeef,
    'chicken': cateChicken,
    'dry': cateDry,
    'egg': cateEgg,
    'fish': cateFish,
    'fruit': cateFruit,
    'mushroom': cateMushroom,
    'pork': catePork,
    'seafood': cateSeafood,
    'seasoning': cateSeasoning,
    'vegetable': cateVegetable,
  }[category]!;
}

const cateBeef = [
  CategoryDetailItemModel(id: 'beef-bone', label: 'Bone', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-bone.png'),
  CategoryDetailItemModel(id: 'beef-brisket', label: 'Brisket', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-brisket.png'),
  CategoryDetailItemModel(id: 'beef-chuck', label: 'Chuck', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-chuck.png'),
  CategoryDetailItemModel(id: 'beef-diced', label: 'Diced', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-diced.png'),
  CategoryDetailItemModel(id: 'beef-flank', label: 'Flank', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-flank.png'),
  CategoryDetailItemModel(id: 'beef-ground', label: 'Ground', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-ground.png'),
  CategoryDetailItemModel(id: 'beef-rib', label: 'Rib', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-rib.png'),
  CategoryDetailItemModel(id: 'beef-shabu-shabu', label: 'Shabu Shabu', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-shabu-shabu.png'),
  CategoryDetailItemModel(id: 'beef-shortplate', label: 'Plate', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-shortplate.png'),
  CategoryDetailItemModel(id: 'beef-steak', label: 'Steak', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-steak.png'),
  CategoryDetailItemModel(id: 'beef-tbone', label: 'Tbone', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-tbone.png'),
  CategoryDetailItemModel(id: 'beef-tenderloin', label: 'Tenderloin', type: 'beef', image: 'assets/images/cate-detail/cate-beef/beef-tenderloin.png'),
];

const cateChicken = [
  CategoryDetailItemModel(id: 'chicken-bone', label: 'Bone', type: 'chicken', image: 'assets/images/cate-detail/cate-chicken/chicken-bone.png'),
  CategoryDetailItemModel(id: 'chicken-breast', label: 'Breast', type: 'chicken', image: 'assets/images/cate-detail/cate-chicken/chicken-breast.png'),
  CategoryDetailItemModel(id: 'chicken-drumstick', label: 'Drumstick', type: 'chicken', image: 'assets/images/cate-detail/cate-chicken/chicken-drumstick.png'),
  CategoryDetailItemModel(id: 'chicken-ground', label: 'Ground', type: 'chicken', image: 'assets/images/cate-detail/cate-chicken/chicken-ground.png'),
  CategoryDetailItemModel(id: 'chicken-thigh', label: 'Thigh', type: 'chicken', image: 'assets/images/cate-detail/cate-chicken/chicken-thigh.png'),
  CategoryDetailItemModel(id: 'chicken-whole', label: 'Whole Bird', type: 'chicken', image: 'assets/images/cate-detail/cate-chicken/chicken-whole.png'),
  CategoryDetailItemModel(id: 'chicken-wing', label: 'Wings', type: 'chicken', image: 'assets/images/cate-detail/cate-chicken/chicken-wing.png'),
];

const cateDry = [
  CategoryDetailItemModel(id: 'flour', label: 'Flour', type: 'dry', image: 'assets/images/cate-detail/cate-dry/flour.png'),
  CategoryDetailItemModel(id: 'rice', label: 'Rice', type: 'dry', image: 'assets/images/cate-detail/cate-dry/rice.png'),
];

const cateEgg = [
  CategoryDetailItemModel(id: 'egg-chicken', label: 'Chicken', type: 'egg', image: 'assets/images/cate-detail/cate-egg/egg-chicken.png'),
  CategoryDetailItemModel(id: 'egg-duck', label: 'Duck', type: 'egg', image: 'assets/images/cate-detail/cate-egg/egg-duck.png'),
  CategoryDetailItemModel(id: 'egg-quail', label: 'Quail', type: 'egg', image: 'assets/images/cate-detail/cate-egg/egg-quail.png'),
];

const cateFish = [
  CategoryDetailItemModel(id: 'fish-catfish', label: 'Catfish', type: 'fish', image: 'assets/images/cate-detail/cate-fish/fish-catfish.png'),
  CategoryDetailItemModel(id: 'fish-marlin', label: 'Marlin', type: 'fish', image: 'assets/images/cate-detail/cate-fish/fish-marlin.png'),
  CategoryDetailItemModel(id: 'fish-salmon', label: 'Salmon', type: 'fish', image: 'assets/images/cate-detail/cate-fish/fish-salmon.png'),
  CategoryDetailItemModel(id: 'fish-shark', label: 'Shark', type: 'fish', image: 'assets/images/cate-detail/cate-fish/fish-shark.png'),
  CategoryDetailItemModel(id: 'fish-tilapia', label: 'Tilapia', type: 'fish', image: 'assets/images/cate-detail/cate-fish/fish-tilapia.png'),
  CategoryDetailItemModel(id: 'fish-trout', label: 'Trout', type: 'fish', image: 'assets/images/cate-detail/cate-fish/fish-trout.png'),
  CategoryDetailItemModel(id: 'fish-tuna', label: 'Tuna', type: 'fish', image: 'assets/images/cate-detail/cate-fish/fish-tuna.png'),
];

const cateFruit = [
  CategoryDetailItemModel(id: 'fruit-pome', label: 'Pome', type: 'fruit', image: 'assets/images/cate-detail/cate-fruit/fruit-pome.png'),
  CategoryDetailItemModel(id: 'fruit-hesperidium', label: 'Hesperidium', type: 'fruit', image: 'assets/images/cate-detail/cate-fruit/fruit-hesperidium.png'),
  CategoryDetailItemModel(id: 'fruit-berry', label: 'Berry', type: 'fruit', image: 'assets/images/cate-detail/cate-fruit/fruit-berry.png'),
  CategoryDetailItemModel(id: 'fruit-drupe', label: 'Drupe', type: 'fruit', image: 'assets/images/cate-detail/cate-fruit/fruit-drupe.png'),
  CategoryDetailItemModel(id: 'fruit-pepo', label: 'Pepo', type: 'fruit', image: 'assets/images/cate-detail/cate-fruit/fruit-pepo.png'),
];

const cateMushroom = [
  CategoryDetailItemModel(id: 'enoki', label: 'Enoki', type: 'enoki', image: 'assets/images/cate-detail/cate-mushroom/enoki.png'),
  CategoryDetailItemModel(id: 'mushroom', label: 'Mushroom', type: 'mushroom', image: 'assets/images/cate-detail/cate-mushroom/mushroom.png'),
];

const catePork = [
  CategoryDetailItemModel(id: 'pork-belly', label: 'Belly', type: 'pork', image: 'assets/images/cate-detail/cate-pork/pork-belly.png'),
  CategoryDetailItemModel(id: 'pork-ground', label: 'Ground', type: 'pork', image: 'assets/images/cate-detail/cate-pork/pork-ground.png'),
  CategoryDetailItemModel(id: 'pork-ham', label: 'Ham', type: 'pork', image: 'assets/images/cate-detail/cate-pork/pork-ham.png'),
  CategoryDetailItemModel(id: 'pork-lean', label: 'Lean', type: 'pork', image: 'assets/images/cate-detail/cate-pork/pork-lean.png'),
  CategoryDetailItemModel(id: 'pork-rib', label: 'Ribs', type: 'pork', image: 'assets/images/cate-detail/cate-pork/pork-rib.png'),
  CategoryDetailItemModel(id: 'pork-tray', label: 'Tray', type: 'pork', image: 'assets/images/cate-detail/cate-pork/pork-tray.png'),
];

const cateSeafood = [
  CategoryDetailItemModel(id: 'caviar', label: 'Clam', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/caviar.png'),
  CategoryDetailItemModel(id: 'clam', label: 'Clam', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/clam.png'),
  CategoryDetailItemModel(id: 'crab', label: 'Clam', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/crab.png'),
  CategoryDetailItemModel(id: 'lobster', label: 'Lobster', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/lobster.png'),
  CategoryDetailItemModel(id: 'octopus', label: 'Octopus', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/octopus.png'),
  CategoryDetailItemModel(id: 'shrimp', label: 'Shrimp', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/shrimp.png'),
  CategoryDetailItemModel(id: 'squid', label: 'Squid', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/squid.png'),
  CategoryDetailItemModel(id: 'unagi', label: 'Squid', type: 'seafood', image: 'assets/images/cate-detail/cate-seafood/unagi.png'),
];

const cateSeasoning = [
  CategoryDetailItemModel(id: 'grain', label: 'Grain', type: 'seasoning', image: 'assets/images/cate-detail/cate-seasoning/grain.png'),
  CategoryDetailItemModel(id: 'sauce', label: 'Sauce', type: 'seasoning', image: 'assets/images/cate-detail/cate-seasoning/sauce.png'),
  CategoryDetailItemModel(id: 'liquid', label: 'Liquid', type: 'seasoning', image: 'assets/images/cate-detail/cate-seasoning/liquid.png'),
];

const cateVegetable = [
  CategoryDetailItemModel(id: 'dark-green', label: 'Dark/Green', type: 'vegetable', image: 'assets/images/cate-detail/cate-vegetable/dark-green.png'),
  CategoryDetailItemModel(id: 'red-orange', label: 'Red/Orage', type: 'vegetable', image: 'assets/images/cate-detail/cate-vegetable/red-orange.png'),
  CategoryDetailItemModel(id: 'bean-pea', label: 'Starchy', type: 'vegetable', image: 'assets/images/cate-detail/cate-vegetable/bean-pea.png'),
  CategoryDetailItemModel(id: 'others', label: 'Bean/Pea/Lentil', type: 'vegetable', image: 'assets/images/cate-detail/cate-vegetable/others.png'),
];
