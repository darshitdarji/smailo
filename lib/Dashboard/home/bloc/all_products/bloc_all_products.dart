import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/event_all_products.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/state_all_products.dart';
import 'package:smailo/model/home/all_products/all_products_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsInitialState()) {
    on<FetchAllProductEvent>((event, emit) async {
      emit(
        AllProductsLoadingState(),
      );
      try {
        AllProductsListModel model = await fetchDataFromApi(filterPrice: event.filterPrice, filterShortBy: event.filterShortBy);
        if (model.status == 200) {
          emit(AllProductsLoadedState(allProductsList: model));
        } else {
          emit(
            AllProductsErrorState(
              error: 'An error occurred while fetching data from API',
            ),
          );
        }
      } catch (error) {
        emit(
          AllProductsErrorState(
            error: "An error Occurred",
          ),
        );
      }
    });
  }

  fetchDataFromApi({required String filterPrice, required String filterShortBy}) async {
    AllProductsListModel model;
    Map data = {
      "filter_sort_by":filterShortBy,
      "filter_price":filterPrice,
      "user_id" : "3",
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}allProduct";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = AllProductsListModel.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );

    return model;
  }
}
