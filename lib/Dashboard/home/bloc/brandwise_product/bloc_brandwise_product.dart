import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/brandwise_product/event_brandwise_product.dart';
import 'package:smailo/Dashboard/home/bloc/brandwise_product/state_brandwise_product.dart';
import 'package:smailo/model/home/brandwise_product_model/brandwise_product_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class BrandWiseBloc extends Bloc<BrandWiseEvent, BrandWiseState> {
  BrandWiseBloc() : super(BrandwiseInitialState()) {
    on<FetchBrandwiseEvent>((event, emit) async {
      emit(BrandwiseLoadingState());
      try {
        BrandWiseListModel model =
            await fetchDataFromApi(brandId: event.brandId);
        if (model.status == 200) {
          emit(BrandwiseLoadedState(brandWiseList: model));
        } else {
          emit(
            BrandwiseErrorState(
                error: 'An error occurred while fetching data from API'),
          );
        }
      } catch (error) {
        emit(
          BrandwiseErrorState(error: 'An error Occurred'),
        );
      }
    });
  }

  fetchDataFromApi({required String brandId}) async {
    BrandWiseListModel model;

    Map data = {
      'brand_id': brandId,
      'user_id': '1760',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}brandWiseProduct";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    // print("response${response.body}");

    model = BrandWiseListModel.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );
    return model;
  }
}
