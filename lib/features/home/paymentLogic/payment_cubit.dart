import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial(isCash: true));

  void selectCash() => emit(PaymentInitial(isCash: true));

  void selectCard(String lastFour) {
    emit(PaymentInitial(isCash: false, cardLastFour: lastFour));
  }
}