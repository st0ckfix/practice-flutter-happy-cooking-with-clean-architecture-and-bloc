import 'dart:math';
import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_cooking/config/theme/app_theme.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/address_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/banner_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/category_detail_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/nutrition_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/recipe_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/review_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/address_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/banner_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/nutrition_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/recipe_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/review_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/address_usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/banner_usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/category_detail_usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/nutrition_usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/recipe_usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/review_usecase.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_buying/in_buying_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_queue/in_queue_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_recipe/in_recipe_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/address/address_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/address/address_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/category_detail/category_detail_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/category_detail_item/category_detail_item_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/banner/banner_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_buying_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_queue_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_recipe_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_in_queue_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_value_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/nutrition/nutrition_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/payment_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/all_product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/review/review_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_bonus_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/marketplace_page.dart';
import 'package:intl/intl.dart';
import 'features/marketplace/data/repositories/category_detail_item_repository_impl.dart';
import 'features/marketplace/data/repositories/coupon_repository_impl.dart';
import 'features/marketplace/domain/repositories/coupon_repositery.dart';
import 'features/marketplace/domain/repositories/product_repository.dart';
import 'features/marketplace/domain/repositories/category_detail_item_repository.dart';
import 'features/marketplace/domain/usecases/category_detail_item_usecase.dart';
import 'features/marketplace/domain/usecases/coupon_usecase.dart';
import 'features/marketplace/domain/usecases/product_usecase.dart';
import 'features/marketplace/presentation/cubit/coupon/coupon_cubit.dart';
import 'features/marketplace/presentation/cubit/recipe/recipe_cubit.dart';
import 'features/marketplace/presentation/cubit/recipe_select_cubit.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final sl = GetIt.instance;

final membership = [Membership.none(), Membership.gold(), Membership.platinum(), Membership.diamond()][Random().nextInt(4)];

Future<void> initializeDependency() async {
  sl.registerSingleton<ReadListFireStore>(ReadListFireStore());

  ///
  sl.registerSingleton<CategoryDetailRepository>(
    CategoryDetailRepositoryImpl(
      readListFireStore: sl(),
    ),
  );
  sl.registerSingleton<CategoryDetailItemRepository>(
    CategoryDetailItemRepositoryImpl(
      readListFireStore: sl(),
    ),
  );
  sl.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(
      readListFireStore: sl(),
    ),
  );

  ///
  sl.registerSingleton<CategoryDetailUseCase>(
    CategoryDetailUseCase(
      categoryDetailRepository: sl(),
    ),
  );
  sl.registerSingleton<CategoryDetailItemUseCase>(
    CategoryDetailItemUseCase(
      categoryDetailItemRepository: sl(),
    ),
  );
  sl.registerSingleton<ProductUseCase>(
    ProductUseCase(
      productRepository: sl(),
    ),
  );
  sl.registerSingleton<ProductCubit>(
    ProductCubit(
      productUseCase: sl(),
    ),
  );

  ///
  sl.registerFactory<CategoryDetailCubit>(
    () => CategoryDetailCubit(
      categoryDetailUseCase: sl(),
    ),
  );
  sl.registerFactory<CategoryDetailItemCubit>(
    () => CategoryDetailItemCubit(
      categoryDetailItemUseCase: sl(),
    ),
  );

  ///
  sl.registerSingleton<CouponRepository>(
    CouponRepositoryImpl(
      readListFireStore: sl(),
    ),
  );
  sl.registerSingleton<CouponUseCase>(
    CouponUseCase(
      appCouponRepository: sl(),
    ),
  );
  sl.registerFactory<CouponCubit>(
    () => CouponCubit(
      appCouponUseCase: sl(),
      inBuyingCostCubit: sl(),
    ),
  );

    sl.registerSingleton<RecipeSelectCubit>(
    RecipeSelectCubit(
      productCubit: sl(),
    ),
  );

  ///
  sl.registerSingleton<InQueueBloc>(
    InQueueBloc(),
  );
  sl.registerSingleton<InBuyingBloc>(
    InBuyingBloc(),
  );
  sl.registerSingleton<InRecipeBloc>(
    InRecipeBloc(
      productCubit: sl(),
      recipeSelectCubit: sl(),
    ),
  );

  sl.registerSingleton<MembershipCubit>(
    MembershipCubit(
      membership,
    ),
  );
  sl.registerSingleton<ProductSelectCubit>(
    ProductSelectCubit(),
  );

  

  ///
  sl.registerSingleton<InQueueCostCubit>(
    InQueueCostCubit(
      inQueueBloc: sl(),
      productCubit: sl(),
    ),
  );
  sl.registerSingleton<InBuyingCostCubit>(
    InBuyingCostCubit(
      inBuyingBloc: sl(),
      productCubit: sl(),
    ),
  );
  sl.registerSingleton<InRecipeCostCubit>(
    InRecipeCostCubit(
      inRecipeBloc: sl(),
      productCubit: sl(),
    ),
  );

  ///
  sl.registerSingleton<CouponSelectCubit>(
    CouponSelectCubit(
      inBuyingCostCubit: sl(),
    ),
  );
  sl.registerSingleton<CouponInQueueCubit>(
    CouponInQueueCubit(
      couponSelectCubit: sl(),
    ),
  );
  sl.registerSingleton<CouponValueCubit>(
    CouponValueCubit(
      inBuyingCostCubit: sl(),
      couponSelectCubit: sl(),
    ),
  );

  ///
  sl.registerSingleton<DeliveryCostCubit>(
    DeliveryCostCubit(),
  );
  sl.registerSingleton<DeliveryDiscountCubit>(
    DeliveryDiscountCubit(
      membershipCubit: sl(),
    ),
  );

  ///
  sl.registerSingleton<TokenDiscountCubit>(
    TokenDiscountCubit(),
  );
  sl.registerSingleton<TokenBonusCubit>(
    TokenBonusCubit(
      membershipCubit: sl(),
      inBuyingCostCubit: sl(),
    ),
  );
  sl.registerSingleton<TotalCubit>(
    TotalCubit(
      productCostCubit: sl(),
      deliveryCostCubit: sl(),
      deliveryDiscountCubit: sl(),
      tokenDiscountCubit: sl(),
      tokenBonusCubit: sl(),
      couponValueCubit: sl(),
    ),
  );

  ///
  sl.registerSingleton<AllProductCubit>(
    AllProductCubit(),
  );

  ///
  sl.registerSingleton<RecipeRepository>(
    RecipeRepositoryImpl(
      readListFireStore: sl(),
    ),
  );
  sl.registerSingleton<RecipeUseCase>(
    RecipeUseCase(
      recipeRepository: sl(),
    ),
  );
  sl.registerSingleton<AllRecipeCubit>(
    AllRecipeCubit(
      recipeUseCase: sl(),
    ),
  );

  ///
  sl.registerSingleton<BannerRepository>(
    BannerRepositoryImpl(
      readListFireStore: sl(),
    ),
  );
  sl.registerSingleton<BannerUseCase>(
    BannerUseCase(
      bannerRepository: sl(),
    ),
  );
  sl.registerSingleton<BannerCubit>(
    BannerCubit(
      bannerUseCase: sl(),
    ),
  );

  ///
  sl.registerSingleton<NutritionRepository>(
    NutritionRepositoryImpl(
      readListFireStore: sl(),
    ),
  );
  sl.registerSingleton<NutritionUseCase>(
    NutritionUseCase(
      nutritionRepository: sl(),
    ),
  );
  sl.registerFactory<NutritionCubit>(
    () => NutritionCubit(
      nutritionUseCase: sl(),
    ),
  );

  ///
  sl.registerSingleton<ReviewRepository>(
    ReviewRepositoryImpl(
      readListFireStore: sl(),
    ),
  );
  sl.registerSingleton<ReviewUseCase>(
    ReviewUseCase(
      recipeRepository: sl(),
    ),
  );
  sl.registerFactory<ReviewCubit>(
    () => ReviewCubit(
      reviewUseCase: sl(),
    ),
  );

  ///
  sl.registerSingleton<PaymentCubit>(
    PaymentCubit(),
  );
  sl.registerSingleton<AddressRepository>(
    AddressRepositoryImpl(),
  );
  sl.registerSingleton<AddressUseCase>(
    AddressUseCase(
      addressRepository: sl(),
    ),
  );
  sl.registerSingleton<AddressCubit>(
    AddressCubit(
      addressUseCase: sl(),
    ),
  );
  sl.registerSingleton<AddressSelectCubit>(
    AddressSelectCubit(
      addressCubit: sl(),
    ),
  );
}

DateFormat formattedDate = DateFormat('HH:mm:ss.S');

void logg(String title, String subtitle, String message) {
  dev.log('-${formattedDate.format(DateTime.now())}-[$title]: $subtitle -> $message');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependency();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CouponCubit>(create: (context) => sl<CouponCubit>()..fetchListCoupon()),
        BlocProvider<ProductCubit>(create: (context) => sl<ProductCubit>()),
        BlocProvider<CategoryDetailCubit>(create: (context) => sl<CategoryDetailCubit>()),
        BlocProvider<CategoryDetailItemCubit>(create: (context) => sl<CategoryDetailItemCubit>()),

        ///
        BlocProvider<InBuyingBloc>(create: (context) => sl<InBuyingBloc>()),
        BlocProvider<InQueueBloc>(create: (context) => sl<InQueueBloc>()),
        BlocProvider<InRecipeBloc>(create: (context) => sl<InRecipeBloc>()),

        ///
        BlocProvider<ProductSelectCubit>(create: (context) => sl<ProductSelectCubit>()),
        BlocProvider<MembershipCubit>(create: (context) => sl<MembershipCubit>()),

        ///
        BlocProvider<InRecipeCostCubit>(create: (context) => sl<InRecipeCostCubit>()),
        BlocProvider<InQueueCostCubit>(create: (context) => sl<InQueueCostCubit>()),
        BlocProvider<InBuyingCostCubit>(create: (context) => sl<InBuyingCostCubit>()),

        ///
        BlocProvider<CouponInQueueCubit>(create: (context) => sl<CouponInQueueCubit>()),
        BlocProvider<CouponSelectCubit>(create: (context) => sl<CouponSelectCubit>()),
        BlocProvider<CouponValueCubit>(create: (context) => sl<CouponValueCubit>()),

        ///
        BlocProvider<DeliveryCostCubit>(create: (context) => sl<DeliveryCostCubit>()),
        BlocProvider<DeliveryDiscountCubit>(create: (context) => sl<DeliveryDiscountCubit>()),

        ///
        BlocProvider<TokenDiscountCubit>(create: (context) => sl<TokenDiscountCubit>()),
        BlocProvider<TokenBonusCubit>(create: (context) => sl<TokenBonusCubit>()),
        BlocProvider<TotalCubit>(create: (context) => sl<TotalCubit>()),

        ///
        BlocProvider<AllProductCubit>(create: (context) => sl<AllProductCubit>()),
        BlocProvider<RecipeSelectCubit>(create: (context) => sl<RecipeSelectCubit>()),

        ///
        ///
        BlocProvider<AllRecipeCubit>(create: (context) => sl<AllRecipeCubit>()),
        BlocProvider<BannerCubit>(create: (context) => sl<BannerCubit>()),

        ///
        ///
        BlocProvider<ReviewCubit>(create: (context) => sl<ReviewCubit>()),
        BlocProvider<NutritionCubit>(create: (context) => sl<NutritionCubit>()),

        ///
        BlocProvider<PaymentCubit>(create: (context) => sl<PaymentCubit>()),
        BlocProvider<AddressCubit>(create: (context) => sl<AddressCubit>()),
        BlocProvider<AddressSelectCubit>(create: (context) => sl<AddressSelectCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomAppTheme().lightTheme,
      darkTheme: CustomAppTheme().darkTheme,
      themeMode: ThemeMode.system,
      home: const MarketPlacePage(),
    );
  }
}
