import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_cooking/config/theme/app_theme.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/app_coupon_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/category_detail_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/app_coupon_repositery.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_repository.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/app_coupon_usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/category_detail_usecase.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/category_detail/category_detail_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/category_detail_item/category_detail_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/product/product_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/another_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/app_coupon/app_coupon_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';
import 'features/marketplace/data/repositories/category_detail_item_repository_impl.dart';
import 'features/marketplace/domain/repositories/product_repository.dart';
import 'features/marketplace/domain/repositories/category_detail_item_repository.dart';
import 'features/marketplace/domain/usecases/category_detail_item_usecase.dart';
import 'features/marketplace/domain/usecases/product_usecase.dart';
import 'features/marketplace/presentation/cubit/discount_value_cubit.dart';
import 'features/marketplace/presentation/cubit/product_manager_cubit.dart';

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
  sl.registerSingleton<AppCouponRepository>(AppCouponRepositoryImpl(sl()));
  sl.registerSingleton<AppCouponUseCase>(AppCouponUseCase(sl()));
  sl.registerFactory<AppCouponCubit>(() => AppCouponCubit(sl()));
}

void main() async {
  await initializeDependency();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create: (context) => ProductBloc(sl())),
        BlocProvider<CategoryDetailBloc>(create: (context) => CategoryDetailBloc(sl())),
        BlocProvider<CategoryDetailItemBloc>(create: (context) => CategoryDetailItemBloc(sl())),
        BlocProvider<AppCouponCubit>(create: (context) => AppCouponCubit(sl())),

        BlocProvider<InQueueListProductCubit<InQueueProduct>>(create: (context) => InQueueListProductCubit<InQueueProduct>()),

        BlocProvider<ProductDiscountCubit>(
          create: (context) => ProductDiscountCubit(
            inQueueListProductCubit: context.read<InQueueListProductCubit<InQueueProduct>>(),
          ),
        ),
        BlocProvider<InSelectProductCubit>(
          create: (context) => InSelectProductCubit(
            inQueueListProductCubit: context.read<InQueueListProductCubit<InQueueProduct>>(),
          ),
        ),

        // Khởi tạo các Cubit khác
        BlocProvider<DeliveryCostCubit>(create: (context) => DeliveryCostCubit()),
        BlocProvider<ProductSelectCubit>(create: (context) => ProductSelectCubit()),
        BlocProvider<DeliveryDiscountCubit>(create: (context) => DeliveryDiscountCubit()),
        BlocProvider<SaleDiscountCubit>(create: (context) => SaleDiscountCubit()),
        BlocProvider<TokenDiscountCubit>(create: (context) => TokenDiscountCubit()),
        BlocProvider<AppDiscountCubit>(create: (context) => AppDiscountCubit()),

        // AnotherDiscountCubit phụ thuộc vào các Cubit khác
        BlocProvider(
          create: (context) => AnotherDiscountCubit(
            productDiscountCubit: context.read<ProductDiscountCubit>(),
            saleDiscountCubit: context.read<SaleDiscountCubit>(),
            appDiscountCubit: context.read<AppDiscountCubit>(),
            tokenDiscountCubit: context.read<TokenDiscountCubit>(),
          ),
        ),

        // TotalCostCubit phụ thuộc vào nhiều Cubit
        BlocProvider(
          create: (context) => TotalCostCubit(
            productSelectCubit: context.read<ProductSelectCubit>(),
            inQueueListProductCubit: context.read<InQueueListProductCubit<InQueueProduct>>(),
            inSelectProductCubit: context.read<InSelectProductCubit>(),
            deliveryCostCubit: context.read<DeliveryCostCubit>(),
            deliveryDiscountCubit: context.read<DeliveryDiscountCubit>(),
            anotherDiscountCubit: context.read<AnotherDiscountCubit>(),
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
    context.read<ProductSelectCubit>().updateValue(
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
      //home: const ProductFilterPage(tagFilter: 'beef_chuck'),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: CouponCard(
              height: 120,
              curveAxis: Axis.vertical,
              curvePosition: 120,
              backgroundColor: Colors.white,
              border: const BorderSide(width: 7, color: Color.fromARGB(255, 4, 135, 241)),
              firstChild: Container(
                margin: const EdgeInsets.only(right: 1),
                alignment: Alignment.center,
                color: Colors.lightBlue.withOpacity(.7),
                child: Image.asset(
                  'assets/images/discount.png',
                  color: Colors.white,
                  height: 50,
                  width: 50,
                ),
              ),
              secondChild: Container(
                margin: const EdgeInsets.only(left: 1),
                padding: const EdgeInsets.all(15),
                height: double.maxFinite,
                color: Colors.lightBlueAccent.withOpacity(.5),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply For Every Deal',
                      style: TextStyle(
                        color: Color(0xff5f716f),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '1\$ DISCOUNT',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Valid Till - 30 Dec 2024',
                      style: TextStyle(
                        color: Color(0xff758e8c),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
