import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/address_list/bloc_address_List.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/address_list/event_address_list.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/address_list/state_address_list.dart';
import 'package:smailo/Dashboard/Profile%20Screen/orders%20of%20user/UpdateDailogbox.dart';
import 'package:smailo/Dashboard/Profile%20Screen/orders%20of%20user/removeDailogBox.dart';
import 'Orderdailogbox.dart';

class AddressScreen extends StatefulWidget {

  const AddressScreen({super.key, });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressListBloc>(
      create: (context) => AddressListBloc(),
      child: Address(),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class Address extends StatefulWidget {
  // final String addressId;

  Address({
    super.key,
    //required this.addressId,
  });

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  bool isDefaultAddress = false;
  SampleItem _selectedItem = SampleItem.itemOne;

  SampleItem get selectedItem => _selectedItem;
  SampleItem selectedMenu = SampleItem.itemOne;
  ScrollController controller = ScrollController();

  final List<Map<String, dynamic>> user_detail = [
    {'text': 'Default addresses'},
    {'text': 'Address'}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddressListBloc>(context).add(FetchAddressListEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.blue.shade900])),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white)),
        title: const Text("Addresses of Users",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      body: BlocBuilder<AddressListBloc, AddressListState>(
        builder: (context, state) {
          if (state is AddressListLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AddressListLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: mediaQuery.size.height * 0.15,
                    width: mediaQuery.size.width * 1,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Newadress();
                          },
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text("Add Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemCount: state.addressList.addressListData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          height: mediaQuery.size.height * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(
                                  1,
                                  6,
                                ),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 5,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Address : ",
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: mediaQuery.size.width * 0.01,
                                        ),
                                        Text(
                                            state.addressList
                                                .addressListData[index].address,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    PopupMenuButton<SampleItem>(
                                        onSelected: (SampleItem item) {
                                      setState(() {
                                        selectedMenu = item;
                                        if (item == SampleItem.itemTwo) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return UpdateDailogBox(
                                                addressId: state.addressList
                                                    .addressListData[index].id
                                                    .toString(),
                                                address: state
                                                    .addressList
                                                    .addressListData[index]
                                                    .address,
                                                city: state
                                                    .addressList
                                                    .addressListData[index]
                                                    .city,
                                                country: state
                                                    .addressList
                                                    .addressListData[index]
                                                    .country,
                                                isDefault: state
                                                    .addressList
                                                    .addressListData[index]
                                                    .isDefault
                                                    .toString(),
                                                mobileNo: state
                                                    .addressList
                                                    .addressListData[index]
                                                    .mobileNo,
                                                pinCode: state
                                                    .addressList
                                                    .addressListData[index]
                                                    .pincode
                                                    .toString(),
                                                states: state
                                                    .addressList
                                                    .addressListData[index]
                                                    .state,
                                              );
                                            },
                                          );
                                        }
                                        if (item == SampleItem.itemOne) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return RemoveDaiLogBox(addressId: state.addressList.addressListData[index].id.toString(),);
                                              });
                                        }
                                      });
                                    }, itemBuilder: (BuildContext context) {
                                      List<PopupMenuEntry<SampleItem>>
                                          menuItems = [];
                                      String? openType =
                                          user_detail[index]['text'];
                                      if (openType == 'Default addresses') {
                                        print('DEFAULT');
                                        menuItems.add(
                                          PopupMenuItem(
                                            value: SampleItem.itemTwo,
                                            child: Text('Edit'),
                                          ),
                                        );
                                        menuItems.add(
                                          PopupMenuItem<SampleItem>(
                                            value: SampleItem.itemOne,
                                            child: Text('Delete'),
                                          ),
                                        );
                                      } else {
                                        print('NOT DEFAULT');
                                        // Default address is not mentioned in the list
                                        menuItems.add(
                                          PopupMenuItem<SampleItem>(
                                            value: SampleItem.itemTwo,
                                            child: Text('Edit'),
                                          ),
                                        );
                                        menuItems.add(
                                          PopupMenuItem<SampleItem>(
                                            value: SampleItem.itemOne,
                                            child: Text('Delete'),
                                          ),
                                        );
                                        menuItems.add(
                                          PopupMenuItem<SampleItem>(
                                            value: SampleItem.itemTwo,
                                            child: Text('New Item 3'),
                                          ),
                                        );
                                      }
                                      return menuItems;
                                    })
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("City :",
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.01,
                                    ),
                                    Text(
                                        state.addressList.addressListData[index]
                                            .city,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("State : ",
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.01,
                                    ),
                                    Text(
                                        state.addressList.addressListData[index]
                                            .state,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Country :",
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.01,
                                    ),
                                    Text(
                                        state.addressList.addressListData[index]
                                            .country,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Postal code : ",
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.01,
                                    ),
                                    Text(
                                        state.addressList.addressListData[index]
                                            .pincode
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Phone : ",
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: mediaQuery.size.width * 0.01,
                                        ),
                                        Text(
                                          state.addressList
                                              .addressListData[index].mobileNo,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      user_detail[index]['text'],
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is AddressListErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }

  void Dailogbox() {}
}
