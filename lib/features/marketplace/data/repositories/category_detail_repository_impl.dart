import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/models/category_detail_model.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_repository.dart';

class CategoryDetailRepositoryImpl extends CategoryDetailRepository {
  final ReadListFireStore readListFireStore;
  CategoryDetailRepositoryImpl(this.readListFireStore);
  @override
  Future<Either<String, List<CategoryDetailModel>>> getCategoryDetail() async {
    // final data = await readListFireStore.readDocument(params: 'categoryDetail');
    // if (data.isEmpty) {
    //   return const Left('Empty List');
    // }
    // return Right(data.map((e) => CategoryDetailModel.fromJson(e.data()!)).toList());
    return Right(await fetchListCate());
  }
}

Future fetchListCate() async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    CategoryDetailModel(id: 'cate_beef', label: 'Beef', image: 'assets/images/cate_detail/cate_detail/cate_beef.jpg'),
    CategoryDetailModel(id: 'cate_pork', label: 'Pork', image: 'assets/images/cate_detail/cate_detail/cate_pork.jpg'),
    CategoryDetailModel(id: 'cate_chicken', label: 'Chicken', image: 'assets/images/cate_detail/cate_detail/cate_chicken.png'),
    CategoryDetailModel(id: 'cate_fish', label: 'Fish', image: 'assets/images/cate_detail/cate_detail/cate_fish.jpg'),
    CategoryDetailModel(id: 'cate_crab', label: 'Crab', image: 'assets/images/cate_detail/cate_detail/cate_crab.jpg'),
    CategoryDetailModel(id: 'cate_seafood', label: 'Seafood', image: 'assets/images/cate_detail/cate_detail/cate_seafood.jpg'),
    CategoryDetailModel(id: 'cate_egg', label: 'Egg', image: 'assets/images/cate_detail/cate_detail/cate_egg.jpg'),
    CategoryDetailModel(id: 'cate_fruit', label: 'Fruit', image: 'assets/images/cate_detail/cate_detail/cate_fruit.jpg'),
    CategoryDetailModel(id: 'cate_vegetable', label: 'Vegetable', image: 'assets/images/cate_detail/cate_detail/cate_vegetable.jpg'),
    CategoryDetailModel(id: 'cate_mushroom', label: 'Mushroom', image: 'assets/images/cate_detail/cate_detail/cate_mushroom.jpg'),
    CategoryDetailModel(id: 'cate_powder', label: 'Grain/Powder', image: 'assets/images/cate_detail/cate_detail/cate_powder.jpg'),
    CategoryDetailModel(id: 'cate_seasoning', label: 'Seasoning', image: 'assets/images/cate_detail/cate_detail/cate_seasoning.jpg'),
  ];
}
