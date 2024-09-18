import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/remove_address/bloc_remove_address.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/remove_address/event_remove_address.dart';

class RemoveDaiLogBox extends StatefulWidget {
  final String addressId;

  const RemoveDaiLogBox({super.key, required this.addressId});

  @override
  State<RemoveDaiLogBox> createState() => _RemoveDaiLogBoxState();
}

class _RemoveDaiLogBoxState extends State<RemoveDaiLogBox> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoveAddressBloc>(
      create: (context) => RemoveAddressBloc(), child: RemoveDaiLogBoxPage(addressId: widget.addressId,),);
  }
}


class RemoveDaiLogBoxPage extends StatefulWidget {
  final String addressId;

  const RemoveDaiLogBoxPage({super.key, required this.addressId});

  @override
  State<RemoveDaiLogBoxPage> createState() => _RemoveDaiLogBoxPageState();
}

class _RemoveDaiLogBoxPageState extends State<RemoveDaiLogBoxPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      insetPadding: EdgeInsets.all(0),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      title: Text("Confirm"),
      content: Text("Are you sure you wish to delete \nthis address?"),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(70, 35),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () {
              BlocProvider.of<RemoveAddressBloc>(context).add(
                FetchRemoveAddressEvent(addressId: widget.addressId),);
              Navigator.pop(context);
            },
            child: Text(
              "DELETE",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(70, 35),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("CANCEL",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)))
      ],
    );
  }
}
