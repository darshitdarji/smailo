import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/offers/bloc/event_offers.dart';
import 'package:smailo/Dashboard/offers/bloc/state_offers.dart';
import 'package:smailo/model/offer/offer_model.dart';
import 'package:smailo/server_url/base_app_url.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(OfferInitialState()) {
    on<FetchOfferEvent>(
      (event, emit) async {
        emit(OfferLoadingState());
        OfferListModel model = await fetchDataFromApi();
        try {
          if (model.status == 200) {
            emit(
              OfferLoadedState(offerList: model),
            );
          } else {
            emit(
              OfferErrorState(
                  error: 'An error occurred while fetching data from API'),
            );
          }
        } catch (error) {
          emit(
            OfferErrorState(error: 'An error Occurred'),
          );
        }
      },
    );
  }

  fetchDataFromApi() async {
    OfferListModel model;
    Map data = {
      'user_id': '1760',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}offerList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = OfferListModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
