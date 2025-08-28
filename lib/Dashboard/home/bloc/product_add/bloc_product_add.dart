import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/product_add/event_product_add.dart';
import 'package:smailo/Dashboard/home/bloc/product_add/state_product_add.dart';
import 'package:smailo/model/home/product_add/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:smailo/server_url/base_app_url.dart';

class ProductAddBloc extends Bloc<ProductAddEvent, ProductAddState> {
  ProductAddBloc() : super(ProductAddInitialState()) {
    on<FetchProductAdd>(
      (event, emit) async {
        emit(ProductAddLoadingState());
        try {
          ProductListModel model = await FetchDataFromApi(
            standardId: event.standardId,
          );
          if (model.status == 200) {
            emit(ProductAddLoadedState(productList: model));
          } else {
            emit(
              ProductAddErrorState(
                error: "An error occurred while fetching data from API",
              ),
            );
          }
        } catch (error) {
          emit(
            ProductAddErrorState(
              error: "An Error Occurred",
            ),
          );
        }
      },
    );
  }

  FetchDataFromApi({required String standardId}) async {
    ProductListModel model;
    Map data = {
      'standard_id': standardId,
      'user_id': '1760',
    };
    const apiurl = "${SchoolEcommBaseAppUrl.baseAppUrl}categoryWiseProduct";
    final Uri url = Uri.parse(apiurl);
    final response = await http.post(url, body: data);

    model = ProductListModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
