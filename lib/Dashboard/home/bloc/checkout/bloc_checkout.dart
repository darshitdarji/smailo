import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/checkout/event_checkout.dart';
import 'package:smailo/Dashboard/home/bloc/checkout/state_checkout.dart';
import 'package:smailo/model/home/checkout/checkout_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitialState()) {
    on<FetchCheckoutEvent>((event, emit) async {
      emit(CheckoutLoadingState());
      final CheckoutListModel model = await fetchDataFromApi(
          userAddressId: event.UserAddressId,
          couponId: event.couPonId,
          offerDiscount: event.offerDiscount,
          totalAmount: event.totalAmount,
          totalDiscount: event.totalDiscount,
      );
      try {
        if (model.status == 200) {
          emit(
            CheckoutLoadedState(checkoutList: model),
          );
        } else {
          emit(
            CheckoutErrorState(
                error: 'An error Occurred While The Fetching Data From APi'),
          );
        }
      } catch (error) {
        print("checkout error${error}");
        emit(
          CheckoutErrorState(error: 'An error Occurred'),
        );
      }
    });
  }

  fetchDataFromApi({
    required String userAddressId,
    required String couponId,
    required String totalDiscount,
    required String totalAmount,
    required String offerDiscount,
  }) async {
    CheckoutListModel model;
    Map data = {
      'user_id': '610',
      'user_address_id': userAddressId,
      'coupon_id': couponId,
      'payment_type': '1',
      'total_discount': totalDiscount,
      'total_amount': totalAmount,
      'offer_discount': offerDiscount,
      'transaction_id': '',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}checkOut";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri, body: data);
    model = CheckoutListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
