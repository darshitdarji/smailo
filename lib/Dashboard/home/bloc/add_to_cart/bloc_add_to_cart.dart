import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/state_add_to_cart.dart';
import 'package:smailo/model/home/add_to_cart/addtocart_model.dart';
import 'package:smailo/model/home/remove_cart/remove_cart_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  AddToCartBloc() : super(AddToCartInitialState()) {
    on<FetchAddToCartEvent>(
      (event, emit) async {
        emit(AddToCartLoadingState());
        try {
          final AddToCartListModel model = await FetchDataFromApi(
              productId: event.productId, quantity: event.quantity);
          if (model.status == 200) {
            emit(
              AddToCartLoadedState(
                addToCartList: model,
              ),
            );
          } else {
            emit(
              AddToCartErrorState(
                error: 'An error occurred while fetching data from API',
              ),
            );
          }
        } catch (error) {
          emit(
            AddToCartErrorState(error: 'An error Occurred'),
          );
        }
      },
    );
    on<FetchRemoveToCartEvent>(
          (event, emit) async {
        emit(AddToCartLoadingState());
        try {
          final RemoveToCartListModel model = await FetchRemoveDataFromApi(
            productId: event.productId,
          );
          if (model.status == 200) {
            emit(
              RemoveToCartLoadedState(removeToCartList: model),
            );
          } else {
            emit(
              RemoveToCartErrorState(
                error: 'An error occurred while fetching data from API',
              ),
            );
          }
        } catch (error) {
          emit(
            RemoveToCartErrorState(error: 'An error Occurred'),
          );
        }
      },
    );

  }

  FetchDataFromApi(
      {required String productId, required String quantity}) async {
    AddToCartListModel model;
    Map data = {
      'user_id': '610',
      'product_id': productId,
      'qty': quantity,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}addToCart";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = AddToCartListModel.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );
    return model;
  }

  FetchRemoveDataFromApi({
    required String productId,
  }) async {
    RemoveToCartListModel model;
    Map data = {
      'user_id': '610',
      'product_id': productId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}removeCart";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = RemoveToCartListModel.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );
    return model;
  }
}
