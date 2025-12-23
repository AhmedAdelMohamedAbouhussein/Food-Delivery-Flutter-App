abstract class PaymentState {}

class PaymentInitial extends PaymentState {
  final bool isCash;
  final String? cardLastFour;
  PaymentInitial({required this.isCash, this.cardLastFour});
}