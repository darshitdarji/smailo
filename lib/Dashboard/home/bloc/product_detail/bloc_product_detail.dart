import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/product_detail/event_product_detail.dart';
import 'package:smailo/Dashboard/home/bloc/product_detail/state_product_detail.dart';
import 'package:smailo/model/home/product_details/product_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:smailo/server_url/base_app_url.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitialState()) {
    on<FetchProductDetailEvent>(
      (event, emit) async {
        emit(ProductDetailLoadingState());
        try {
          ProductDetailListModel model = await FetchDataFromAPi(productId: event.productId);


          if (model.status == 200) {
            print("Pending status ${model.status}");

            emit(
              ProductDetailLoadedState(
                productList: model,
              ),
            );
          } else {
            emit(
              ProductDetailErrorState(
                error: "An error occurred while fetching data from API",
              ),
            );
          }
        } catch (error) {
print("Pendingorder ${error}");
          emit(
            ProductDetailErrorState(
              error: "An Error Occurred",
            ),
          );
        }
      },
    );
  }

  FetchDataFromAPi({required String productId}) async {
    final ProductDetailListModel model;
    Map data = {
      'product_id':productId,
      'user_id': '610',
    };
    const apiurl = "${SchoolEcommBaseAppUrl.baseAppUrl}productDetail";
    final Uri url = Uri.parse(apiurl);
    final response = await http.post(url, body:  data );

    model = ProductDetailListModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
