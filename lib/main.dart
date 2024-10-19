import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_cooking/config/theme/app_theme.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/category_detail_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/category_detail_usecase.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/category_detail/category_detail_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/category_detail_item/category_detail_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/product/product_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cost_cubit.dart';
import 'features/marketplace/data/repositories/category_detail_item_repository_impl.dart';
import 'features/marketplace/data/repositories/coupon_repository_impl.dart';
import 'features/marketplace/domain/repositories/coupon_repositery.dart';
import 'features/marketplace/domain/repositories/product_repository.dart';
import 'features/marketplace/domain/repositories/category_detail_item_repository.dart';
import 'features/marketplace/domain/usecases/category_detail_item_usecase.dart';
import 'features/marketplace/domain/usecases/coupon_usecase.dart';
import 'features/marketplace/domain/usecases/product_usecase.dart';
import 'features/marketplace/presentation/cubit/coupon/coupon_cubit.dart';
import 'features/marketplace/presentation/cubit/product_manager_cubit.dart';
import 'features/marketplace/presentation/pages/product_filter_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final sl = GetIt.instance;

Future<void> initializeDependency() async {
  sl.registerSingleton<ReadListFireStore>(ReadListFireStore());

  ///
  sl.registerSingleton<CategoryDetailRepository>(CategoryDetailRepositoryImpl(sl()));
  sl.registerSingleton<CategoryDetailItemRepository>(CategoryDetailItemRepositoryImpl(sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(sl()));

  ///
  sl.registerSingleton<CategoryDetailUseCase>(CategoryDetailUseCase(sl()));
  sl.registerSingleton<CategoryDetailItemUseCase>(CategoryDetailItemUseCase(sl()));
  sl.registerSingleton<ProductUseCase>(ProductUseCase(sl()));

  ///
  sl.registerFactory<CategoryDetailBloc>(() => CategoryDetailBloc(sl()));
  sl.registerFactory<CategoryDetailItemBloc>(() => CategoryDetailItemBloc(sl()));

  ///
  sl.registerSingleton<CouponRepository>(CouponRepositoryImpl(sl()));
  sl.registerSingleton<CouponUseCase>(CouponUseCase(sl()));
  sl.registerFactory<CouponCubit>(() => CouponCubit(sl()));
}

void main() async {
  await initializeDependency();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CouponCubit>(create: (context) => CouponCubit(sl())),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc(sl())),
        BlocProvider<CategoryDetailBloc>(create: (context) => CategoryDetailBloc(sl())),
        BlocProvider<CategoryDetailItemBloc>(create: (context) => CategoryDetailItemBloc(sl())),

        BlocProvider<InQueueListProductCubit<InQueueProduct>>(create: (context) => InQueueListProductCubit<InQueueProduct>()),

        BlocProvider<InSelectListProductCubit>(
          create: (context) => InSelectListProductCubit(
            inQueueListProductCubit: context.read<InQueueListProductCubit<InQueueProduct>>(),
          ),
        ),

        BlocProvider(
          create: (context) => MembershipCubit(
            [Membership.none(), Membership.gold(), Membership.platinum(), Membership.diamond()][Random().nextInt(4)],
          ),
        ),
        BlocProvider(create: (context) => CouponDeliveryDiscountCubit()),

        BlocProvider<DeliveryCostCubit>(create: (context) => DeliveryCostCubit()),
        BlocProvider<ProductSelectCubit>(create: (context) => ProductSelectCubit()),
        BlocProvider<DeliveryDiscountCubit>(
          create: (context) => DeliveryDiscountCubit(
            couponDeliveryDiscountCubit: context.read<CouponDeliveryDiscountCubit>(),
            membershipCubit: context.read<MembershipCubit>(),
          ),
        ),
        BlocProvider<TokenDiscountCubit>(create: (context) => TokenDiscountCubit()),
        BlocProvider<CouponProductDiscountCubit>(create: (context) => CouponProductDiscountCubit()),

        // TotalCostCubit phụ thuộc vào nhiều Cubit
        BlocProvider(
          create: (context) => TotalCostCubit(
            productSelectCubit: context.read<ProductSelectCubit>(),
            inQueueListProductCubit: context.read<InQueueListProductCubit<InQueueProduct>>(),
            inSelectProductCubit: context.read<InSelectListProductCubit>(),
            deliveryCostCubit: context.read<DeliveryCostCubit>(),
            deliveryDiscountCubit: context.read<DeliveryDiscountCubit>(),
            couponProductDiscountCubit: context.read<CouponProductDiscountCubit>(),
            tokenDiscountCubit: context.read<TokenDiscountCubit>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Product.getRandomProduct();
    context.read<ProductSelectCubit>().updateProduct(
          ProductSelect(
            product: product,
            select: 0,
          ),
        );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomAppTheme().lightTheme,
      darkTheme: CustomAppTheme().darkTheme,
      themeMode: ThemeMode.system,
      home: const ProductFilterPage(tagFilter: 'beef_chuck'),
    );
  }
}
