/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';
abstract class PaymentReviewScreenEvent extends Equatable{
  const PaymentReviewScreenEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentMethodEvent extends PaymentReviewScreenEvent{

}

class OrderReviewEvent extends PaymentReviewScreenEvent{
 final int shippingAddressId;
 final int acquirerId;
 final int shippingId;

 const OrderReviewEvent(this.shippingAddressId,this.acquirerId,this.shippingId);

 @override
 List<Object> get props => [];
}
class ApplyCouponCodeEvent extends PaymentReviewScreenEvent{
 final String coupon;

 const ApplyCouponCodeEvent(this.coupon);

 @override
 List<Object> get props => [];
}
class RemoveCouponCodeEvent extends PaymentReviewScreenEvent{
  final int lineId;
 const RemoveCouponCodeEvent(this.lineId);

 @override
 List<Object> get props => [];
}

class PlaceOrderEvent extends PaymentReviewScreenEvent{
  final String paymentRefrence;
  final int transactionId;
  final String paymentStatus;

  const PlaceOrderEvent(this.paymentRefrence,this.transactionId,this.paymentStatus);

  @override
  List<Object> get props => [];
}