import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/event_save_remove_wish.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/state_save_remove_wish.dart';
import 'package:smailo/model/home/removewish/removewish_model.dart';
import 'package:smailo/model/home/savewish/savewish_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SaveAndRemoveWishBloc
    extends Bloc<SaveAndRemoveWishEvent, SaveAndRemoveWishState> {
  SaveAndRemoveWishBloc() : super(SaveToWishInitialState()) {
    on<FetchSaveWishEvent>(
      (event, emit) async {
        emit(SaveToWishLoadingState());
        try {
          SaveWishListModel model = await saveFetchDataFromApi(
            productId: event.productId,
          );
          if (model.status == 200) {
            emit(
              SaveToWishLoadedState(saveWishList: model),
            );
          } else {
            emit(
              SaveToWishErrorState(
                error: 'An error occurred while fetching data from API',
              ),
            );
          }
        } catch (error) {
          print("error in addfav ${error}");
          emit(
            SaveToWishErrorState(error: 'an error occurred'),
          );
        }
      },
    );
    on<FetchRemoveWishEvent>((event, emit) async {
      emit(SaveToWishLoadingState());
      try {
        RemoveWishListModel model = await removeFetchDataFromApi(
          wishListId: event.wishListId,
        );
        if (model.status == 200) {
          emit(
            RemoveToWishLoadedState(removeWishList: model),
          );
        } else {
          emit(
            RemoveToWishErrorState(
              error: 'An error occurred while fetching data from API',
            ),
          );
        }
      } catch (error) {
        print("error in removefav ${error}");

        emit(
          RemoveToWishErrorState(error: 'an error acurred'),
        );
      }
    });
  }

  saveFetchDataFromApi({required String productId}) async {
    SaveWishListModel model;
    Map data = {
      'product_id': productId,
      'user_id': '3',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}saveWish";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri, body: data);
    model = SaveWishListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }

  removeFetchDataFromApi({required String wishListId}) async {
    RemoveWishListModel model;
    Map data = {
      'wishlist_id': wishListId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}removeWish";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri, body: data);
    model = RemoveWishListModel.fromJsonMap(jsonDecode(response.body),);
    print("Success");
    return model;
  }
}
