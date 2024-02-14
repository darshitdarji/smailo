import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/flash_deal/event_flash_deal.dart';
import 'package:smailo/Dashboard/home/bloc/flash_deal/state_flash_deal.dart';
import 'package:smailo/model/home/flash_deal/flash_deal_model.dart';
import 'package:smailo/server_url/base_app_url.dart';

class FlashDealBloc  extends Bloc<FlashDealEvent,FlashDealState>{
  FlashDealBloc():super(FlashDealInitialState()){
    on<FetchFlashDealEvent>((event, emit)async{
      emit(FlashDealLoadingState());
      try{
        FlashDealModel model = await FetchDatafromApi();
        if(model.status == 200  ){
          emit(FlashDealLoadedState(flashDealModel:  model));
        }else{

          emit(FlashDealErrorState(
              error: "An error occurred while fetching data from API"));
        }
      }catch(error){
        print("error in flash Deal${error}");
        emit(FlashDealErrorState(error: "An Error Occurred"));
      }

    });
  }
  FetchDatafromApi()async{
    FlashDealModel model;
    Map data = {
      'user_id': '3',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}flashDeal";
  final Uri url  = Uri.parse(apiUrl);
    final response = await http.post(url ,body: data);

    model = FlashDealModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}