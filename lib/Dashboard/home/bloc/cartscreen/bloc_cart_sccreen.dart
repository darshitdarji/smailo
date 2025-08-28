import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/event_cart_screen.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/state_cart_screen.dart';
import 'package:smailo/model/home/cart_creen/cart_model.dart';
import 'package:smailo/server_url/base_app_url.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<FetchCartEvent>(
      (event, emit) async {
        emit(CartLoadingState());
        try {
          CartListModel model = await fetchDataFromApi();
          if (model.status == 200) {
            emit(
              CartLoadedState(
                cartList: model,
              ),
            );
          } else {
            emit(
              CartErrorState(
                error: "An error occurred while fetching data from API",
              ),
            );
          }
        } catch (error) {
          print('error----->$error');
          emit(
            CartErrorState(
              error: 'an error acurred',
            ),
          );
        }
      },
    );
  }

  fetchDataFromApi() async {
    CartListModel model;
    Map data = {
      'user_id': '1760',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}cartList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = CartListModel.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );
    return model;
  }
}
