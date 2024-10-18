import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/app_coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/app_coupon_usecase.dart';

part 'app_coupon_state.dart';

class AppCouponCubit extends Cubit<AppCouponState> {
  AppCouponUseCase appCounponUseCase;
  List<AppCouponEntity>? listCoupon;
  AppCouponCubit(this.appCounponUseCase) : super(const AppCouponInitial());

  Future fetchListCoupon() async {
    emit(const AppCouponLoading());
    if (listCoupon == null) {
      final data = await appCounponUseCase();
      data.fold(
        (error) {
          emit(const AppCouponException());
        },
        (list) {
          listCoupon = list;
          emit(AppCouponLoaded(listCoupon!));
        },
      );
    } else {
      emit(AppCouponLoaded(listCoupon!));
    }
  }
}
