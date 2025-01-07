import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/models/category_detail_model.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_repository.dart';

class CategoryDetailRepositoryImpl extends CategoryDetailRepository {
  final ReadListFireStore readListFireStore;
  CategoryDetailRepositoryImpl({required this.readListFireStore});
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
    CategoryDetailModel(id: 'beef', label: 'Beef', image: 'assets/images/cate-detail/cate-detail/cate-beef.jpg'),
    CategoryDetailModel(id: 'pork', label: 'Pork', image: 'assets/images/cate-detail/cate-detail/cate-pork.jpg'),
    CategoryDetailModel(id: 'chicken', label: 'Chicken', image: 'assets/images/cate-detail/cate-detail/cate-chicken.png'),
    CategoryDetailModel(id: 'fish', label: 'Fish', image: 'assets/images/cate-detail/cate-detail/cate-fish.jpg'),
    CategoryDetailModel(id: 'seafood', label: 'Seafood', image: 'assets/images/cate-detail/cate-detail/cate-seafood.jpg'),
    CategoryDetailModel(id: 'egg', label: 'Egg', image: 'assets/images/cate-detail/cate-detail/cate-egg.jpg'),
    CategoryDetailModel(id: 'fruit', label: 'Fruit', image: 'assets/images/cate-detail/cate-detail/cate-fruit.jpg'),
    CategoryDetailModel(id: 'vegetable', label: 'Vegetable', image: 'assets/images/cate-detail/cate-detail/cate-vegetable.jpg'),
    CategoryDetailModel(id: 'mushroom', label: 'Mushroom', image: 'assets/images/cate-detail/cate-detail/cate-mushroom.jpg'),
    CategoryDetailModel(id: 'dry', label: 'Grain/Flour', image: 'assets/images/cate-detail/cate-detail/cate-dry.jpg'),
    CategoryDetailModel(id: 'seasoning', label: 'Seasoning', image: 'assets/images/cate-detail/cate-detail/cate-seasoning.jpg'),
  ];
}
