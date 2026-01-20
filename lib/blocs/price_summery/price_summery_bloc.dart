import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_template/blocs/price_summery/price_summery_event.dart';
import 'package:flutter_bloc_template/blocs/price_summery/price_summery_state.dart';
import 'package:flutter_bloc_template/core/utils/widget/snackbar.dart';

class PriceSummaryBloc extends Bloc<PriceSummaryEvent, PriceSummaryState> {
  PriceSummaryBloc() : super(PriceSummaryState.initial()) {
    on<PriceSummeryInitEvent>(_onPriceSummaryInit);
    on<ApplyCouponEvent>(_onApplyCoupon);
    on<RemoveCouponEvent>(_onRemoveCoupon);
  }

  // offer flat 20% of subTotal
  /// price summary calculation
  void _onPriceSummaryInit(PriceSummeryInitEvent event, Emitter<PriceSummaryState> emit) {
    final offer = event.subtotal * 0.20;
    final total = event.subtotal - offer;
    emit(state.copyWith(subtotal: event.subtotal, offer: offer, couponDiscountAmount: 0, total: total, couponCode: ''));
  }

  /// coupon apply
  String couponCode = "habib"; // default coupon code
  double couponDiscountPercentage = 3.37; // default coupon discount percentage
  void _onApplyCoupon(ApplyCouponEvent event, Emitter<PriceSummaryState> emit) {
    if (event.couponCode != couponCode) {
      AppSnackBar.warning("Not eligible");
      return;
    }

    final couponDiscount = (state.subtotal - state.offer) * 0.037;
    final total = state.subtotal - state.offer - couponDiscount;
    emit(state.copyWith(couponDiscountAmount: couponDiscount, total: total, couponCode: event.couponCode));
  }

  /// coupon remove
  void _onRemoveCoupon(RemoveCouponEvent event, Emitter<PriceSummaryState> emit) {
    final total = state.subtotal - state.offer;
    emit(state.copyWith(couponDiscountAmount: 0, total: total, couponCode: ''));
  }

  /// save calculation
  double saveCalculation(double offerAmount, double couponDiscountAmount) {
    return offerAmount + couponDiscountAmount;
  }
}
